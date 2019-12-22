//
//  TimeoutInterval.swift
//  Cafe Bazaar
//
//  Created by Farshad Jahanmanesh on 12/17/19.
//  Copyright © 2019 Farshad Jahanmanesh. All rights reserved.
//

import Foundation

public struct TimeoutInterval: RawRepresentable {
	public typealias RawValue = Double
	
	public var rawValue: Double
	
	public init(rawValue: Double) {
		self.rawValue = rawValue
	}
	
}

extension TimeoutInterval: ExpressibleByFloatLiteral {
	public typealias FloatLiteralType = Double
	
	public init(floatLiteral: Double) {
		self.rawValue = floatLiteral
	}
}

public extension TimeoutInterval {
	static let `default`: TimeoutInterval = 15.0
}
