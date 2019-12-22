//
//  Request.swift
//  Cafe Bazaar
//
//  Created by Farshad Jahanmanesh on 12/17/19.
//  Copyright © 2019 Farshad Jahanmanesh. All rights reserved.
//

import Foundation
protocol Request: URLRequestConvertible, Cachable {
	associatedtype ResultType: Decodable
}
