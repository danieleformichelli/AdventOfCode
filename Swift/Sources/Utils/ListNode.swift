// Created by Daniele Formichelli.

import Foundation

public class ListNode<T>: Collection {
  public let value: T
  public var next: ListNode<T>?
  public var prev: ListNode<T>?

  public init(value: T, next: ListNode<T>? = nil, prev: ListNode<T>? = nil) {
    self.value = value
    self.next = next
    self.prev = prev
  }

  public var startIndex: Int {
    return 0
  }

  public var endIndex: Int {
    return self.length
  }

  public subscript(position: Int) -> T {
    var current = self
    (0 ..< position).forEach { _ in current = current.next! }
    return current.value
  }

  public func index(after i: Int) -> Int {
    return i + 1
  }
}

extension ListNode {
  public var length: Int {
    var currentLength = 0
    var current: ListNode? = self
    while current != nil {
      current = current?.next
      currentLength += 1
    }

    return currentLength
  }

  public var array: [T] {
    var array: [T] = []
    var current: ListNode? = self
    while current != nil {
      array.append(current!.value)
      current = current?.next
    }
    return array
  }
}

extension Array {
  public var toList: ListNode<Element>? {
    guard !isEmpty else { return nil }

    let head = ListNode<Element>(value: self[0])
    var tail = head
    for element in dropFirst() {
      let next = ListNode<Element>(value: element)
      tail.next = next
      tail = next
    }
    return head
  }
}
