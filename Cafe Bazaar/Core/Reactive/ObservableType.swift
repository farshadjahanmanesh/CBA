//
//  ObservableType.swift
//  Cafe Bazaar
//
//  Created by Farshad Jahanmanesh on 12/18/19.
//  Copyright © 2019 Farshad Jahanmanesh. All rights reserved.
//

import Foundation
typealias Callback<Value> = (Event<Value>)->Void
protocol ObservableType {
	associatedtype E
	func subscribe<Observer: ObserverType>(observer: Observer) -> Disposable where Self.E == Observer.E
}
