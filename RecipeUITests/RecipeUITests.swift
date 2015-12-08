//
//  RecipeUITests.swift
//  RecipeUITests
//
//  Created by Thinh Luong on 12/1/15.
//  Copyright © 2015 Thinh Luong. All rights reserved.
//

import XCTest
@testable import Recipe

class RecipeUITests: XCTestCase {
  
  // Tests
  func testElementExists() {
    XCTAssert(app.staticTexts["Recipe List"].exists, "Element should exists.")
  }
  
  func testAddAndRemoveRecipe() {
    
    // Adding recipe
    let recipe = (title: "Mac and Cheese", content: "Macaroni and Cheddar Cheese")
    
    app.buttons["Add"].tap()
    
    let titleTextField = app.textFields["addRecipeTitle"]
    titleTextField.tap()
    titleTextField.typeText(recipe.title)
    
    let contentTextView = app.textViews["addRecipeContent"]
    contentTextView.tap()
    contentTextView.typeText(recipe.content)
    
    app.buttons["Done"].tap()
    app.buttons["Add"].tap()
    app.buttons["Recipe List"].tap()
    
    // Detail view of Mac and Cheese
    app.tables.staticTexts[recipe.title].tap()
    
    // Removing recipe
    app.buttons["Recipe List"].tap()
    let recipeToRemove = app.tables.element.cells.elementBoundByIndex(0)
    recipeToRemove.swipeLeft()
    app.buttons["Delete"].tap()
    
    // Removing recipe
    let recipe2ToRemove = app.tables.element.cells.elementBoundByIndex(0)
    recipe2ToRemove.swipeLeft()
    app.buttons["Delete"].tap()
    
  }

  
  // MARK: Lifecycle
  override func setUp() {
    super.setUp()
    
    continueAfterFailure = false

    app.launch()
    
//    print(app.debugDescription)

  }
  
  override func tearDown() {
    super.tearDown()
    app.terminate()
  }

  // MARK: Properties
  let app = XCUIApplication()
}















































