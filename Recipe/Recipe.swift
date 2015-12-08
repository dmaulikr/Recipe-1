//
//  Recipe.swift
//  Recipe
//
//  Created by Thinh Luong on 12/2/15.
//  Copyright © 2015 Thinh Luong. All rights reserved.
//

import Foundation

/// Model object for recipe.
class Recipe: NSObject, NSCoding {
  
  // MARK: Struct
  /** 
  Struct for use as key string.
  
  - Title: title of recipe
  - Content: content of recipe
  
  */
  struct Key {
    static let Title = "title"
    static let Content = "content"
  }
  
  // MARK: Lifecycle
  /**
  Initializes a Recipe with title and content.
  
  - Parameter title:    The title of the recipe.
  - Parameter content:  The content of the recipe.
  
  */
  init(title: String, content: String) {
    self.title = title
    self.content = content
  }
  
  override init() {
    super.init()
  }
  
  
  // MARK: NSCoding
  required init?(coder aDecoder: NSCoder) {
    if let titleDecoded = aDecoder.decodeObjectForKey(Key.Title) as? String {
      title = titleDecoded
    }
    
    if let contentDecoded = aDecoder.decodeObjectForKey(Key.Content) as? String {
      content = contentDecoded
    }
  }
  
  func encodeWithCoder(aCoder: NSCoder) {
    if let title = title {
      aCoder.encodeObject(title, forKey: Key.Title)
    }
    
    if let content = content {
      aCoder.encodeObject(content, forKey: Key.Content)
    }
  }
  
  // MARK: Properties
  /// Title of Recipe
  var title: String?
  /// Content of Recipe
  var content: String?
}
