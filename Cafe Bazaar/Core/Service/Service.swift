//
//  Service.swift
//  Cafe Bazaar
//
//  Created by Farshad Jahanmanesh on 12/17/19.
//  Copyright © 2019 Farshad Jahanmanesh. All rights reserved.
//

import Foundation

/// as a service, it needs to run something and result something
protocol Service {
	associatedtype ResultType
	associatedtype ErrorType: Error
	@discardableResult
	func run(callback: @escaping (_ result: Result<ResultType, ErrorType>,_ isCompleted: Bool)-> Void) -> Task
}
