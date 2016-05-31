//
//  internassignment1Tests.swift
//  internassignment1Tests
//
//  Created by Mohamad Asyraaf on 6/5/16.
//  Copyright © 2016 Mohamad Asyraaf bin Abdul Rahman. All rights reserved.
//

import XCTest
import Quick
import Nimble


@testable import internassignment1 //So that we can use the public symbols form the internassignment project.

class internassignment1Tests: QuickSpec {
    
    var vc: ViewController! //If the "arrange" code needs to be used in multiple tests,meaning multiple classes,then use a helper function: internal fucn
                           // create new ViewController() -> ViewController (For example)
    
    
    func testRetreieveStaticParkingInfo_populatesTheStaticParkingLotArray(){
      
        
        //1)Arrange 2)Act 3)Assert
        //1)Create the stuff that you need.2)
        
      vc.retrieveStaticParkingInfo()
        XCTAssertTrue(vc.parkingSpaces.count != 0) //example of bittle test
        
    
    }
    
 
    override func spec() {//to Define a set of groups and examples
        //
    }
    
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        vc = ViewController()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
