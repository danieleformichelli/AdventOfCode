//
//  IntCode.swift
//  AdventOfCode2019
//
//  Created by Daniele Formichelli on 05/12/2019.
//  Copyright © 2019 Daniele Formichelli. All rights reserved.
//

import Foundation

enum IntCode {
  static let debug = false
  static let relativeBaseAddress: Int64 = -1
  static func executeProgram<T: InputProvider>(memory: inout [Int64: Int64], inputProvider: T) -> Int64? {
    var address: Int64 = 0
    return Self.executeProgram(memory: &memory, from: &address, inputProvider: inputProvider, stopOnWrite: false)
  }

  @discardableResult
  static func executeProgram<T: InputProvider>(
    memory: inout [Int64: Int64],
    from address: inout Int64,
    inputProvider: T,
    stopOnWrite: Bool
  ) -> Int64? {
    var lastOutput: Int64?
    while address >= 0 {
      let opCode = OpCode(from: memory, at: address)
      let output = opCode.execute(on: &memory, address: &address, inputProvider: inputProvider)
      if let output = output {
        lastOutput = output
        if stopOnWrite {
          return output
        }
      }
    }

    return lastOutput
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
  case adjustRelativeBase(firstOperand: Parameter)
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
    case .adjustRelativeBase:
      return 2
    case .done:
      return 1
    }
  }

  @discardableResult
  func execute<T: InputProvider>(on memory: inout [Int64: Int64], address: inout Int64, inputProvider: T) -> Int64? {
    if IntCode.debug {
      print("")
    }

    var returnValue: Int64? = nil
    switch self {
    case .sum(let firstOperand, let secondOperand, let result):
      let sumResult = firstOperand.value(from: memory) + secondOperand.value(from: memory)
      if IntCode.debug {
        print("\(memory[address]!)(sum),\(memory[address + 1]!),\(memory[address + 2]!),\(memory[address + 3]!)")
        print("memory[\(result.targetAddress(from: memory))] = \(firstOperand.value(from: memory)) + \(secondOperand.value(from: memory)) = \(sumResult)")
      }
      memory[result.targetAddress(from: memory)] = sumResult

    case .multiply(let firstOperand, let secondOperand, let result):
      let multiplyResult = firstOperand.value(from: memory) * secondOperand.value(from: memory)
      if IntCode.debug {
        print("\(memory[address]!)(mul),\(memory[address + 1]!),\(memory[address + 2]!),\(memory[address + 3]!)")
        print("memory[\(result.targetAddress(from: memory))] = \(firstOperand.value(from: memory)) * \(secondOperand.value(from: memory)) = \(multiplyResult)")
      }
      memory[result.targetAddress(from: memory)] = multiplyResult

    case .read(let to):
      let value = inputProvider.next
      if IntCode.debug {
        print("\(memory[address]!)(read),\(memory[address + 1]!)")
        print("memory[\(to.targetAddress(from: memory))] = \(value)")
      }
      memory[to.targetAddress(from: memory)] = value

    case .write(let from):
      if IntCode.debug {
        print("\(memory[address]!)(write),\(memory[address + 1]!)")
        print("return \(from.value(from: memory))")
      }
      returnValue = from.value(from: memory)

    case .jumpIfTrue(let condition, let target):
      if IntCode.debug {
        print("\(memory[address]!)(jt),\(memory[address + 1]!),\(memory[address + 2]!)")
      }
      if condition.value(from: memory) != 0 {
        let targetAddress = target.value(from: memory)
        if IntCode.debug {
          print("jump to= \(targetAddress)")
        }
        address = targetAddress
        return nil
      }

    case .jumpIfFalse(let condition, let target):
      if IntCode.debug {
        print("\(memory[address]!)(jf),\(memory[address + 1]!),\(memory[address + 2]!)")
      }
      if condition.value(from: memory) == 0 {
        let targetAddress = target.value(from: memory)
        if IntCode.debug {
          print("address = \(targetAddress)")
        }
        address = targetAddress
        return nil
      }

    case .less(let firstOperand, let secondOperand, let result):
      let isLess: Int64 = firstOperand.value(from: memory) < secondOperand.value(from: memory) ? 1 : 0
      if IntCode.debug {
        print("\(memory[address]!)(<),\(memory[address + 1]!),\(memory[address + 2]!),\(memory[address + 3]!)")
        print("memory[\(result.targetAddress(from: memory))] = \(firstOperand.value(from: memory)) < \(secondOperand.value(from: memory)) = \(isLess)")
      }
      memory[result.targetAddress(from: memory)] = isLess

    case .equal(let firstOperand, let secondOperand, let result):
      let isEqual: Int64 = firstOperand.value(from: memory) == secondOperand.value(from: memory) ? 1 : 0
      if IntCode.debug {
        print("\(memory[address]!)(==),\(memory[address + 1]!),\(memory[address + 2]!),\(memory[address + 3]!)")
        print("memory[\(result.targetAddress(from: memory))] = \(firstOperand.value(from: memory)) == \(secondOperand.value(from: memory)) = \(isEqual)")
      }
      memory[result.targetAddress(from: memory)] = isEqual

    case .adjustRelativeBase(let firstOperand):
      let resultAddress = memory[IntCode.relativeBaseAddress]! + firstOperand.value(from: memory)
      if IntCode.debug {
        print("\(memory[address]!)(adj),\(memory[address + 1]!)")
        print("memory[\(IntCode.relativeBaseAddress)] = \(memory[IntCode.relativeBaseAddress]!) + \(firstOperand.value(from: memory)) = \(resultAddress)")
      }
      memory[IntCode.relativeBaseAddress] = resultAddress

    case .done:
      if IntCode.debug {
        print("\(memory[address]!)(done)")
      }
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
      guard
        let addressOrValue = memory[parameterAddress],
        let mode = Parameter.Mode(rawValue: Int(parametersMode[parameterOffset]))
      else {
        break
      }

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
    case 9:
      self = .adjustRelativeBase(firstOperand: parameters[0])
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
      case relative = 2
    }

    private let addressOrValue: Int64
    private let mode: Mode

    init(addressOrValue: Int64, mode: Mode) {
      self.addressOrValue = addressOrValue
      self.mode = mode
    }

    func value(from memory: [Int64: Int64]) -> Int64 {
      switch self.mode {
      case .position:
        return memory[self.addressOrValue] ?? 0
      case .immediate:
        return self.addressOrValue
      case .relative:
        let relativeBase = memory[IntCode.relativeBaseAddress]!
        return memory[relativeBase + self.addressOrValue] ?? 0
      }
    }

    func targetAddress(from memory: [Int64: Int64]) -> Int64 {
      switch self.mode {
      case .position, .immediate:
        return self.addressOrValue
      case .relative:
        let relativeBase = memory[IntCode.relativeBaseAddress]!
        return relativeBase + self.addressOrValue
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
