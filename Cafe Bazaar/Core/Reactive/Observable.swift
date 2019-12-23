//
//  Observable.swift
//  Cafe Bazaar
//
//  Created by Farshad Jahanmanesh on 12/17/19.
//  Copyright © 2019 Farshad Jahanmanesh. All rights reserved.
//

import Foundation
class Observable<Value>: ObservableType  {
	typealias OnSubscribe = (()->Void)
	typealias E = Value
	private lazy var observers: [AnyObserver<Value>] = {[]}()
	private var onSubscribe: OnSubscribe? = nil
	private var lock: NSRecursiveLock = .init()
	private(set) var value: Value {
		didSet {
			lock.lock();defer{lock.unlock()}
			observers.forEach { (observer) in
				observer.next(element: .next(value))
			}
		}
	}
	
	func set(_ value: Value){
		self.value = value
	}
	
	init(_ value: Value) {
		self.value = value
	}
	
	func subscribe<Observer>(observer: Observer) -> Disposable where Observer : ObserverType, Value == Observer.E {
		lock.lock()
		defer {self.onSubscribe?();lock.unlock()}
		let anyObserver = AnyObserver(observer)
		self.observers.append(anyObserver)
		return anyObserver
	}
	
	func on(subscribe: @escaping OnSubscribe) -> Self {
		self.onSubscribe = subscribe
		return self
	}
}

extension Observable {
	func subscribe<O: AnyObserver<Observable.E>>(_ callback: @escaping Callback<Value>) -> Disposable {
		lock.lock()
		defer {self.onSubscribe?();lock.unlock()}
		let anyObserver = AnyObserver(Observer.init(callback))
		self.observers.append(anyObserver)
		return anyObserver
	}
}
