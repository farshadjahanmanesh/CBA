//
//  RequestTest.swift
//  Cafe BazaarTests
//
//  Created by Farshad Jahanmanesh on 12/19/19.
//  Copyright © 2019 Farshad Jahanmanesh. All rights reserved.
//

import XCTest
@testable import Cafe_Bazaar
struct TestResultType: Codable {
	let family: String
}

class RequestBuilderTests: XCTestCase  {
	var sut: RequestBuilder?
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
		sut = RequestBuilder(url: URL(string: "https://google.com")!)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
		sut = nil
    }
	
	func testURL() {
		XCTAssertNotNil(try? sut!.asURLRequest())
	}
	
	func testBody() {
		let string = """
{"name": "ahmad"}
"""
		sut = sut!.set(body: string.data(using: .utf8)!)
		XCTAssertNotNil(try? sut?.asURLRequest().httpBody)
	}
	
	func testHeader() {
		sut = sut!.set(headers: ["test":"data"])
		let header = try! sut!.asURLRequest().allHTTPHeaderFields
		XCTAssertNotNil(header)
		XCTAssertNotNil(header!["test"])
	}
	
	func testMethod() {
		sut = sut!.set(method: .post)
		let method = try! sut!.asURLRequest().httpMethod
		XCTAssertNotNil(method)
		XCTAssertEqual(method!, HTTPMethod.post.rawValue)
	}
	
	func testEncodableMethod() {
		sut = try? sut!.set(encodable: TestResultType(family: "yahoo"))
		XCTAssertNotNil(sut)
		let data = try? sut!.asURLRequest().httpBody
		XCTAssertNotNil(data)
		let decoder = try? JSONDecoder().decode(TestResultType.self, from: data!)
		XCTAssertNotNil(decoder)
		XCTAssertEqual(decoder!.family, "yahoo")
	}
	
	func testQueryStringMethod() {
		sut = sut!.set(queryItems: [.init(name: "query", value: "music")])
		XCTAssertNotNil(sut)
		let query = try? sut!.asURLRequest().url?.query
		XCTAssertNotNil(query)
		XCTAssertEqual(query!, "query=music")
	}
	
	func testTimeIntervalMethod() {
		sut = sut!.set(timeoutInterval: .default)
		XCTAssertNotNil(sut)
		let timeout = try? sut!.asURLRequest().timeoutInterval
		XCTAssertNotNil(timeout)
		XCTAssertEqual(timeout!, TimeoutInterval.default.rawValue)
	}
	
}
