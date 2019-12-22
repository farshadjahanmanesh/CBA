//
//  Disposable.swift
//  Cafe Bazaar
//
//  Created by Farshad Jahanmanesh on 12/18/19.
//  Copyright © 2019 Farshad Jahanmanesh. All rights reserved.
//

import Foundation
protocol Disposable {
	func dispose()
}

extension Disposable {
	func disposed(by bag: DisposeBag) {
		bag.add(disposable: self)
	}
}
