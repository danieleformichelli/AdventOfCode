//
//  IntCode.swift
//  AdventOfCode2019
//
//  Created by Daniele Formichelli on 05/12/2019.
//  Copyright © 2019 Daniele Formichelli. All rights reserved.
//

import Foundation

enum IntCode {
  static func executeProgram<T: InputProvider>(memory: inout [Int64: Int64], inputProvider: T) {
    var address: Int64 = 0
    Self.executeProgram(memory: &memory, from: &address, inputProvider: inputProvider, stopOnWrite: false)
  }

  @discardableResult
  static func executeProgram<T: InputProvider>(
    memory: inout [Int64: Int64],
    from address: inout Int64,
    inputProvider: T,
    stopOnWrite: Bool
  ) -> Int64? {
    while address >= 0 {
      let opCode = OpCode(from: memory, at: address)
      let output = opCode.execute(on: &memory, address: &address, inputProvider: inputProvider)
      if stopOnWrite && output != nil {
        return output
      }
    }

    return nil
  }
}

enum OpCode: Equatable {
  case sum(firstOperand: Parameter, secondOperand: Parameter, result: Parameter)
  case multiply(firstOperand: Parameter, secondOperand: Parameter, result: Parameter)
  case read(to: Parameter)
  case write(from: Parameter)
  case jumpIfTrue(condition: Parameter, target: Parameter)
  case jumpIfFalse(condition: Parameter, target: Parameter)
  case less(firstOperand: Parameter, secondOperand: Parameter, result: Parameter)
  case equal(firstOperand: Parameter, secondOperand: Parameter, result: Parameter)
  case done

  var opCodeLength: Int64 {
    switch self {
    case .sum:
      return 4
    case .multiply:
      return 4
    case .read:
      return 2
    case .write:
      return 2
    case .jumpIfTrue:
      return 3
    case .jumpIfFalse:
      return 3
    case .less:
      return 4
    case .equal:
      return 4
    case .done:
      return 1
    }
  }

  @discardableResult
  func execute<T: InputProvider>(on memory: inout [Int64: Int64], address: inout Int64, inputProvider: T) -> Int64? {
    var returnValue: Int64? = nil
    switch self {
    case .sum(let firstOperand, let secondOperand, let result):
      memory[result.addressOrValue] = firstOperand.value(from: memory) + secondOperand.value(from: memory)
    case .multiply(let firstOperand, let secondOperand, let result):
      memory[result.addressOrValue] = firstOperand.value(from: memory) * secondOperand.value(from: memory)
    case .read(let to):
      memory[to.addressOrValue] = inputProvider.next
    case .write(let from):
      returnValue = from.value(from: memory)
    case .jumpIfTrue(let condition, let target):
      if condition.value(from: memory) != 0 {
        address = target.value(from: memory)
        return nil
      }
    case .jumpIfFalse(let condition, let target):
      if condition.value(from: memory) == 0 {
        address = target.value(from: memory)
        return nil
      }
    case .less(let firstOperand, let secondOperand, let result):
      memory[result.addressOrValue] = firstOperand.value(from: memory) < secondOperand.value(from: memory) ? 1 : 0
    case .equal(let firstOperand, let secondOperand, let result):
      memory[result.addressOrValue] = firstOperand.value(from: memory) == secondOperand.value(from: memory) ? 1 : 0
    case .done:
      address = -1
      return nil
    }

    address += self.opCodeLength
    return returnValue
  }
}

extension OpCode {
  init(from memory: [Int64: Int64], at address: Int64) {
    var opCodeValue = memory[address]!
    let instructionInt: Int64
    var parametersMode: [Int64] = [0, 0, 0]

    (opCodeValue, instructionInt) = opCodeValue.quotientAndRemainder(dividingBy: 100)
    (opCodeValue, parametersMode[0]) = opCodeValue.quotientAndRemainder(dividingBy: 10)
    (opCodeValue, parametersMode[1]) = opCodeValue.quotientAndRemainder(dividingBy: 10)
    (opCodeValue, parametersMode[2]) = opCodeValue.quotientAndRemainder(dividingBy: 10)

    var parameters: [Parameter] = []
    for parameterOffset in 0..<parametersMode.count {
      let parameterAddress = address + Int64(parameterOffset + 1)
      guard parameterAddress < memory.count else { break }
      let addressOrValue = memory[parameterAddress]!
      let mode = Parameter.Mode(rawValue: Int(parametersMode[parameterOffset]))!
      parameters.append(Parameter(addressOrValue: addressOrValue, mode: mode))
    }

    switch instructionInt {
    case 1:
      self = .sum(firstOperand: parameters[0], secondOperand: parameters[1], result: parameters[2])
    case 2:
      self = .multiply(firstOperand: parameters[0], secondOperand: parameters[1], result: parameters[2])
    case 3:
      self = .read(to: parameters[0])
    case 4:
      self = .write(from: parameters[0])
    case 5:
      self = .jumpIfTrue(condition: parameters[0], target: parameters[1])
    case 6:
      self = .jumpIfFalse(condition: parameters[0], target: parameters[1])
    case 7:
      self = .less(firstOperand: parameters[0], secondOperand: parameters[1], result: parameters[2])
    case 8:
      self = .equal(firstOperand: parameters[0], secondOperand: parameters[1], result: parameters[2])
    case 99:
      self = .done
    default:
      fatalError("Invalid OpCode \(instructionInt)")
    }
  }

  struct Parameter: Equatable {
    enum Mode: Int {
      case position = 0
      case immediate = 1
    }

    let addressOrValue: Int64
    let mode: Mode

    func value(from memory: [Int64: Int64]) -> Int64! {
      switch self.mode {
      case .position:
        return memory[self.addressOrValue]
      case .immediate:
        return self.addressOrValue
      }
    }
  }
}

protocol InputProvider {
  var next: Int64 { get }
}

struct NoInputProvider: InputProvider {
  var next: Int64 {
    fatalError("not implemented")
  }
}

struct SingleValueInputProvider: InputProvider {
  private(set) var next: Int64

  init(value: Int64) {
    self.next = value
  }
}
