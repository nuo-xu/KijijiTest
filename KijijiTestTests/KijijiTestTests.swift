//
//  KijijiTestTests.swift
//  KijijiTestTests
//
//  Created by Nuo Xu on 2019-12-16.
//  Copyright © 2019 Nuo Xu. All rights reserved.
//

import XCTest
@testable import KijijiTest

class MockURLSession: URLSession {
  private (set) var lastURL: URL?
  
  override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
    lastURL = request.url
    
    return super.dataTask(with: request, completionHandler: completionHandler)
  }
}

class KijijiTestTests: XCTestCase {

    override func setUp() {
      super.setUp()
      
      // Configure Client
      Client.shared.configuration = Configuration(baseURL: "https://ios-interview.surge.sh/")
    }

    override func tearDown() {
      super.tearDown()
    }

  func testGetCategories() {
    // given
    guard let url = URL(string: "https://ios-interview.surge.sh/categories") else {
      fatalError("URL cannot be empty")
    }
    let promise = expectation(description: "Get Categories API succeeded")
    
    // when
    let sessionTask = Client.shared.retrieveCategoriesList { result in
      switch result {
        // then
      case .failure(let error):
        XCTFail("Error: \(error.localizedDescription)")
        return
      case .success(_):
        promise.fulfill()
      }
    }
    
    guard let task = sessionTask else { fatalError("task cannot be nil")}
    
    // then
    XCTAssertEqual(task.currentRequest?.url, url, "Get Categories URL is wrong")
    wait(for: [promise], timeout: 5)
  }
  
  func testGetAds() {
    // given
    guard let url = URL(string: "https://ios-interview.surge.sh/categories/1") else {
      fatalError("URL cannot be empty")
    }
    let promise = expectation(description: "Get Ads API succeeded")
    
    // when
    let sessionTask = Client.shared.retrieveAdsList(categoryId: 1) { result in
      switch result {
      case .failure(let error):
        XCTFail("Error: \(error.localizedDescription)")
      case .success(_):
        promise.fulfill()
      }
    }
    
    guard let task = sessionTask else { fatalError("task cannot be nil") }
    
    // then
    XCTAssertEqual(task.currentRequest?.url, url, "Get Ads with category id:1 URL is wrong")
    wait(for: [promise], timeout: 5)
  }
}
