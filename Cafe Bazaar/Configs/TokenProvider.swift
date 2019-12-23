//
//  TokenProvider.swift
//  Cafe Bazaar
//
//  Created by Farshad Jahanmanesh on 12/21/19.
//  Copyright © 2019 Farshad Jahanmanesh. All rights reserved.
//

import Foundation


/// api token
protocol TokenProvider {
	var token: String? { get }
}

extension PersistentManager.Key {
	static let token: PersistentManager.Key = .init(rawValue: "api_token")
}

final class DefaultTokenProvider: TokenProvider {
	var dataStore: DataStore
	init(dataStore: DataStore = SecureDataStore()) {
		self.dataStore = dataStore
	}
    private var _token: String?
    var token: String? {
        get {
            if let _token = _token { return _token }
            _token = self.dataStore[.token]
            return _token
        } set {
			self.dataStore[.token] = newValue
            _token = newValue
        }
    }
}

