// Created by Daniele Formichelli.

import Utils

/// https://adventofcode.com/2020/day/11
public struct Year2020Day11: DayBase {
  public func part1(_ input: String) -> CustomDebugStringConvertible {
    let seats = input.seats { point, seats, _, _ in
      var result: Set<Seat> = []
      for row in point.y - 1 ... point.y + 1 {
        for column in point.x - 1 ... point.x + 1 where row != point.y || column != point.x {
          guard let seat = seats[.init(x: column, y: row)] else { continue }
          result.insert(seat)
        }
      }
      return result
    }

    return self.run(seats: seats, occupiedToLeave: 4)
  }

  public func part2(_ input: String) -> CustomDebugStringConvertible {
    let seats = input.seats { point, seats, maxRow, maxColumn in
      var result: Set<Seat> = []
      for dRow in -1 ... 1 {
        for dColumn in -1 ... 1 where dRow != 0 || dColumn != 0 {
          var currentPoint = Point(x: point.x + dColumn, y: point.y + dRow)
          while currentPoint.x >= 0, currentPoint.x <= maxColumn, currentPoint.y >= 0, currentPoint.y <= maxRow {
            guard let currentSeat = seats[currentPoint] else {
              currentPoint = .init(x: currentPoint.x + dColumn, y: currentPoint.y + dRow)
              continue
            }

            result.insert(currentSeat)
            break
          }
        }
      }
      return result
    }

    return self.run(seats: seats, occupiedToLeave: 5)
  }

  private func run(seats: Set<Year2020Day11.Seat>, occupiedToLeave: Int) -> Int {
    while true {
      var toBeToggled: Set<Seat> = []
      seats.forEach { seat in
        if seat.occupied, seat.occupiedAdjacents >= occupiedToLeave {
          toBeToggled.insert(seat)
        } else if !seat.occupied, seat.occupiedAdjacents == 0 {
          toBeToggled.insert(seat)
        }
      }

      guard !toBeToggled.isEmpty else {
        return seats.filter(\.occupied).count
      }

      toBeToggled.forEach { seat in
        seat.occupied = !seat.occupied
        let difference = seat.occupied ? 1 : -1
        for adjacent in seat.adjacents {
          adjacent.occupiedAdjacents += difference
        }
      }
    }
  }
}

extension Year2020Day11 {
  fileprivate class Seat: Hashable {
    var point: Point
    var occupied: Bool
    var occupiedAdjacents: Int
    var adjacents: Set<Seat>

    init(point: Point, occupied: Bool, occupiedAdjacents: Int, adjacents: Set<Seat>) {
      self.point = point
      self.occupied = occupied
      self.occupiedAdjacents = occupiedAdjacents
      self.adjacents = adjacents
    }

    static func == (lhs: Year2020Day11.Seat, rhs: Year2020Day11.Seat) -> Bool {
      return lhs.point == rhs.point
    }

    func hash(into hasher: inout Hasher) {
      hasher.combine(self.point)
    }
  }
}

extension String {
  fileprivate func seats(
    adjacents: (Point, [Point: Year2020Day11.Seat], Int, Int) -> Set<Year2020Day11.Seat>
  ) -> Set<Year2020Day11.Seat> {
    var seats: [Point: Year2020Day11.Seat] = [:]

    self.lines.enumerated().forEach { row, line in
      line.enumerated().forEach { column, character in
        guard character == "L" else {
          return
        }

        let point = Point(x: column, y: row)
        seats[point] = .init(point: point, occupied: false, occupiedAdjacents: 0, adjacents: [])
      }
    }

    let maxRow = seats.keys.max { $0.y < $1.y }?.y ?? 0
    let maxColumn = seats.keys.max { $0.x < $1.x }?.x ?? 0
    for point in seats.keys {
      seats[point]?.adjacents = adjacents(point, seats, maxRow, maxColumn)
    }

    return seats.values.asSet
  }
}
