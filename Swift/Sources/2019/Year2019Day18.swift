// Created by Daniele Formichelli.

import Utils

/// https://adventofcode.com/2019/day/18
struct Year2019Day18: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    let status = input.initialStatus(splitMap: false)

    var costCache: [Status: Int] = [:]
    return self.collect(status: status, costCache: &costCache)
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    let status = input.initialStatus(splitMap: true)

    var costCache: [Status: Int] = [:]
    return self.collect(status: status, costCache: &costCache)
  }

  private func collect(status: Status, costCache: inout [Status: Int]) -> Int {
    guard !status.remainingKeys.isEmpty else {
      // search completed
      return 0
    }

    if let cached = costCache[status] {
      // solution already found for this status
      return cached
    }

    // iterate on nearest key first to find low cost solution as soon as possible
    var lowestCost = Int.max
    for currentPositionIndex in 0 ..< status.currentPositions.count {
      // for each starting position
      for (key, stepCost) in status.reachableKeysAndCost(from: currentPositionIndex).sorted(by: { $0.value < $1.value }) {
        // for each reachable key
        let nextStatus = status.collecting(key: key, from: currentPositionIndex, withCost: stepCost)

        // calculate the cost from the next position adding the cost for reaching that key
        let remainingPathCost = self.collect(status: nextStatus, costCache: &costCache)
        let totalCost = stepCost + remainingPathCost
        lowestCost = min(lowestCost, totalCost)
      }
    }

    // store the result in cache to avoid to recompute it over and over
    costCache[status] = lowestCost
    return lowestCost
  }
}

extension Year2019Day18 {
  fileprivate struct Status: Hashable {
    let map: [Point: Element]
    let currentPositions: [Point]
    let remainingKeys: Set<Point>
    let collectedKeys: Set<String>

    func collecting(key: Point, from index: Int, withCost _: Int) -> Status {
      var remainingKeys = self.remainingKeys
      remainingKeys.remove(key)

      let collectedKey: String
      let element = self.map[key]
      switch element {
      case .key(let letter):
        collectedKey = letter
      default:
        fatalError("No key at position \(key)")
      }
      var collectedKeys = self.collectedKeys
      collectedKeys.insert(collectedKey)

      var map = self.map
      map[key] = .empty

      var newPositions = self.currentPositions
      newPositions[index] = key

      return Status(
        map: map,
        currentPositions: newPositions,
        remainingKeys: remainingKeys,
        collectedKeys: collectedKeys
      )
    }

    func reachableKeysAndCost(from index: Int) -> [Point: Int] {
      var keysAndCost: [Point: Int] = [:]
      var pointsToExplore: [Point: Int] = [currentPositions[index]: 0]
      var exploredPoints: Set<Point> = []

      while !pointsToExplore.isEmpty {
        let pointAndCost = pointsToExplore.remove(at: pointsToExplore.startIndex)
        let point = pointAndCost.key
        let nextCost = pointAndCost.value + 1
        exploredPoints.insert(point)
        Direction.allCases.forEach { direction in
          let nextInDirection = Point(x: point.x + direction.dx, y: point.y + direction.dy)
          guard !exploredPoints.contains(nextInDirection) else { return }
          let element = self.map[nextInDirection]!
          switch element {
          case .empty, .entrance:
            break
          case .door(let letter) where self.collectedKeys.contains(letter):
            break
          case .key:
            keysAndCost[nextInDirection] = nextCost
            return
          default:
            return
          }

          pointsToExplore[nextInDirection] = nextCost
        }
      }

      return keysAndCost
    }
  }

  fileprivate enum Element: MapElement, Hashable {
    case empty
    case wall
    case entrance
    case key(String)
    case door(String)

    var representation: String {
      switch self {
      case .empty:
        return "⬜️"
      case .wall:
        return "⬛️"
      case .entrance:
        return "❣️"
      case .key:
        return "🔑"
      case .door:
        return "🚪"
      }
    }

    init(_ char: Character) {
      switch char {
      case ".":
        self = .empty
      case "#":
        self = .wall
      case "@":
        self = .entrance
      case "a" ... "z":
        self = .key(String(char).uppercased())
      case "A" ... "Z":
        self = .door(String(char))
      default:
        fatalError("Invalid element \(char)")
      }
    }
  }
}

