//
//  DisposeBag.swift
//  Cafe Bazaar
//
//  Created by Farshad Jahanmanesh on 12/18/19.
//  Copyright © 2019 Farshad Jahanmanesh. All rights reserved.
//

import Foundation

class DisposeBag {
	let lock = NSRecursiveLock()
	private lazy var bag: [Disposable] = {[]}()
	func add(disposable: Disposable){
		lock.lock()
		defer {lock.unlock()}
		self.bag.append(disposable)
	}
	
	deinit {
		lock.lock()
		defer {lock.unlock()}
		self.bag.forEach { (disposable) in
				disposable.dispose()
		}
	}
}
