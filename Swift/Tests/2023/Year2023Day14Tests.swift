// Created by Daniele Formichelli.

import XCTest
@testable import AdventOfCode2023

class Year2023Day14Tests: XCTestCase {
  func testPart1() {
    XCTAssertEqual(Year2023Day14().part1(Self.input).debugDescription, "110128")
  }

  func testPart2() {
    XCTAssertEqual(Year2023Day14().part2(Self.input).debugDescription, "103861")
  }

  static var input: String {
    """
    .O#O..##...#O#.#.......##.....O..#.O##.O#......O.........#....O.O..........#...O...#O.#.OO...OO.....
    ..............O.#OO..#.#..O..#O..OOO...O......O......O.....O.##.#O.#.O...#....O.#O.O......#OO.O....#
    O.#.O.#..O..OO.#O.#.#.O.......O#.O#..#..#..#......O#..O.#...#O..O.........................#..O..#.##
    ....OO..O......OO...O.O.#...###.#.OO.#.OO.#O.....O#....#..#....O....##.O....#O...O...#.#.O#.#O.O#...
    ......O#...O..........#..#O...O...O...#.#.#.......O....#....#O....O..O#..O.#..O##..O..#....#..O.O#..
    ....O...O..O.#...O.O.....#..#....O.O.##O.#..O......OO..#......O.#O.#O..#.###...#O#..........O....OO#
    #......#.O....#O.#.#O.#.#.O......O##O.##O#.#.......OO.#......O.##.O.###.#......#..###.....O.O.OOO#..
    .#.#.#........#........O..O.O#O.O.O#OO....O#.O..O.....O.O....O#O.O##....#...O#.......#.#O...#..#O..O
    .O.#.O.#...O...O#.OO.........#...O#O..OO..O#..O.O.O#..O#...O...OO#O...#..O...OO...OO.O#.....#....#..
    ...#...#............OO##O#...O.#O##O..#.#....#.O.O.O#...O.O..O.O.###..#.O.##.#O....##....#.......O.O
    .#O....OO..OO....O.O.....#.....#...OO.O..#..#.#.OOO...#.O.#...OOO........#....OO#OOO...............O
    .OO.#....O.#O.OO..#.OO.........O.#.O......#O......O#...###.#OO.#.#..........O.#O.#O..O#..#..#.O..OOO
    #.......O.....#.#.##.#.#.#.....O....#.#..O#OO.OO..O#..O......OO#.O..#...OOO#.O..........O.OO.#..O#.O
    ....OO....O#OO...O#O#..O#.O.....O.O......#O.#O#......#.....#O.......#.#O....OO......##..##O#O.#..#..
    ..#...OO.O.#.#..OO...OO........##........O...OO...O....#.O...OO..O.O.OO.O.#....OOO..#..#.O#.OO..O.#O
    #.#.#.#O..OOO..OOO..O#O.O..O..#O..OO....O#....O#..O.O...O#.....#.#..OO...#...O##O.#O.O.O#..OO.......
    #..O....O....OO..O.....O....O....#O..........#O.O.O#..#...O...##.#.O.#O..#.O.##..OO.O..O..#...O.#..O
    ......#..O.#......O.....O#.OO#O.#.O.O.....O...#..O.#OO.......O....O........O.O.#.O.....O#.....##....
    .#...#O..#.O...O#O...O.#..#.#OO...O.O.#O..###..O..OOO...O..#..O.O..O.#...OO.OO.#.O....#....#O.#...#O
    .#OOOO..............#O##OO.....#O#.......O...##...O....O#O.......OOO.#O#OO.#......OOOOOO...##..O..#.
    O....OO.OO.O.#.O#.#.O..OO......OO#..#O..#.#O.O..#OO.#.....#.O...O........OO..O#......OOOO..O.OO...O.
    ...OO.##.O.....O...#.O.OOO..O.....O#......#O#O#...#....O..#O...OOO#..O.#.O....O#.....#...O.O##O...#O
    ..O........#..###O...O##....O..#.O.##..O.O...O##O.O..O...#O..#OOO###O.O###O#O...#.#......O.OOO.#..O#
    ....O...O...#.##....#...OO.#O#O...O###..O...O..OO.O.O..#OO.O#.O...O#O.#..#.......#..O.##O.##.OO...#O
    OO.#...O..O...OO.##..........OO.......#O#O.OO.#O.....O..OO...#O#O...##.O..##O.O.O.OO.OO.#.#O#O...O.#
    ......O##.#.#..O#........O....O............O##..#...#..#..#O......O...#...#O..O......#.#..O...O...O#
    O.#..#.#..#..##..#........O#..#O.O....#..O...OOO......#......OO...O.O.#O..#........O....#....O#..#O.
    .......OO.....O......#....OO.O.#O.O....O#..#...O.O.......#...OO.....#.......#...O..#...##.#.O.#..O#.
    O###.........O........O.O..O..O...O#.#....#.OOO..O.O.#..O..##....O....O..#O.O..#........O.#O...O...O
    #..........##....O.#O..#....OO..#...O.O.O..O..OO#..##..#O.OO..O.#..OO.........#.O....O..O...........
    ....#...#.....#..OO.O.##...OOO##O..#........OO..O.#.......#.OO#..O....O##.#.O.#.O.###....#..##O..#O#
    ..#..........O........#....OO.....O...#.##.#.....#....O..##..............O........#....#..O#...O.O#O
    O...OO.O.......O....O...#...OO#O.....O.O....O#O.......#.#..O.....O...#.....#.#....#O..OOOOO.O...O.O.
    #...O....O.#........#OO.O..O##.#.........O#.O##...#O#..O...#O.#..#...#O..#......O..........O....OO#O
    O.....#O.........O#.O#..OO#...#O.O.....O.#..#....#.O..O..O..O#....O......O.O...O#O......#.O...#..O#O
    #......O.....O#.O.#OO...........O.O...O#..O...OO.O###O...#O.....#..O...OO.O#.....#O.O.#....#..O..#..
    ....#.##..O..O.....OO#....O.........OOO###..O.OO.O..O.##.O.OO..#.#O..#..#.#.##......#...##....#.O..O
    .......OO..........O..OO.#..#O.OO#.........O..O#.O..O.#O.O.#......O.....O#....OO..O...O....O..O#OO..
    .O.OO.#OO#......O#O#OO...O#O....##OO.....O#........O....O..O.O..O..O..#....O....OO#..O....OO####O..O
    .....O.O#.#.#.O#.OO.#...O#..OOO....O#O...OO......O.##.OO.......O.O....#...O....O....O..#..#..O.#O...
    ...O...O.......O...#.O...O...O....#...OO##..#.O....O.....#.#..O....O.O.....#..OOO....OO..#.###....#.
    ....#.O....##....O.#.......O#..###.##O.O.O.......#O#.#O.....O...O.#.O..#.#.....O#.O#......O#O..#O...
    .#.O....O...#.#...O#.....#......O.O.......#....OO....O...O#....O.#......#.##OO...#..#O#...O#.O.##..O
    O.#.#.....O....O....O.O...O..O.#....O....#O.......#.........#.......O.OO.....O.#.OO.#.#.O.OO..O.....
    ##..#..O.#...O......#..#.O.O..O...O..#.....##.#...#.O.O##.O....#OOOOOO....##....##.#O#..........#.O.
    .#..#...O.O.O........OO.O..OOO....O#..##..#O..OO.........OO.........#....#.O#..O#..#.#..#O..O.O#....
    ..#..OO##..#.....O..##......O..OOO.#.....O.#..#O....#O#O.....#.O..OO.#...O..#...#O...#.........#....
    .........#..O....OO..#OO..O.........#..#O..O..OO....O..##..#O..O.O.O...#O##OOO#.........O.......#...
    ...#...OO.....#.O..#........#.#...O.O....OOO.O#O....###..#.#.......#.O......O..#O....###.O##.#..OO.#
    ..##O#.#.........OO#O#..OO..O..##.O.O.O.O...O#..OO...#..O...O.O.#.O...#.O.O#....##...O.....#...O..O.
    ..#O..#..OOO....#.......#O.....#...O#..O##OOO#.#.....O#O..#O...#....#O.O#......#.OO..#.#.O.......O.#
    O.O.....#O.#.OOOOOO..###..O.......O.#.O.OO...#..O..##.##.#..O..O..O...#O.....OO....O...O..#...#O....
    ..O.OO....#.O..O..#.#OO..#.O.......O.OO#....O..O...O#...O...O#...O...#.#O...#..OO....#.O........O...
    .#....#.O#.#....O#O#.##.....O.#.....O..OO....O..O.#.....#OO##.O..O..O..O.......#...OO..#.O.......O..
    O...O#.#O.#.#.#..O..O......#.O..OO..#.O##.#.....#O#.....#O#.....#...#.#O....O.O.....#.......#....#..
    #.O...O.O.....O.O..O...O#O...OO#..##.....O.......#....O..#...O....#..O..OO#.....O..O.O...#....O..O#.
    O..O....O..O##..#....OO.#OO........#O.........O............O.#..#O.O.O##..#.###O..O...O#...#..#.....
    O.......O........O...O...O.###.#.#OO.O.#.#.O.#O.OO....O..O.###....O.O.#.#O..OO##.O.#O#....#.....#...
    ..O..O#..OOO..O##O....O#.O.O.O#.#.O.##..O.....#.#..#O...O..O...O....#.......O.O......O#..O.#....#OO.
    .#..O..##....O#.......#....O#..O.###.O.#..O...#OO...O#.....O.O....O#...O#...##O...O..O..#....O.O.O..
    .O.......O#O...OO...O...#.OO#OO#.#O..#OO..#O.#OO....#..#...O#O.OO#...OOO..O..OO..#..#.....O.....#...
    ..O..##.##..O#.O..#.O.O.......#O.....OO..OO#.....O#.O.OOO....O...#..O#O#.#OO...#....#...O...........
    .O.#.#...O.O.O.O.#.#O.O..#.OOOOOO.#.OO..#..###..#.#...#.O.O............OOO#O#.O..O....#...O...#.....
    ..#..OO..#O.....#.##..O...O.OO........#...OO..#...O....O..O....#O.........O...#.O.....O.#...O.....#.
    #O..#..#O.O#.O...O...O....#O#O.#O#OO...O#.O........O#....#.....#O#...O..O..#O..OOO##.#...O#...#..O..
    .....#O....O.OOO....#..#O......O.#..O.##.O.O.O...OO.O#...O..OO..#.#........##.....#............O.O..
    .O..O..#.O#.OO.O#.....O.O..#O..O.O.....#...OO...O#.##O........#.O.........O#...OOO...#O###...O..#...
    OO.#O....O.....#...#.O...O...O..#....O#....##....O.OOO.O...#.OO.O...O.O#O.....#.......O........O..O.
    ..O#O........O.O..O..#.##......#..#.OO......#.....#.O...#.#.OO#O.#..O....O#.O#..O.#..O#...O.O...O#..
    O##..O.#..#...###.###O##....#OOO..O.#.O....O.OO#O...O..O.........O##....OO.O....#....OO...O.........
    OOO..O.#.O.O.O...#.##..#.##.#...O#O..O.#.....#..O.#....O..O....O.....O...O..#.O.##.O#..O.....O...O..
    #.###.OO.....O..O..O...O.O#..#....####..#.......#.#.....O#O...O..O##O.#..#OOO.O#...O..O....#O.#....#
    .O#O.....O.#.#..OO....#.....#......#.....O.............O#..O..OOO#O#.OO#..O...O##..O.##O#...O#O.#..#
    .#...#.O.#..O..#.....OO..#O#....#.O.#.#..O#...#...#..OO#....O#..##O.............O...O..#O..O..O.#O..
    .....##OO.O..#..O#...O...O.#.#.##.O....OOO.#O..O.O.O##....O.O.#.O...OO.O...###O#.O.OO#..O....O......
    .O#O..#.O...#.#O...O##....O..#....O.O#.OO#O#O..O...O.#...O.O.O...O#..OO.O....#..#...OO..O.O.......#.
    O.O........OO...#.##..O........O....OO...O#..O.#OO.....O...O.O.......O....#O#O..O.OO............O..#
    ...#O...#O.O...O.##..O....OO#.##.....#...O....O.....#O..OO.#.O...O.....OO...#OO#......#O##O..O....OO
    ..#...O#.O..O.....#.....#...#..#..O....O...#......#..#..O#OO.....#O...O...#......O.#.###..#....O..#.
    .O.....#O.O......O#.O..O.##.O...O#OO..........O..###..#....O....O.....#..O#.O.....###......#..###..O
    .O..#.....#..##.##.O......O..O.O...O.O.......#.O..#....#.....O.#.O............OO#...O##...O.O#.O....
    .#.O.O#.#.#O.O..#....O.O..#.....#.#OO.O...##.OO..O.O......##.......O.O###.O..O.....#..OO#...#....#..
    ....#.#...#...#.OO..#..........OO......O#..#O##...OO.#..O.#..O.O.OO.....O#O.#..####.OO...#.O..#O..O.
    O.O..O..OOOO....O..O.#.........O....O.#O.#O...O.#....#..O.#..OO.O.#.O#...#....##..#...........#.O#.O
    .......O....#OOO.#.O.......#O#O....#.....OOO.#..#OO#..O.#O##O.O........O.#.O.OOO.....O......#.#....O
    ..O.....OO.#.#.O.....O##....O...OO......##..O#O.#O.O..#O.#.#....O...O.#.#..O.#.#OO..##....O......O..
    ..O#.#O.O.O..#...#O....O#O...O.........#.O...O#..O###O.....O..#.O....O#OO...O..O....OO#..#...#.....O
    .O.#....OO..O.O...O....#..........OO.##OO##OOO.##OOO..O...#...##....O..O#...O.#O..#.#O.O.....O.##.#.
    ....OO#O.........OO.#.O.O.O.#O.O.##..............OO..........O...O.......O..O##.O..#..#...O........O
    O.....#.....O#.#..#.O...O....##O#O.#.##...#..#........O#...#....##.O...#..O......O..OO#....OO.....#.
    ...O...#.#O.#..O...........O.O###.O.O...#..#O..O.OO..O..##O..#..#O#.O.OO.#O......O.O....#O.#..O...O#
    ..O......#...##.#..OOO....#..#.#.OOO....#.#OO#.#O.#.O.#...#.O.OOO.#...#..O..O..#..#.O....O##..O..#..
    .##..OO...#...#O#.O.....O#...#....O...............#..O#.#.#..OO.#..O.O#.O.....#OO.O.#.O..##...#.O#.O
    ..#.O.#...O..##.O#.O....O.O.O#O#.OO....#...#.O.......O#...#O........O.O.O.O.OO.#O........O..OO.O#...
    ...#..#OO#...#..#OO.#..#.O.#..OO..O.O....O##..#...OO..O....O#O...#....#...#O#.........O#OO.O...O.#..
    .O#OOO..#....O..#.O..#..OO##..OOO#O#O#O..#.O#.#......#.........##O..O...O#.....O.......###O#O.....OO
    O..OO....O.#..O#.#O#....O.O...##O...#O#O#...O.O...O.O#O.......#..#...OO...#O.#...O#...#.........O##.
    ...O.#O.#...O............#...O......##.......O..##O.O.OO.O.O....#O#..#O...#........OO.O..##.O.#.#O.#
    OO..O...#.....O..#OO..OO..#....#....O.O.#O.O.#O.OO...#..#OO..O#OO#.OO.....O...OO.O.O.....OO.#OO...O#
    .#...O...O.#OOO....O#...O.OO.##O...##.##.....O.O..#.....#O......O#...###O.#OO.#O.O.O...#.....#.OOO..
    """
  }
}
