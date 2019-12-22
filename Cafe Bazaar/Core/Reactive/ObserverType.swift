//
//  ObserverType.swift
//  Cafe Bazaar
//
//  Created by Farshad Jahanmanesh on 12/18/19.
//  Copyright © 2019 Farshad Jahanmanesh. All rights reserved.
//

import Foundation
protocol ObserverType {
	associatedtype E
	func next(element: Event<E>)
}
