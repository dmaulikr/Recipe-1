//
//  ViewController.swift
//  Recipe
//
//  Created by Thinh Luong on 12/1/15.
//  Copyright © 2015 Thinh Luong. All rights reserved.
//

import UIKit

class RecipeViewController: UITableViewController {
  
  // MARK: Segues
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "detailView", let cell = sender as? CustomCell, let detailVC = segue.destinationViewController as? DetailViewController {
      detailVC.recipe = cell.recipe
    }
    
    if segue.identifier == "addView", let addVC = segue.destinationViewController as? AddViewController {
      addVC.delegate = self
    }
  }

  // MARK: Delegate
  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
      removeRecipeAtIndex(indexPath.row)
      tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    }
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return recipeManager.recipes.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("customCell") as! CustomCell
    
    switch indexPath.row % 2 {
    case 0:
      cell.backgroundColor = UIColor.clearColor()
    case 1:
      cell.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.2)
      cell.textLabel?.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0)
    default: break
    }
    
    let recipe = recipeManager.getRecipeAtIndex(indexPath.row)
    cell.textLabel?.text = recipe?.title
    cell.textLabel?.textColor = UIColor.whiteColor()

    cell.recipe = recipe
    
    return cell
  
  }
  
  // MARK: Functions
  func updateFromiCloud(notification: NSNotification) {
    recipeManager.recipes = icloudManager.getRecipesFromCloud()
    userDefaultsManager.saveRecipes(recipeManager.recipes)
    tableView.reloadData()
  }
  
  // MARK: Private Functions
  private func initializeiCloud() {
    let fileManager = NSFileManager.defaultManager()
    let connectionStatus = Reach.connectionStatus()
    
    if let _ = fileManager.ubiquityIdentityToken, case .Online(_) = connectionStatus {
      let iCloudStore = NSUbiquitousKeyValueStore.defaultStore()
      NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateFromiCloud:", name: NSUbiquitousKeyValueStoreDidChangeExternallyNotification, object: iCloudStore)
      iCloudStore.synchronize()
    }
  }
  
  private func removeRecipeAtIndex(index: Int) {
    recipeManager.removeRecipeAtIndex(index)
    userDefaultsManager.saveRecipes(recipeManager.recipes)
  }
  
  // MARK: Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    tableView.rowHeight = 70
    tableView.backgroundColor = UIColor.lightGrayColor()
    
    recipeManager.recipes = userDefaultsManager.getRecipes()
    initializeiCloud()
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    navigationController?.navigationBar.alpha = 0.5
    tableView.reloadData()
  }

  // MARK: Properties
  let recipeManager = RecipeManager()
  var userDefaultsManager = NSUserDefaultsManager()
  var icloudManager = iCloudManager()

}

// MARK: Extensions
extension RecipeViewController: AddViewControllerDelegate {
  func addRecipe(title: String, content: String) {
    recipeManager.addRecipe(title, content: content)
    userDefaultsManager.saveRecipes(recipeManager.recipes)
    icloudManager.sendRecipesToCloud(recipeManager.recipes)
  }
}








































