//
//  NSUserDefaultsManager.swift
//  Recipe
//
//  Created by Thinh Luong on 12/2/15.
//  Copyright © 2015 Thinh Luong. All rights reserved.
//
import Foundation

/// Manager for handling NSUserDefaults interactions.
class NSUserDefaultsManager {
  
  /**
   Struct for use as key string.
   
   - RecipeArray
   
   */
  struct Key {
    static let RecipeArray = "recipeArray"
  }
  
  // MARK: Functions
  /**
  Save recipes to NSUserDefaults.standardUserDefaults.
  
  - Parameter recipes:   An array of Recipe.
  
  */
  func saveRecipes(recipes: [Recipe]) {
    let data = NSKeyedArchiver.archivedDataWithRootObject(recipes)
    userDefaults.setObject(data, forKey: Key.RecipeArray)
    userDefaults.synchronize()
  }
  
  /**
   Retrieve recipes from NSUserDefaults.standardUserDefaults.
   
   - Returns: An array of Recipe.
   */
  func getRecipes() -> [Recipe] {
    if let data = userDefaults.dataForKey(Key.RecipeArray), let recipes = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? [Recipe] {
      return recipes
    }
    
    return [Recipe]()
  }
  
  // MARK: Properties
  /// NSUserDefaults standardUserDefaults
  var userDefaults = NSUserDefaults.standardUserDefaults()

}
