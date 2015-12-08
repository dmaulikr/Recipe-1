//
//  RecipeManager.swift
//  Recipe
//
//  Created by Thinh Luong on 12/2/15.
//  Copyright © 2015 Thinh Luong. All rights reserved.
//

/// Manager for handling array of recipes.
class RecipeManager {
  
  // MARK: Functions
  
  /**
  Adds a recipe to recipes.
  
  - Parameter title:    The title of the recipe.
  - Parameter content:  The content of the recipe.
  
  */
  func addRecipe(title: String, content: String) {
    let recipe = Recipe(title: title, content: content)
    recipes.append(recipe)
  }
  
  /**
   Removes a recipe from recipes at specified index.
   
   - Parameter index:   The index of the recipe.
   
   */
  func removeRecipeAtIndex(index: Int) {
    recipes.removeAtIndex(index)
  }
  
  /**
   Retrieve a recipe from recipes at specified index.
   
   - Parameter index:   The index of the recipe.
   
   - Returns: A recipe at specified index.
   
   */
  func getRecipeAtIndex(index: Int) -> Recipe? {
    return recipes[index]
  }
  
  // MARK: Lifecycle
  // Initializes an RecipeManager with an empty array of recipes.
  init() {
    recipes = []
  }
  
  // MARK: Properties
  /// Array of recipes.
  var recipes: [Recipe]
  
}