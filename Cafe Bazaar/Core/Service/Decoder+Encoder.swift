//
//  Decoder+Encoder.swift
//  Cafe Bazaar
//
//  Created by Farshad Jahanmanesh on 12/17/19.
//  Copyright © 2019 Farshad Jahanmanesh. All rights reserved.
//

import Foundation
protocol RestDataDecoder {
	func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable
}

protocol RestDataEncoder {
	func encode(value: Encodable) throws -> Data
}

extension JSONDecoder: RestDataDecoder {}
