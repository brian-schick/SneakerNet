//
//  Nike_TopAlbumsExample_UITests.swift
//  Nike_TopAlbumsExample_UITests
//
//  Created by Brian Schick on 2/28/20.
//  Copyright © 2020 Brian Schick. All rights reserved.
//

import XCTest

class Nike_TopAlbumsExample_UITests: XCTestCase {
	var app: XCUIApplication!
	
	override func setUp() {
		continueAfterFailure = false
		app = XCUIApplication()
		app.launch()
	}
	
	override func tearDown() { }
	
	func test_mainTableAndCellsExist() {
		let albumTable = app.tables["Albums Table View"]
		let testCell = albumTable.staticTexts.element(boundBy: 100)
		
		XCTAssertNotNil(albumTable)
		XCTAssertNotNil(testCell)
	}
	
	func test_mainTableCellTapOpensDetailView() {
		let mainTableCell = app.tables["Albums Table View"].staticTexts.element(boundBy: 10)
		mainTableCell.tap()
		
		XCTAssertNotNil(app.otherElements["Album Stack View"])
	}
	
	func test_detailViewButtonTapOpensItunesStore() {
		guard ProcessInfo.processInfo.environment["SIMULATOR_DEVICE_NAME"] == nil else {
			XCTAssert(true, "This test is ignored on the simulator, since no iTunes Store app exists there.")
			return
		}
		
		let mainTableCell = app.tables["Albums Table View"].staticTexts.element(boundBy: 5)
		mainTableCell.tap()
		
		let detailButton = app.staticTexts["View in iTunes Store"]
		detailButton.tap()
		
		XCTAssertNotNil(app.tabBars.buttons["Music"])
	}
}
