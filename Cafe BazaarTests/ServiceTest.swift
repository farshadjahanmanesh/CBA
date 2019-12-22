//
//  ServiceTest.swift
//  Cafe BazaarTests
//
//  Created by Farshad Jahanmanesh on 12/19/19.
//  Copyright © 2019 Farshad Jahanmanesh. All rights reserved.
//

import XCTest
@testable import Cafe_Bazaar

class TestTask: URLSessionDataTask {
	override func resume() {
		print("Every Thing is fine")
	}
}

class TestSession: URLSession {
	var nextTask = TestTask()
	override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
		let json = """
{"name":"TEST"}
"""
		DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
			completionHandler(json.data(using: .utf8), nil, nil)
		}
		return nextTask
	}
}

struct TestSuccessRequest: Request {
	var acceptCache: Bool = true
	
	struct ResultType: Codable {
		let name: String
	}
	func asURLRequest() throws -> URLRequest {
		try RequestBuilder(url: URL(string: "https://google.com")!)
			.set(headers: ["Auth": "TEST"])
			.asURLRequest()
	}
}

class RestServiceTest: XCTestCase {
	var sut: RestService<TestSuccessRequest>?
	override func setUp() {
		sut = .init(session: TestSession(), request: .init())
	}
	override func tearDown() {
		sut = nil
	}
	
	
	// cases
	func testRunning() {
		let expect = expectation(description: "to run")
		let _ = sut!.run { (result, finish) in
			expect.fulfill()
		}
		wait(for: [expect], timeout: 3)
	}
	
	func testTaskCreation() {
		let task = sut!.run { (result, finish) in
		}
		XCTAssertNotNil(task)
	}
}
