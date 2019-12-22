//
//  MemoryService.swift
//  Cafe Bazaar
//
//  Created by Farshad Jahanmanesh on 12/19/19.
//  Copyright © 2019 Farshad Jahanmanesh. All rights reserved.
//

import Foundation
import CommonCrypto

class MemoryStore: DataStore {
	private lazy var store: [PersistentManager.Key: Codable] = {[:]}()
	func set<Value>(data: Value, for key: PersistentManager.Key) where Value : Decodable, Value : Encodable {
		store[key] = data
	}
	
	func get<Value>(for key: PersistentManager.Key) -> Value? where Value : Decodable, Value : Encodable {
		return store[key] as? Value
	}
}

struct PersistentManager {
	struct WrapperObject<Value: Codable>: Codable {
		let value: Value
	}
	struct Key: RawRepresentable, Hashable {
		var rawValue: String
		init(rawValue: String) {
			self.rawValue = rawValue
		}
	}
}
