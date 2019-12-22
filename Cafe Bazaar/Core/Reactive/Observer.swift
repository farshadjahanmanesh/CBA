//
//  Observer.swift
//  Cafe Bazaar
//
//  Created by Farshad Jahanmanesh on 12/18/19.
//  Copyright © 2019 Farshad Jahanmanesh. All rights reserved.
//

import Foundation
class Observer<Value>: Disposable, ObserverType {
	typealias E = Value

	func dispose() {
		// release the captured item
		self.callback = nil
	}
	
	private var callback: Callback<Value>?
	init(_ callback: @escaping(Callback<Value>)) {
		self.callback = callback
	}
	func next(element: Event<Value>) {
		callback?(element)
	}
	
	deinit {
		self.dispose()
	}
}
