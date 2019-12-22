//
//  SimpleTask.swift
//  Cafe Bazaar
//
//  Created by Farshad Jahanmanesh on 12/17/19.
//  Copyright © 2019 Farshad Jahanmanesh. All rights reserved.
//

import Foundation
class SimpleTask: Task {
	let job: ()->Void
	func start() {
		job()
	}
	func stop() {}
	func dieHard() {}
	init(do job: @escaping ()->Void) {
		self.job = job
	}
}

