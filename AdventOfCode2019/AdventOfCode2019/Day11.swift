//
//  Day11.swift
//  AdventOfCode2019
//
//  Created by Daniele Formichelli on 11/12/2019.
//  Copyright © 2019 Daniele Formichelli. All rights reserved.
//

/**
--- Day 11: Space Police ---
On the way to Jupiter, you're pulled over by the Space Police.

"Attention, unmarked spacecraft! You are in violation of Space Law! All spacecraft must have a clearly visible registration identifier! You have 24 hours to comply or be sent to Space Jail!"

Not wanting to be sent to Space Jail, you radio back to the Elves on Earth for help. Although it takes almost three hours for their reply signal to reach you, they send instructions for how to power up the emergency hull painting robot and even provide a small Intcode program (your puzzle input) that will cause it to paint your ship appropriately.

There's just one problem: you don't have an emergency hull painting robot.

You'll need to build a new emergency hull painting robot. The robot needs to be able to move around on the grid of square panels on the side of your ship, detect the color of its current panel, and paint its current panel black or white. (All of the panels are currently black.)

The Intcode program will serve as the brain of the robot. The program uses input instructions to access the robot's camera: provide 0 if the robot is over a black panel or 1 if the robot is over a white panel. Then, the program will output two values:

First, it will output a value indicating the color to paint the panel the robot is over: 0 means to paint the panel black, and 1 means to paint the panel white.
Second, it will output a value indicating the direction the robot should turn: 0 means it should turn left 90 degrees, and 1 means it should turn right 90 degrees.
After the robot turns, it should always move forward exactly one panel. The robot starts facing up.

The robot will continue running for a while like this and halt when it is finished drawing. Do not restart the Intcode computer inside the robot during this process.

For example, suppose the robot is about to start running. Drawing black panels as ., white panels as #, and the robot pointing the direction it is facing (< ^ > v), the initial state and region near the robot looks like this:

.....
.....
..^..
.....
.....
The panel under the robot (not visible here because a ^ is shown instead) is also black, and so any input instructions at this point should be provided 0. Suppose the robot eventually outputs 1 (paint white) and then 0 (turn left). After taking these actions and moving forward one panel, the region now looks like this:

.....
.....
.<#..
.....
.....
Input instructions should still be provided 0. Next, the robot might output 0 (paint black) and then 0 (turn left):

.....
.....
..#..
.v...
.....
After more outputs (1,0, 1,0):

.....
.....
..^..
.##..
.....
The robot is now back where it started, but because it is now on a white panel, input instructions should be provided 1. After several more outputs (0,1, 1,0, 1,0), the area looks like this:

.....
..<#.
...#.
.##..
.....
Before you deploy the robot, you should probably have an estimate of the area it will cover: specifically, you need to know the number of panels it paints at least once, regardless of color. In the example above, the robot painted 6 panels at least once. (It painted its starting panel twice, but that panel is still only counted once; it also never painted the panel it ended on.)

Build a new emergency hull painting robot and run the Intcode program on it. How many panels does it paint at least once?

Your puzzle answer was 2720.

--- Part Two ---
You're not sure what it's trying to paint, but it's definitely not a registration identifier. The Space Police are getting impatient.

Checking your external ship cameras again, you notice a white panel marked "emergency hull painting robot starting panel". The rest of the panels are still black, but it looks like the robot was expecting to start on a white panel, not a black one.

Based on the Space Law Space Brochure that the Space Police attached to one of your windows, a valid registration identifier is always eight capital letters. After starting the robot on a single white panel instead, what registration identifier does it paint on your hull?

Your puzzle answer was JZPJRAGJ.
**/
struct Day11: DayBase {
  func part1(_ input: String) -> Any {
    return paint(startingColor: .black).count
  }

  func part2(_ input: String) -> Any {
    let paintedPanels = paint(startingColor: .white)

    let minX = paintedPanels.keys.min { (lhs, rhs) in lhs.x < rhs.x }!.x
    let maxX = paintedPanels.keys.min { (lhs, rhs) in lhs.x > rhs.x }!.x
    let minY = paintedPanels.keys.min { (lhs, rhs) in lhs.y < rhs.y }!.y
    let maxY = paintedPanels.keys.min { (lhs, rhs) in lhs.y > rhs.y }!.y

    var hull = ""
    for y in stride(from: maxY, through: minY, by: -1) {
      for x in minX...maxX {
        let panelColor = paintedPanels[Point(x: x, y: y)] ?? .black
        hull += panelColor.representation
      }

      hull += "\n"
    }

    return hull
  }

