//
//  SnappingScrollingTests.swift
//  SnappingScrollingTests
//
//  Created by Ahmed Khalaf on 1/10/19.
//  Copyright © 2019 Ahmed Khalaf. All rights reserved.
//

import XCTest
@testable import SnappingScrolling

class SnappingScrollingTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNoClamp() {
        let value: CGFloat = 100
        let minValue: CGFloat = 0
        let maxValue: CGFloat = 200
        
        XCTAssert(value >= minValue && value <= maxValue)
        XCTAssertEqual(value.clamped(minValue: minValue, maxValue: maxValue), 100)
    }
    
    func testClampMin() {
        let value: CGFloat = -1
        let minValue: CGFloat = 0
        let maxValue: CGFloat = 200
        
        XCTAssert(value < minValue)
        XCTAssertEqual(value.clamped(minValue: minValue, maxValue: maxValue), minValue)
    }
    
    func testClampMax() {
        let value: CGFloat = 201
        let minValue: CGFloat = 0
        let maxValue: CGFloat = 200
        
        XCTAssert(value > maxValue)
        XCTAssertEqual(value.clamped(minValue: minValue, maxValue: maxValue), maxValue)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
