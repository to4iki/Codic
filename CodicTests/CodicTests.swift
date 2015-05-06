//
//  CodicTests.swift
//  CodicTests
//
//  Created by to4iki on 5/4/15.
//  Copyright (c) 2015 to4iki. All rights reserved.
//

import XCTest
import Codic

class CodicTests: XCTestCase {
    
    var client: Codic.Client!
    
    override func setUp() {
        super.setUp()
        
        // set your api access_key
        let secretsURL = NSBundle(forClass: CodicTests.self).URLForResource("secrets", withExtension: "plist")!
        let secrets = NSDictionary(contentsOfURL: secretsURL)!
        client = Codic.Client(accessKey: secrets["CodicAccessKey"] as! String)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExample() {
        XCTAssert(true, "Pass")
    }
    
    func testTranslate() {
        // TODO
    }
    
    func testFetchUserDictionaries() {
        let expectation = expectationWithDescription("fetch userDictionaries")
        
        let request = client.fetchUserDictionaries()
        request.onSuccess { dictionaries in
            expectation.fulfill()
            XCTAssertGreaterThan(dictionaries.count, 0)
        }
        request.resume()
        
        waitForExpectationsWithTimeout(3) { error in request.cancel() }
    }
    
    func testFetchUserDictionary() {
        // TODO
    }
    
    func testLookup() {
        let expectation = expectationWithDescription("lookup")
        
        let request = client.lookup("term", count: 2)
        request.onSuccess { words in
            expectation.fulfill()
            XCTAssertGreaterThan(words.count, 0)
        }
        request.resume()
        
        waitForExpectationsWithTimeout(3) { error in request.cancel() }
    }
    
    func testFetchEntry() {
        let expectation = expectationWithDescription("fetch userDictionaries")
        
        let request = client.fetchEntry(41941)
        request.onSuccess { entry in
            expectation.fulfill()
            XCTAssertGreaterThan(entry.transcriptions.count, 0)
            XCTAssertGreaterThan(entry.translations.count, 0)            
        }
        request.resume()
        
        waitForExpectationsWithTimeout(3) { error in request.cancel() }
    }
}


