//
//  PopularRequest.swift
//  Cafe Bazaar
//
//  Created by Farshad Jahanmanesh on 12/17/19.
//  Copyright © 2019 Farshad Jahanmanesh. All rights reserved.
//

import Foundation

struct GetPopularPeoplesRequest: Request {
	let acceptCache: Bool = false
	typealias ResultType = Container<[PopularPeople]>
	
	let pageNumber: Int
	func asURLRequest() throws -> URLRequest {
		try RequestBuilder
			.init(path: "person/popular?page=\(pageNumber)")
			.asURLRequest()
	}
}

struct SearchPopularPeoplesRequest: Request {
	let acceptCache: Bool = false
	typealias ResultType = Container<[PopularPeople]>
	
	let pageNumber: Int
	let query: String
	func asURLRequest() throws -> URLRequest {
		try RequestBuilder
			.init(path: "search/person")
			.set(queryItems: [
				.init(name: "page", value: String(pageNumber)),
				.init(name: "query", value: query)
			])
			.asURLRequest()
	}
}

struct PeopleRequest: Request {
	let acceptCache: Bool = false
	typealias ResultType = People
	
	let peopleId: ID
	func asURLRequest() throws -> URLRequest {
		try RequestBuilder
			.init(path: "/person/\(peopleId)")
			.asURLRequest()
	}
}

struct PeoplePhotosRequest: Request {
	let acceptCache: Bool = false
	struct ResultType: Codable {
		let profiles: [PeoplePhoto]
	}
	
	let peopleId: ID
	func asURLRequest() throws -> URLRequest {
		try RequestBuilder
			.init(path: "/person/\(peopleId)/images")
			.asURLRequest()
	}
}
