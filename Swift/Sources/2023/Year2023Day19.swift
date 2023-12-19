// Created by Daniele Formichelli.

import Utils

/// https://adventofcode.com/2023/day/19
struct Year2023Day19: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    let workflowsAndParts = input.workflowsAndParts
    return workflowsAndParts.parts
      .filter { parts in
        var current = "in"
        while current != "A" && current != "R" {
          let workflow = workflowsAndParts.workflows[current]!
          if let match = workflow.rules.first(where: { rule in return rule.1.contains(parts[rule.0]!) }) {
            current = match.2
          } else {
            current = workflow.otherwise
          }
        }
        return current == "A"
      }
      .map { $0.values.sum }
      .sum
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    let constraints = Constraints(x: (1 ... 4000).asSet, m: (1 ... 4000).asSet, a: (1 ... 4000).asSet, s: (1 ... 4000).asSet)
    return Self.solve(current: "in", workflows: input.workflowsAndParts.workflows, constraints: constraints)
  }

  static func solve(current: String, workflows: [String: Workflow], constraints: Constraints) -> Int {
    if current == "A" {
      return constraints.combinations
    } else if current == "R" {
      return 0
    }
    
    let workflow = workflows[current]!
    var constraints = constraints
    var result = 0
    for rule in workflow.rules {
      result += Self.solve(current: rule.2, workflows: workflows, constraints: constraints.intersect(category: rule.0, range: rule.1))
      constraints = constraints.exclude(rule: rule)
    }
    result += Self.solve(current: workflow.otherwise, workflows: workflows, constraints: constraints)
    return result
  }
}

struct Constraints {
  let x: Set<Int>
  let m: Set<Int>
  let a: Set<Int>
  let s: Set<Int>
  
  func intersect(category: String, range: ClosedRange<Int>) -> Self {
    var x = self.x
    var m = self.m
    var a = self.a
    var s = self.s
    let reducedRange = max(1, range.lowerBound) ... min(4000, range.upperBound)
    switch category {
    case "x":
      x.formIntersection(reducedRange)
    case "m":
      m.formIntersection(reducedRange)
    case "a":
      a.formIntersection(reducedRange)
    case "s":
      s.formIntersection(reducedRange)
    default:
      fatalError()
    }
    return Constraints(x: x, m: m, a: a, s: s)
  }
  
  func exclude(rule: (String, ClosedRange<Int>, String)) -> Self {
    var x = self.x
    var m = self.m
    var a = self.a
    var s = self.s
    let reducedRange = max(1, rule.1.lowerBound) ... min(4000, rule.1.upperBound)
    switch rule.0 {
    case "x":
      x.formSymmetricDifference(reducedRange)
    case "m":
      m.formSymmetricDifference(reducedRange)
    case "a":
      a.formSymmetricDifference(reducedRange)
    case "s":
      s.formSymmetricDifference(reducedRange)
    default:
      fatalError()
    }
    return Constraints(x: x, m: m, a: a, s: s)
  }
  
  var combinations: Int {
    return self.x.count * self.m.count * self.a.count * self.s.count
  }
}

struct Workflow {
  let rules: [(String, ClosedRange<Int>, String)]
  let otherwise: String
}

struct WorkflowsAndParts {
  let workflows: [String: Workflow]
  let parts: [[String: Int]]
}

extension String {
  fileprivate var workflowsAndParts: WorkflowsAndParts {
    let groupedLines = self.groupedLines
    let workflows = Dictionary(uniqueKeysWithValues: groupedLines[0].map { workflowStr in
      let split = workflowStr.components(separatedBy: "{")
      let name = String(split[0])
      let rules = split[1].dropLast().components(separatedBy: ",")
      let workflow = Workflow(
        rules: rules.dropLast().map { rule in
          let split = rule.components(separatedBy: ":")
          if split[0].contains(">") {
            let categoryAndLimit = split[0].components(separatedBy: ">")
            return (categoryAndLimit[0], (Int(categoryAndLimit[1])! + 1) ... Int.max, split[1])
          } else {
            let categoryAndLimit = split[0].components(separatedBy: "<")
            return (categoryAndLimit[0], Int.min ... (Int(categoryAndLimit[1])! - 1), split[1])
          }
        },
        otherwise: rules.last!
      )
      return (name, workflow)
    })
    let parts = groupedLines[1].map { part in
      Dictionary(uniqueKeysWithValues: part.dropFirst().dropLast().components(separatedBy: ",").map {
        let split = $0.components(separatedBy: "=")
        return (split[0], Int(split[1])!)
      })
    }
    return WorkflowsAndParts(workflows: workflows, parts: parts)
  }
}