extension String {
  fileprivate func initialStatus(splitMap: Bool) -> Year2019Day18.Status {
    var map: [Point: Year2019Day18.Element] = [:]
    var remainingKeys: Set<Point> = []
    var entrance = Point(x: 0, y: 0)

    for (y, line) in lines.enumerated() {
      for (x, char) in line.enumerated() {
        let point = Point(x: x, y: y)
        let element = Year2019Day18.Element(char)
        map[point] = element
        switch element {
        case .entrance:
          entrance = point
        case .key:
          remainingKeys.insert(point)
        case .empty, .wall, .door:
          break
        }
      }
    }

    var currentPositions: [Point] = []
    if splitMap {
      map[Point(x: entrance.x - 1, y: entrance.y - 1)] = .entrance
      map[Point(x: entrance.x, y: entrance.y - 1)] = .wall
      map[Point(x: entrance.x + 1, y: entrance.y - 1)] = .entrance
      map[Point(x: entrance.x - 1, y: entrance.y)] = .wall
      map[Point(x: entrance.x, y: entrance.y)] = .wall
      map[Point(x: entrance.x + 1, y: entrance.y)] = .wall
      map[Point(x: entrance.x - 1, y: entrance.y + 1)] = .entrance
      map[Point(x: entrance.x, y: entrance.y + 1)] = .wall
      map[Point(x: entrance.x + 1, y: entrance.y + 1)] = .entrance

      currentPositions = [
        Point(x: entrance.x - 1, y: entrance.y - 1),
        Point(x: entrance.x + 1, y: entrance.y - 1),
        Point(x: entrance.x - 1, y: entrance.y + 1),
        Point(x: entrance.x + 1, y: entrance.y + 1),
      ]
    } else {
      currentPositions = [entrance]
    }

    return .init(map: map, currentPositions: currentPositions, remainingKeys: remainingKeys, collectedKeys: [])
  }
}

