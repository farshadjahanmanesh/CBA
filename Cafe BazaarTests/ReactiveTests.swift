//
//  ReactiveTests.swift
//  Cafe BazaarTests
//
//  Created by Farshad Jahanmanesh on 12/19/19.
//  Copyright © 2019 Farshad Jahanmanesh. All rights reserved.
//

import XCTest
@testable import Cafe_Bazaar

class ObservableTests: XCTestCase {
	var sut: Observable<Int>?
	var disposeBag = DisposeBag()
	override func setUp() {
		sut = .init(0)
	}
	override func tearDown() {
		sut = nil
		disposeBag = DisposeBag()
	}
	
	
	// cases
	func testSubscribing() {
		let expect = expectation(description: "to run")
		
		sut!.subscribe { event in
			switch event {
			case .next(let value):
				XCTAssertEqual(value, 4)
				expect.fulfill()
			default: break
				
			}
		}.disposed(by: disposeBag)
		sut!.set(4)
		wait(for: [expect], timeout: 1)
	}
	
	// cases
	func testUpdateValue() {
		let expect = expectation(description: "to run")
		let given = [4,48,41,43,25,255,35,432,775,5886,3342,121]
		expect.expectedFulfillmentCount = given.count
		
		var result: [Int] = []
		sut!.subscribe { event in
			switch event {
			case .next(let value):
				result.append(value)
				expect.fulfill()
			default: break
				
			}
		}.disposed(by: disposeBag)
		
		given.forEach { (item) in
			sut!.set(item)
		}
		
		XCTAssertEqual(given, result)
		wait(for: [expect], timeout: 2)
	}
}
