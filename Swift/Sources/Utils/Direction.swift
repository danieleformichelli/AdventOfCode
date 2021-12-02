// Created by Daniele Formichelli.

public enum Direction: String, CaseIterable {
  case up = "U"
  case right = "R"
  case down = "D"
  case left = "L"

  public var dx: Int {
    switch self {
    case .up: return 0
    case .right: return 1
    case .down: return 0
    case .left: return -1
    }
  }

  public var dy: Int {
    switch self {
    case .up: return 1
    case .right: return 0
    case .down: return -1
    case .left: return 0
    }
  }

  public var turnLeft: Direction {
    switch self {
    case .up: return .left
    case .right: return .up
    case .down: return .right
    case .left: return .down
    }
  }

  public var turnRight: Direction {
    switch self {
    case .up: return .right
    case .right: return .down
    case .down: return .left
    case .left: return .up
    }
  }
}
