// Created by Daniele Formichelli.

import Foundation

// class TreeNode<T: Comparable> {
//  let value: T
//  var left: TreeNode<T>? {
//    didSet {
//      self.left?.parent = self
//    }
//  }
//  var right: TreeNode<T>? {
//    didSet {
//      self.right?.parent = self
//    }
//  }
//  private(set) var parent: TreeNode<T>?
//
//  init(value: T, left: TreeNode<T>? = nil, right: TreeNode<T>? = nil) {
//    self.value = value
//    self.left = left
//    self.right = right
//    self.parent = nil
//  }
// }
//
// extension TreeNode {
//  var size: Int {
//    return 1 + (self.left?.size ?? 0) + (self.right?.size ?? 0)
//  }
//
//  func insert(_ value: T) {
//    if self.value < value {
//      if let left = self.left {
//        left.insert(value)
//      } else {
//        self.left = TreeNode(value: value)
//      }
//    } else if self.value > value {
//      if let right = self.right {
//        right.insert(value)
//      } else {
//        self.right = TreeNode(value: value)
//      }
//    } else {
//      return
//    }
//  }
// }
