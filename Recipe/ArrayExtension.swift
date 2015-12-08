//
//  ArrayExtension.swift
//  Recipe
//
//  Created by Thinh Luong on 12/2/15.
//  Copyright © 2015 Thinh Luong. All rights reserved.
//

extension Array {
  subscript (safe index: Int) -> Element? {
    return indices ~= index ? self[index] : nil
  }
}