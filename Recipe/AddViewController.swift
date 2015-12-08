//
//  AddViewController.swift
//  Recipe
//
//  Created by Thinh Luong on 12/1/15.
//  Copyright © 2015 Thinh Luong. All rights reserved.
//

import UIKit

/// Protocol for adding recipe to the main model class.
protocol AddViewControllerDelegate: class {
  func addRecipe(title: String, content: String)
}

/// AddViewController allows the user to input and add recipes to the main model class.
class AddViewController: UIViewController {
  
  // MARK: Delegate
  weak var delegate: AddViewControllerDelegate?
  
  // MARK: Outlets
  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var textView: UITextView!
  @IBOutlet weak var doneButton: UIBarButtonItem!
  @IBOutlet weak var addButton: UIButton!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  // MARK: Actions
  @IBAction func iCloudDocsButtonPressed(sender: UIButton) {
    let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.text"], inMode: .Import)
    documentPicker.delegate = self
    
    documentPicker.modalPresentationStyle = .FullScreen
    self.presentViewController(documentPicker, animated: true, completion: nil)
  }
  
  @IBAction func addButtonPressed(sender: UIButton) {
    activityIndicator.startAnimating()
    
    delegate?.addRecipe(textField.text!, content: textView.text)
    
    textField.text = ""
    textView.text = ""
    
    let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(0.5 * Double(NSEC_PER_SEC)))
    dispatch_after(delay, dispatch_get_main_queue()) {
      self.activityIndicator.stopAnimating()
    }
    
    addButton.enabled = false
  }
  
  
  @IBAction func textViewDoneButtonPressed(sender: UIBarButtonItem) {
    textView.resignFirstResponder()
    doneButton.enabled = false
  }
  
  @IBAction func textFieldDonePressed(sender: UITextField) {
    textField.resignFirstResponder()
    doneButton.enabled = false
  }
  
  // MARK: Functions
  func textFieldDidChange() {
    handleButtonStates()
  }
  
  func textViewDidChange() {
    handleButtonStates()
  }
  
  /// Handle button states depending on textField and textView.
  private func handleButtonStates() {
    if textView.text.isEmpty {
      doneButton.enabled = false
    } else {
      doneButton.enabled = true
    }
    
    if !textView.text.isEmpty, let text = textField.text where !text.isEmpty {
      addButton.enabled = true
    } else {
      addButton.enabled = false
    }
    
  }
  
  // MARK: Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    textField.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.2)
    textView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.2)
    
    addButton.enabled = false
    addButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
    addButton.setTitleColor(UIColor.lightGrayColor(), forState: .Disabled)
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "textFieldDidChange", name: UITextFieldTextDidChangeNotification, object: nil)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "textViewDidChange", name: UITextViewTextDidChangeNotification, object: nil)
  }
}

// MARK: Extensions
extension AddViewController: UIDocumentPickerDelegate {
  func documentPicker(controller: UIDocumentPickerViewController, didPickDocumentAtURL url: NSURL) {
    if controller.documentPickerMode == .Import {
      let content = openFile(url.path!)
      textView.text = content
    }
  }

  /// Opens a file and return its string contents.
  private func openFile(path: String, utf8: NSStringEncoding = NSUTF8StringEncoding) -> String? {
    if NSFileManager().fileExistsAtPath(path) {
      do {
        return try String(contentsOfFile: path, encoding: utf8)
      } catch {
        print("Error opening file at path: \(path)")
      }
    }
    
    return nil
  }
}
























