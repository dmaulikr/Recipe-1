//
//  iCloudManager.swift
//  Recipe
//
//  Created by Thinh Luong on 12/3/15.
//  Copyright © 2015 Thinh Luong. All rights reserved.
//

import Foundation

/// Manager for handling iCloud interactions.
class iCloudManager {
  
  /**
   Struct for use as key string.
   
   - RecipeArray
   
   */
  struct Key {
    static let RecipeArray = "recipeArray"
  }
  
  // MARK: Functions
  /**
  Retrieve recipes from iCloud.
  
  - Returns:   An array of Recipe.
  
  */
  func getRecipesFromCloud() -> [Recipe] {
    if let data = iCloudStore.objectForKey(Key.RecipeArray) as? NSData {
      if let recipes = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? [Recipe] {
        return recipes
      }
    }
    
    return [Recipe]()
  }
  
  /**
   Send recipes to iCloud.
   
   - Parameter recipes:   An array of Recipe.
   
   */
  func sendRecipesToCloud(recipes: [Recipe]) {
    let data = NSKeyedArchiver.archivedDataWithRootObject(recipes)
    iCloudStore.setData(data, forKey: Key.RecipeArray)
    iCloudStore.synchronize()
  }

  // MARK: Properties
  ///iCloud defaultStore.
  var iCloudStore = NSUbiquitousKeyValueStore.defaultStore()
}