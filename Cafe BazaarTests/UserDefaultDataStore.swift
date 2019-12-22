//
//  UserDefaultDataStore.swift
//  Cafe BazaarTests
//
//  Created by Farshad Jahanmanesh on 12/20/19.
//  Copyright © 2019 Farshad Jahanmanesh. All rights reserved.
//

import XCTest
@testable import Cafe_Bazaar

class UserDefaultDataStoreTest: XCTestCase {
	var sut: UserDefaultStore?

	override func setUp() {
		sut = .init()
	}
	
	override func tearDown() {
		sut = nil
	}
	
	// cases
	func testStoreData() {
		let x = 22
		sut!.set(data: x, for: .test1)
		
		sut!.set(data: TestResultType.init(family: "test2"), for: .test2)
		let model: TestResultType? = sut?.get(for: .test2)
		let read: Int? = sut!.get(for: .test1)
		XCTAssertNotNil(read)
		XCTAssertEqual(read!, 22)
		XCTAssertEqual(model!.family, "test2")
	}

	func testSubscript() {
		sut![.test4] =  TestResultType.init(family: "subscript")
		let model: TestResultType? = sut![.test4]
		XCTAssertEqual(model!.family, "subscript")
	}
}
