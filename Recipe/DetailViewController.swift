//
//  DetailViewController.swift
//  Recipe
//
//  Created by Thinh Luong on 12/1/15.
//  Copyright © 2015 Thinh Luong. All rights reserved.
//

import UIKit

/// DetailViewController displays the recipe title and contents to the user.
class DetailViewController: UIViewController {
  
  // MARK: Outlets
  @IBOutlet weak var textView: UITextView!
  
  
  // MARK: Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    textView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    self.title = recipe?.title
    textView.text = recipe?.content
  }

  // MARK: Properties
  /// Recipe object.
  var recipe: Recipe?
}
