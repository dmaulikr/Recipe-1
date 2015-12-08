//
//  RecipeTests.swift
//  RecipeTests
//
//  Created by Thinh Luong on 12/1/15.
//  Copyright © 2015 Thinh Luong. All rights reserved.
//

import XCTest
@testable import Recipe

class RecipeViewControllerTests: XCTestCase {
  
  // MARK: Tests
  func testRecipeArrayCanBeChangedNSUserDefaults() {
    
    let mockUserDefaults = MockUserDefaults()
    recipeViewController.userDefaultsManager.userDefaults = mockUserDefaults
    
    XCTAssertFalse(mockUserDefaults.recipeArrayWasChanged, "recipeArrayWasChanged should be false.")
    
    recipeViewController.addRecipe(testRecipe.title!, content: testRecipe.content!)
    
    XCTAssertTrue(mockUserDefaults.recipeArrayWasChanged, "recipeArrayWasChanged should be true.")
  }
  
  func testRecipeArrayCanBeChangediCloudDefaultStore() {
    
    let mockDefaultStore = MockDefaultStore()
    recipeViewController.icloudManager.iCloudStore = mockDefaultStore
    
    XCTAssertFalse(mockDefaultStore.recipeArrayWasChanged, "recipeArrayWasChanged should be false.")
    
    recipeViewController.addRecipe(testRecipe.title!, content: testRecipe.content!)
    
    XCTAssertTrue(mockDefaultStore.recipeArrayWasChanged, "recipeArrayWasChanged should be true.")
  }
  
  func testAddRecipe() {
    
    XCTAssert(recipeViewController.recipeManager.recipes.count == 0, "Initial recipes count should be zero.")
    
    addViewController.delegate?.addRecipe(testRecipe.title!, content: testRecipe.content!)
    
    XCTAssert(recipeViewController.recipeManager.recipes.count == 1, "recipes count should be one")
 
  }
  
  // MARK: Lifecycle
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    recipeViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("RecipeViewController") as! RecipeViewController
    addViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("AddViewController") as! AddViewController

    addViewController.delegate = recipeViewController
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  // MARK: Properties
  var recipeViewController: RecipeViewController!
  var addViewController: AddViewController!
  
  let testRecipe = Recipe(title: "unitTestRecipeTitle", content: "unitTestRecipeConent")
  
  /// Mock NSUserDefaults
  class MockUserDefaults: NSUserDefaults {
    var recipeArrayWasChanged = false
    
    override func setObject(value: AnyObject?, forKey defaultName: String) {
      if defaultName == "recipeArray" {
        recipeArrayWasChanged = true
      }
    }
  }
  
  /// Mock iCloud defaultStore
  class MockDefaultStore: NSUbiquitousKeyValueStore {
    var recipeArrayWasChanged = false
    
    override func setObject(anObject: AnyObject?, forKey aKey: String) {
      if aKey == "recipeArray" {
        recipeArrayWasChanged = true
      }
    }
  }
}


























