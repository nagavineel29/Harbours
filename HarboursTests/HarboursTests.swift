//
//  HarboursTests.swift
//  HarboursTests
//
//  Created by naga vineel golla on 2/21/24.
//

import XCTest
@testable import Harbours

final class HarboursTests: XCTestCase {
    var viewModel = ContentViewModel()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testMatrixInitialization() {
        // Given
        let rows = 4
        let columns = 4
        
        // when
        viewModel.rows = rows
        viewModel.columns = columns
        viewModel.initializeMatrix()
        
        // Then
        XCTAssertEqual(viewModel.matrixVals, [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]])
    }
    
    func testLowestCost() {
        // Given
        let rows = 4
        let columns = 4
        
        // when
        viewModel.rows = rows
        viewModel.columns = columns
        viewModel.initializeMatrix()
        viewModel.Calculate()
        
        // Then
        XCTAssertEqual(viewModel.result.cost, 0)
        XCTAssertEqual(viewModel.result.path, [0,0,0,0])

    }
    
    func testLowestCost2() {
        // Given
        let rows = 4
        let columns = 4
        
        // when
        viewModel.rows = rows
        viewModel.columns = columns
        viewModel.initializeMatrix()
        viewModel.matrixVals = [[3,4,1,2,8,6],[6,1,8,2,7,4],[5,9,3,9,9,5],[8,4,1,3,2,6]]
        viewModel.Calculate()
        
        // Then
        XCTAssertEqual(viewModel.result.cost, 14)
        XCTAssertEqual(viewModel.result.path, [0,1,0,0,3,2])

    }
}