  private func paint(startingColor: Color) -> [Point: Color] {
    var memory = self.inputAsIntCodeMemory
    var currentPosition = Point(x: 0, y: 0)
    var currentDirection: Direction = .up
    var paintedPanels: [Point: Color] = [:]
    paintedPanels[currentPosition] = startingColor

    var address: Int64 = 0
    while address >= 0 {
      let currentColor = paintedPanels[currentPosition] ?? .black
      let inputProvider = SingleValueInputProvider(value: currentColor.rawValue)
      let paintColor = IntCode.executeProgram(memory: &memory, from: &address, inputProvider: inputProvider, stopOnWrite: true)
      if let paintColor = paintColor {
        paintedPanels[currentPosition] = Color(rawValue: paintColor)
      }
      let turnDirection = IntCode.executeProgram(memory: &memory, from: &address, inputProvider: inputProvider, stopOnWrite: true)
      switch turnDirection {
      case 0:
        currentDirection = currentDirection.turnLeft
      case 1:
        currentDirection = currentDirection.turnRight
      default:
        break
      }

      currentPosition = Point(x: currentPosition.x + currentDirection.dx, y: currentPosition.y + currentDirection.dy)
    }

    return paintedPanels
  }
}

fileprivate enum Color: Int64 {
  case black = 0
  case white = 1

  var representation: String {
    switch self {
    case .black:
      return "⬛️"
    case .white:
      return "⬜️"
    }
  }
}

extension Day11 {
  var input: String {
    """
    3,8,1005,8,338,1106,0,11,0,0,0,104,1,104,0,3,8,1002,8,-1,10,1001,10,1,10,4,10,108,1,8,10,4,10,102,1,8,28,1,108,6,10,1,3,7,10,3,8,1002,8,-1,10,1001,10,1,10,4,10,108,1,8,10,4,10,1001,8,0,58,2,5,19,10,1,1008,7,10,2,105,6,10,1,1007,7,10,3,8,1002,8,-1,10,1001,10,1,10,4,10,1008,8,0,10,4,10,101,0,8,97,1006,0,76,1,106,14,10,2,9,9,10,1006,0,74,3,8,102,-1,8,10,101,1,10,10,4,10,108,1,8,10,4,10,1002,8,1,132,1006,0,0,2,1104,15,10,3,8,1002,8,-1,10,1001,10,1,10,4,10,1008,8,0,10,4,10,1001,8,0,162,1,1005,13,10,3,8,1002,8,-1,10,101,1,10,10,4,10,108,1,8,10,4,10,101,0,8,187,1,1,15,10,2,3,9,10,1006,0,54,3,8,102,-1,8,10,101,1,10,10,4,10,108,0,8,10,4,10,102,1,8,220,1,104,5,10,3,8,102,-1,8,10,101,1,10,10,4,10,1008,8,0,10,4,10,102,1,8,247,1,5,1,10,1,1109,2,10,3,8,1002,8,-1,10,101,1,10,10,4,10,1008,8,0,10,4,10,1001,8,0,277,1006,0,18,3,8,1002,8,-1,10,101,1,10,10,4,10,108,1,8,10,4,10,101,0,8,301,2,105,14,10,1,5,1,10,2,1009,6,10,1,3,0,10,101,1,9,9,1007,9,1054,10,1005,10,15,99,109,660,104,0,104,1,21101,0,47677546524,1,21101,0,355,0,1105,1,459,21102,936995299356,1,1,21101,0,366,0,1106,0,459,3,10,104,0,104,1,3,10,104,0,104,0,3,10,104,0,104,1,3,10,104,0,104,1,3,10,104,0,104,0,3,10,104,0,104,1,21101,0,206312807515,1,21102,1,413,0,1105,1,459,21101,206253871296,0,1,21102,424,1,0,1106,0,459,3,10,104,0,104,0,3,10,104,0,104,0,21102,1,709580554600,1,21102,1,447,0,1105,1,459,21101,0,868401967464,1,21101,458,0,0,1106,0,459,99,109,2,22102,1,-1,1,21102,1,40,2,21101,0,490,3,21102,480,1,0,1106,0,523,109,-2,2105,1,0,0,1,0,0,1,109,2,3,10,204,-1,1001,485,486,501,4,0,1001,485,1,485,108,4,485,10,1006,10,517,1101,0,0,485,109,-2,2105,1,0,0,109,4,2101,0,-1,522,1207,-3,0,10,1006,10,540,21102,0,1,-3,21201,-3,0,1,21202,-2,1,2,21101,0,1,3,21101,0,559,0,1105,1,564,109,-4,2106,0,0,109,5,1207,-3,1,10,1006,10,587,2207,-4,-2,10,1006,10,587,21202,-4,1,-4,1105,1,655,21201,-4,0,1,21201,-3,-1,2,21202,-2,2,3,21102,606,1,0,1105,1,564,22102,1,1,-4,21102,1,1,-1,2207,-4,-2,10,1006,10,625,21102,1,0,-1,22202,-2,-1,-2,2107,0,-3,10,1006,10,647,22101,0,-1,1,21101,0,647,0,106,0,522,21202,-2,-1,-2,22201,-4,-2,-4,109,-5,2106,0,0
    """
  }
}
