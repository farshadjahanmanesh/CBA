//
//  RestService.swift
//  Cafe Bazaar
//
//  Created by Farshad Jahanmanesh on 12/17/19.
//  Copyright © 2019 Farshad Jahanmanesh. All rights reserved.
//

import Foundation
typealias JSON = String
class RestService<R:Request>: Service {
	
	typealias ResultType = R.ResultType
	typealias ErrorType = RestError
	private let session: URLSession
	private let decoder: RestDataDecoder
	private let configuration: URLSessionConfiguration
	private let request: R
	private let cacher: URLCache
	private let tokenProvider: TokenProvider
	private(set) var currentTask: Task? = nil
	
	init(session: URLSession = .shared,
		 decoder:RestDataDecoder = JSONDecoder(),
		 configuration: URLSessionConfiguration = .default,
		 cacher: URLCache = .shared,
		 tokenProvider: TokenProvider = DefaultTokenProvider(),
		 request: R) {
		self.session = session
		self.request = request
		self.decoder = decoder
		self.cacher = cacher
		self.configuration = configuration
		self.tokenProvider = tokenProvider
	}
	
	func tokenize(_ orphanRequest: URLRequest)->URLRequest{
		var request = orphanRequest
		guard request.value(forHTTPHeaderField: "Authorization") == nil, let token = tokenProvider.token else {
			return request
		}
		request.allHTTPHeaderFields?.updateValue(token, forKey: "Authorization")
		return request
	}
	
	private func createTask(callback: @escaping (Result<R.ResultType, RestError>, Bool) -> Void) -> Task {
		guard var urlRequest = try? request.asURLRequest() else {
			fatalError("Request is not correctly formatted.")
		}
		let cache = request.acceptCache
		if !cache {
			cacher.removeCachedResponse(for: urlRequest)
		}
		urlRequest = tokenize(urlRequest)
		#warning("TODO: need to rethink about this mock handler")
		#if DEBUG
		if let mockable = request as? Mockable {
			return SimpleTask.init {
				guard let data = mockable.mock.data(using: .utf8) ,let model = try? self.decoder.decode(ResultType.self, from: data) else {
					callback(.failure(.init(key: .decodeFaild)), true)
					return
				}
				callback(.success(model), true)
			}
		}
		#endif
		return self.session.dataTask(with: urlRequest) {(data, response, error) in
			
			guard let data = data else {
				if let error = error {
					callback(.failure(.init(key: .init(rawValue: error.localizedDescription))), true)
				} else {
					callback(.failure(.init(key: .unknown)), true)
				}
				return
			}
			guard let model: Container<R.ResultType> = try? self.decoder.decode(Container<R.ResultType>.self, from: data) else {
				if let data = data as? R.ResultType{
					callback(.success(data), true)
				} else {
					callback(.failure(.init(key: .decodeFaild)), true)
				}
				return
			}
			if cache {
				self.cacher.cachedResponse(for: urlRequest)
			}
			callback(.success(model.results), true)
		}
	}
	
	func run(callback: @escaping (Result<R.ResultType, RestError>, Bool) -> Void) -> Task {
		self.currentTask = createTask(callback: callback)
		return currentTask!
	}
}

