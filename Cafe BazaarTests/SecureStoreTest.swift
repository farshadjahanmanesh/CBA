//
//  SecureStore.swift
//  Cafe BazaarTests
//
//  Created by Farshad Jahanmanesh on 12/20/19.
//  Copyright © 2019 Farshad Jahanmanesh. All rights reserved.
//

import XCTest
@testable import Cafe_Bazaar
extension PersistentManager.Key {
	static let test1 = PersistentManager.Key.init(rawValue: "test1")
	static let test2 = PersistentManager.Key.init(rawValue: "test2")
	static let test3 = PersistentManager.Key.init(rawValue: "test3")
	static let test4 = PersistentManager.Key.init(rawValue: "test4")
}
class SecureStoreTest: XCTestCase {

    var sut: SecureDataStore?

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
	}
	func testSubscript() {
		sut![.test4] =  TestResultType.init(family: "subscript")
		let model: TestResultType? = sut![.test4]
		XCTAssertEqual(model!.family, "subscript")
	}
	
	func testDelete() {
		sut![.test4] =  TestResultType.init(family: "subscript")
		let model: TestResultType? = sut![.test4]
		XCTAssertEqual(model!.family, "subscript")
		sut!.remove(for: .test4)
		let deleted: TestResultType? = sut![.test4]
		XCTAssertNil(deleted)
	}
}
