//
//  Operations.swift
//
//  Copyright © 2020 Bending Spoons. All rights reserved.
//

import Foundation

public enum Operation: CustomDebugStringConvertible {
  case acc(sum: Int)
  case jmp(by: Int)
  case nop(arg: Int)

  init(from string: String) {
    let split = string.split(separator: " ")
    let value = Int(split[1])!
    switch split[0] {
    case "acc":
      self = .acc(sum: value)
    case "jmp":
      self = .jmp(by: value)
    case "nop":
      self = .nop(arg: value)
    default:
      fatalError()
    }
  }

  public var debugDescription: String {
    switch self {
    case .acc(let sum):
      return "acc \(sum)"
    case .jmp(let by):
      return "jmp \(by)"
    case .nop:
      return "nop"
    }
  }

  public enum Error: Swift.Error {
    case loop(at: Int, currentResult: Int)

  }
}

extension Array where Element == Operation {
  public func execute() throws -> Int {
    var accumulator = 0
    var executed: Set<Int> = []
    var operationIndex = 0
    while operationIndex < self.count {
      guard !executed.contains(operationIndex) else {
        throw Operation.Error.loop(at: operationIndex, currentResult: accumulator)
      }
      executed.insert(operationIndex)
      switch self[operationIndex] {
      case .acc(let sum):
        accumulator += sum
      case .jmp(let by):
        operationIndex += by
        continue
      case .nop:
        break
      }
      operationIndex += 1
    }

    return accumulator
  }
}
