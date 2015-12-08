//
//  CustomCell.swift
//  Recipe
//
//  Created by Thinh Luong on 12/2/15.
//  Copyright © 2015 Thinh Luong. All rights reserved.
//

import UIKit

/// Custom UITableViewCell for handling recipe.
class CustomCell: UITableViewCell {
  
  
  // MARK: Lifecycle
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  // MARK: Properties
  /// Recipe object
  var recipe: Recipe?
}
