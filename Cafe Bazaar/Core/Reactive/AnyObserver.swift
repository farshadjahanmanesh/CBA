//
//  AnyObserver.swift
//  Cafe Bazaar
//
//  Created by Farshad Jahanmanesh on 12/18/19.
//  Copyright © 2019 Farshad Jahanmanesh. All rights reserved.
//

import Foundation

/// type erasure of Observer type that hides its generic type
class AnyObserver<Value>: ObserverType, Disposable {
	typealias E = Value
	
	/// runs for each receiving event
	private var nextHandler: Callback<Value>?
	
	init<O: ObserverType>(_ observer: O) where O.E == Value {
		self.nextHandler = {event in observer.next(element: event)}
	}
	
	func next(element: Event<Value>) {
		nextHandler?(element)
	}
	
	func dispose() {
		nextHandler = nil
	}
}
