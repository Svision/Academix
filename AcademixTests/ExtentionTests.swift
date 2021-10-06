//
//  ExtentionTests.swift
//  AcademixTests
//
//  Created by Changhao Song on 2021-10-02.
//

import XCTest
@testable import Academix

class ExtentionTests: XCTestCase {
    var sut: AcademixApp!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        sut = AcademixApp()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        try super.tearDownWithError()
    }
    
    func testDatesExtentionFormatStringYesterday() {
        // given
        let yesterdayNoon = Date.yesterday
        let yesterdayNight = yesterdayNoon.addingTimeInterval(11 * 60 * 60)
        
        // when
        let actualYesterdayNoon = yesterdayNoon.formatString
        let actualYesterdayNight = yesterdayNight.formatString
        
        // then
        let expectedYesterdayNoon = "yesterday 12:00"
        let expectedYesterdayNight = "yesterday 23:00"
        XCTAssertEqual(actualYesterdayNoon, expectedYesterdayNoon)
        XCTAssertEqual(actualYesterdayNight, expectedYesterdayNight)
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
