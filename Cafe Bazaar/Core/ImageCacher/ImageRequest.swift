//
//  AnyRequest.swift
//  Cafe Bazaar
//
//  Created by Farshad Jahanmanesh on 12/21/19.
//  Copyright © 2019 Farshad Jahanmanesh. All rights reserved.
//

import Foundation
struct ImageRequest: Request {
	typealias ResultType = Data
	var acceptCache: Bool = true
	let url: URL
	func asURLRequest() throws -> URLRequest {
		try RequestBuilder.init(url: url).asURLRequest()
	}
}
