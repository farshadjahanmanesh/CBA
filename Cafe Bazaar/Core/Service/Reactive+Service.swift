//
//  Reactive+Service.swift
//  Cafe Bazaar
//
//  Created by Farshad Jahanmanesh on 12/18/19.
//  Copyright © 2019 Farshad Jahanmanesh. All rights reserved.
//

import Foundation

extension Service {
	var asObservable: Observable<Result<Self.ResultType, Self.ErrorType>?> {
		let observable = Observable<Result<Self.ResultType, Self.ErrorType>?>.init(nil)
		let task = self.run { (result, done) in
			observable.set(result)
		}
		return observable.on {
			task.start()
		}
	}
}

extension Result {
	var success: Success? {
		guard case let .success(value) = self else {
			return nil
		}
		return value
	}
}



