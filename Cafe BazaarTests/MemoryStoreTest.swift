//
//  MemoryStore.swift
//  Cafe BazaarTests
//
//  Created by Farshad Jahanmanesh on 12/19/19.
//  Copyright © 2019 Farshad Jahanmanesh. All rights reserved.
//

import Foundation
import XCTest
@testable import Cafe_Bazaar
extension PersistentManager.Key {
	static let test1 = PersistentManager.Key.init(rawValue: "test1")
	static let test2 = PersistentManager.Key.init(rawValue: "test2")
	static let test3 = PersistentManager.Key.init(rawValue: "test3")
	static let test4 = PersistentManager.Key.init(rawValue: "test4")
}
class MemoryStoreTests: XCTestCase {
	var sut: MemoryStore?

	override func setUp() {
		sut = .init()
	}
	
	override func tearDown() {
		sut = nil
	}
	
	// cases
	func testStoreData() {
		sut!.set(data: TestResultType.init(family: "test1"), for: .test1)
		sut!.set(data: TestResultType.init(family: "test2"), for: .test2)
		sut!.set(data: TestResultType.init(family: "test3"), for: .test3)
		sut!.set(data: TestResultType.init(family: "test4"), for: .test4)
		
		let model: TestResultType? = sut?.get(for: .test1)
		let model2: TestResultType? = sut?.get(for: .test3)
		XCTAssertNotNil(model)
		XCTAssertNotNil(model2)
		XCTAssertEqual(model2!.family, "test3")
	}
	
	func testSubscript() {
		sut![.test4] =  TestResultType.init(family: "subscript")
		let model: TestResultType? = sut![.test4]
		XCTAssertEqual(model!.family, "subscript")
	}
}
