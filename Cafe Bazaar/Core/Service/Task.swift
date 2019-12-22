//
//  Task.swift
//  Cafe Bazaar
//
//  Created by Farshad Jahanmanesh on 12/17/19.
//  Copyright © 2019 Farshad Jahanmanesh. All rights reserved.
//

import Foundation
protocol Task: class {
	func start()
	func stop()
	func dieHard()
}

extension URLSessionDataTask: Task {
	func start() {
		self.resume()
	}
	func stop() {
		self.cancel()
	}
	/// no one can kill me (except OS) -\(*.*)/-
	func dieHard() {
	}
}
