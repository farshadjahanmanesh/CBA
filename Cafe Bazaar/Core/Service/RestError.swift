//
//  RestError.swift
//  Cafe Bazaar
//
//  Created by Farshad Jahanmanesh on 12/17/19.
//  Copyright © 2019 Farshad Jahanmanesh. All rights reserved.
//

import Foundation
struct RestError: Error {
	let key: Key
	struct Key: RawRepresentable {
		var rawValue: String
	}
	var localizedDescription: String {
		key.rawValue
	}
}

extension RestError.Key {
	static let unknown: RestError.Key = .init(rawValue: "unknown")
	static let decodeFaild: RestError.Key = .init(rawValue: "unable_to_decode_the_result")
	static let cancelled: RestError.Key = .init(rawValue: "task_is_cancelled")
}