extension Year2019Day18 {
  var input: String {
    """
    #################################################################################
    #.#..a....#...#..........y..#.#.........#.I...#...#.....#.............#.......#.#
    #.#.###.###.#.#P#########.#.#S#.#######.#.###.#.#.###.#.###.#########.#.#####.#.#
    #.#...#.#...#...#.......#.#.#.#...#z....#...#.#.#.#...#...#.#...#.....#.#.......#
    #.###.#.#.#######.#######.#.#.###.#.#####.#.#.#.#.#.#####.#.#.#.#.#####.#######.#
    #q..#.#...#.#.....#.....#.#.#.....#.....#.#.#.#.#.#.....#..c#.#.#.......#.....#.#
    #.###.#####.#.#.#.#.###.#.#.###########.#.#.#.#.#.#####.#####.#.#########.###.#.#
    #.#...#.....#.#.#.#...#...#......b......#.#.#...#...#...#...#.#.....#.....#.#.#.#
    #.#.###.#####.#.#####.#####.#######.#####.#.#######.#.#.#.#.#.#####.#.#####.#.###
    #.#...#.......#.....#.#.....#.....#.#l..#.#...#.D.....#.#.#...#...#...#.....#...#
    #.###.###.#######.#.#.#######.###.###.#.#.###.###.#####.#.#######.#####.###.###.#
    #...#...#...#...#.#.#.......#...#.....#.#...#...#.#...#n#.#.......#....r..#.#...#
    #.#.###.###.#.#.###.#######.###.#######.#######.#.#.#.#.#.#.#####.#.#######.#.###
    #.#...#...#.#.#...........#...#.#.#...#.#.......#.#.#.#.#...#...#.#.....#...#...#
    ###.#####.###.###########.#.###.#.#.#.#.#.###.#####.#.#.#####.###.#######.#.###A#
    #...#.....#...#...........#.#...#.#v#...#.#...#.....#.#...#...............#.#...#
    #.###.#####.###.#####.#####.#.###.#.#####.#####.#####.#####.#################.###
    #.....#.....#...#.G.#.#...#.......#.#...#...#.....#...#.....#.........#.....#.#.#
    #.#####.#####.###.#.###.#.#######.#.###.#.#.#.#####.#.#.#####.#######.#.###.#.#.#
    #.R...#.#.....#...#.#x..#...F.#.#.#...#.#.#...#...#.#.#.#...#.#.#...#.#...#...#.#
    #####.#.#######.###.#.#######.#.#.###.#.#.#####.#.#.#.#.#.#.#.#.#.#.#.###.#####.#
    #.#...#.........#...#.#.....#.#...#...#.#.#...#.#...#.#...#.#.#...#.#.....#...#.#
    #.#.#########.###.#.###.###.#.#####.###.#.#.#.#.###.#######.#######.#######.#.#.#
    #...#.......#.#...#.....#.#.#.......#...#.#.#.#...#.#.....#.......#.#.....T.#...#
    #.#####.###.#.#.#########.#.#########.###.#.#.###.#.#.###.#######.#.#.#.#######.#
    #...M.#.#...#.#.....#.....#...#.........#.#.#.....#.#.#.#.....#.#.#...#.#.....#.#
    #####.#.###.#.#####.###.#.###.#####.###.#.#.#########.#.###.#.#.#.#.###.#.###.#.#
    #...#.#...#.#.....#...#.#...#.....#...#.#.#.......#...#.#...#...#.#.#...#...#.#.#
    #.###.###.#.#########.#.#########.#####.#.#######.#.###.#.#######.#.#.#####.#.#.#
    #...#.....#...........#.....#...#.......#.....#.#...#...#...#.....#.#.......#.#.#
    #K#.###################.###.#.#.#######.#####.#.#######.###.#.#####.#########.#.#
    #.#...........#.....#...#.#.#.#.......#.#.#...#...#.......#...#.............#.#.#
    #.#.###.#######.#.###.###.#.#.#####.###.#.#.###.###.#.###.#####.#############.###
    #.#.#...#.......#.....#...#...#...#...#.#...#.......#...#.....#.....#.......#...#
    #.#.#.###.#############.#.#####.#.###.#.#.#########.###.#######.#####.#####.###.#
    #.#.#...#.....#...H.....#.......#...#...#.#.......#...#.....#...#.....#...#...#.#
    #.#.###.#####.#######.#########.###.#####.#.#####.###.#####.#.###.#####.#.###.#.#
    #.#.#...#.....#.....#.......#...#...#...#...#.....#.......#.....#.....#.#...#.#.#
    #.#.#####.#####.###.#########.###.#####.#####.#######################.#.#.###.#.#
    #.#..........u..#.............#o......................................#.#....k..#
    #######################################.@.#######################################
    #.#.......#.............#.......#...................#.....#....h......#.......#.#
    #.#.#####.#.#######.#####.#####.#.#.###.#.###.#####.###O#.###.#######.#.#####.#.#
    #.#.....#...#.....#.#.....#.....#.#.#.#.#...#.#.........#.....#...#...#...#.#...#
    #.#####.#####.###.#.#.#####.#####.#.#.#.###.#.#################.#.#.###.#.#.###.#
    #.E...#.#.#..w#...#.#.#.#.Z.#...#.#.#...#...#.#...#.......#.#.U.#...#...#.#...#.#
    #.###.#.#.#.###.###.#.#.#.###.#.#.#.#####.###.#.#.#.#####.#.#.###########.#.#.#.#
    #.#...#.#...#...#...#.#.#...#.#.#.#.....#...#...#...#...#.#.#.....#.....#.#.#.#.#
    #.#.###.#.###.#.#.###.#.###.#.#.#####.#.###.#########.#.#.#.#####.#.###.#.#.#.#.#
    #.#...#.#...#.#.#...#.#...#s..#.....#.#.#.#.#.........#.#.#.#...#...#.#...#.#.#.#
    #####.#.###.#.#####.#.#.#.#########.#.#.#.#.#.#####.#####.#.#.#.#####.#####.#.#.#
    #.....#.#...#.....#...#.#.......#...#.#.#.#.#.#.....#.....#...#.......#.....#...#
    #.#####.#########.#####.#######.#.#####.#.#.###.###.#.#####.###.#######.#########
    #.#.....#...#...#.....#.#...#...#.#.....#.#.#...#...#.#.#...#.#.....#...#...#..m#
    #.#.#####.#.#.#.#.###.#.#.#.#####.#.###.#.#.#.###.###.#.#.###.#####.#.###.#.###.#
    #.#.#.....#.#.#...#.#.#...#...#...#...#.#.#...#.....#.#...#.......#...#..e#...#.#
    #.#.#####.#.#.#####.#.###.###.#.###.#.###.###.#######.#.#######.#.#####.#####.#.#
    #.#...#...#...#.....#...#.#...#.L.#.#...#.#...#...#...#.....#...#...#...#...#...#
    #.###.#.#######.###.###.###.#.###.#.###.#.#.###.#.#.#######.#.#####J#.###.#.###.#
    #...#...#...#...#.#.......#.#.#...#...#.#.....#.#...#.#.......#.......#...#.#...#
    #.#.#######.#.###.#######.#.###.###.###.#.#####.#####.#.###############.#.###.###
    #.#.#.......#.#.....#...#...#...#...#...#...#...#.......#...#.#.....#.#.#.....#.#
    #.###.#.#####.#.###.###.#####.###.###.#.#####.###.#########.#.#.###.#.#.#######.#
    #...#.#.......#...#...#.#...#.#...#.#.#.#.....#.#...#.....#.#...#.#.#.#.....#...#
    #.#.#.###########.#.#.#X#.#.#.###.#.#.###.#####.###.#.#.#.#.#####.#.#.#####.###Q#
    #j#.#...#.........#.#.#...#.#.V.#...#...#.#.......#.#.#.#...#.....#.#.....#.#...#
    ###.###.#.#########.#######.#.#.#######.#.###.#.###.#.#.###.#.#.###.#.#.###.#.#.#
    #...#...#...#.....#d....#...#.#.#.......#...#.#.#...#.#...#...#.#...#.#.....#.#.#
    #.#.#.#####.###.#.###.#.#.#####.#.#####.###.###.#.#######.#####.#.###W#######.#.#
    #.#.#.#.......#.#...#.#.#.#..f..#...#.#.#...#...#...#...#...#...#.#.#.....#...#.#
    #.#.#.#######.#.#.#.#.###.###.###.#.#.#.#.###.#####.#.#.###.#.###.#.#####.#.###.#
    #.#.#.....C.#.#.#.#.#...#.....#...#.#.#.#.#...........#...#.#.#...#.....#...#.#.#
    #.#########.#.###.#.###.#######.###.#.#.#.#####.#########.#.###.###.#.#######.#.#
    #...#.....#.#.....#...#.....#.....#.#...#.....#.#.......#...#...#...#.........#.#
    #.#.#.###.#.###########.###.#######.###.#.###.###.#####.#####.###.#########.#.#.#
    #.#.....#.#.......#...#...#t#.....#...#.#...#.....#...#.....#...#.Y.#.#.....#.#.#
    #.#######.#######.#.#.###.#.#.###.###.#.###.#######.#######.###.###.#.#.#######.#
    #..g#.#...#.......#.#.#...#...#...#...#.#.#.#.....#.......#...#.#.#.#.#....p..#.#
    ###.#.#N###.#######.#.#.#######.###.###.#.#.#.###.#######.###.#.#.#.#.#######.#.#
    #.....#.............#...#........i..#...#.....#.............#...#.........B.#...#
    #################################################################################
    """
  }
}
