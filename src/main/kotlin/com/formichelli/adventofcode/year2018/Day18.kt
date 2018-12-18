package com.formichelli.adventofcode.year2018

import com.formichelli.adventofcode.utils.Coordinate
import java.util.*

object Day18 {
    /*
    --- Day 18: Settlers of The North Pole ---
    On the outskirts of the North Pole base construction project, many Elves are collecting lumber.

    The lumber collection area is 50 acres by 50 acres; each acre can be either open ground (.), trees (|), or a lumberyard (#). You take a scan of the area (your puzzle input).

    Strange magic is at work here: each minute, the landscape looks entirely different. In exactly one minute, an open acre can fill with trees, a wooded acre can be converted to a lumberyard, or a lumberyard can be cleared to open ground (the lumber having been sent to other projects).

    The change to each acre is based entirely on the contents of that acre as well as the number of open, wooded, or lumberyard acres adjacent to it at the start of each minute. Here, "adjacent" means any of the eight acres surrounding that acre. (Acres on the edges of the lumber collection area might have fewer than eight adjacent acres; the missing acres aren't counted.)

    In particular:

    An open acre will become filled with trees if three or more adjacent acres contained trees. Otherwise, nothing happens.
    An acre filled with trees will become a lumberyard if three or more adjacent acres were lumberyards. Otherwise, nothing happens.
    An acre containing a lumberyard will remain a lumberyard if it was adjacent to at least one other lumberyard and at least one acre containing trees. Otherwise, it becomes open.
    These changes happen across all acres simultaneously, each of them using the state of all acres at the beginning of the minute and changing to their new form by the end of that same minute. Changes that happen during the minute don't affect each other.

    For example, suppose the lumber collection area is instead only 10 by 10 acres with this initial configuration:

    Initial state:
    .#.#...|#.
    .....#|##|
    .|..|...#.
    ..|#.....#
    #.#|||#|#|
    ...#.||...
    .|....|...
    ||...#|.#|
    |.||||..|.
    ...#.|..|.

    After 1 minute:
    .......##.
    ......|###
    .|..|...#.
    ..|#||...#
    ..##||.|#|
    ...#||||..
    ||...|||..
    |||||.||.|
    ||||||||||
    ....||..|.

    After 2 minutes:
    .......#..
    ......|#..
    .|.|||....
    ..##|||..#
    ..###|||#|
    ...#|||||.
    |||||||||.
    ||||||||||
    ||||||||||
    .|||||||||

    After 3 minutes:
    .......#..
    ....|||#..
    .|.||||...
    ..###|||.#
    ...##|||#|
    .||##|||||
    ||||||||||
    ||||||||||
    ||||||||||
    ||||||||||

    After 4 minutes:
    .....|.#..
    ...||||#..
    .|.#||||..
    ..###||||#
    ...###||#|
    |||##|||||
    ||||||||||
    ||||||||||
    ||||||||||
    ||||||||||

    After 5 minutes:
    ....|||#..
    ...||||#..
    .|.##||||.
    ..####|||#
    .|.###||#|
    |||###||||
    ||||||||||
    ||||||||||
    ||||||||||
    ||||||||||

    After 6 minutes:
    ...||||#..
    ...||||#..
    .|.###|||.
    ..#.##|||#
    |||#.##|#|
    |||###||||
    ||||#|||||
    ||||||||||
    ||||||||||
    ||||||||||

    After 7 minutes:
    ...||||#..
    ..||#|##..
    .|.####||.
    ||#..##||#
    ||##.##|#|
    |||####|||
    |||###||||
    ||||||||||
    ||||||||||
    ||||||||||

    After 8 minutes:
    ..||||##..
    ..|#####..
    |||#####|.
    ||#...##|#
    ||##..###|
    ||##.###||
    |||####|||
    ||||#|||||
    ||||||||||
    ||||||||||

    After 9 minutes:
    ..||###...
    .||#####..
    ||##...##.
    ||#....###
    |##....##|
    ||##..###|
    ||######||
    |||###||||
    ||||||||||
    ||||||||||

    After 10 minutes:
    .||##.....
    ||###.....
    ||##......
    |##.....##
    |##.....##
    |##....##|
    ||##.####|
    ||#####|||
    ||||#|||||
    ||||||||||
    After 10 minutes, there are 37 wooded acres and 31 lumberyards. Multiplying the number of wooded acres by the number of lumberyards gives the total resource value after ten minutes: 37 * 31 = 1147.

    What will the total resource value of the lumber collection area be after 10 minutes?
     */
    fun part1(lumberMapStr: List<String>): Int {
        return day18Helper(lumberMapStr, 10L)
    }

    /*
    --- Part Two ---
    This important natural resource will need to last for at least thousands of years. Are the Elves collecting this lumber sustainably?

    What will the total resource value of the lumber collection area be after 1000000000 minutes?
    */
    fun part2(lumberMapStr: List<String>): Int {
        return day18Helper(lumberMapStr, 1000000000L)
    }

    private fun day18Helper(lumberMapStr: List<String>, minutes: Long): Int {
        var (mapSize, currentMap) = parseInput(lumberMapStr)

        val previousMaps = HashMap<Map<Coordinate, LumberMapElement>, Long>()
        var loopFound = false
        var i = 0L
        while (i < minutes) {
            val alreadySeenAt = previousMaps.put(currentMap, i)
            if (!loopFound && alreadySeenAt != null) {
                loopFound = true
                val loopSize = i - alreadySeenAt
                while (i < minutes - loopSize) {
                    i += loopSize
                }
            }

            val nextMap = HashMap<Coordinate, LumberMapElement>()
            for (y in 0 until mapSize) {
                for (x in 0 until mapSize) {
                    val currentCoordinates = Coordinate(x, y)
                    val element = currentMap[Coordinate(x, y)]
                    if (element == null) {
                        // An open acre will become filled with trees if three or more adjacent acres contained trees. Otherwise, nothing happens.
                        if (currentCoordinates.adjacents().count { currentMap[it] == LumberMapElement.TREE } >= 3) {
                            nextMap[currentCoordinates] = LumberMapElement.TREE
                        }
                    } else if (element == LumberMapElement.TREE) {
                        // An acre filled with trees will become a lumberyard if three or more adjacent acres were lumberyards. Otherwise, nothing happens.
                        if (currentCoordinates.adjacents().count { currentMap[it] == LumberMapElement.LUMBERYARD } >= 3) {
                            nextMap[currentCoordinates] = LumberMapElement.LUMBERYARD
                        } else {
                            nextMap[currentCoordinates] = LumberMapElement.TREE
                        }
                    } else if (element == LumberMapElement.LUMBERYARD) {
                        // An acre containing a lumberyard will remain a lumberyard if it was adjacent to at least one other lumberyard and at least one acre containing trees. Otherwise, it becomes open.
                        val adjacents = currentCoordinates.adjacents()
                        if (adjacents.count { currentMap[it] == LumberMapElement.LUMBERYARD } >= 1 && adjacents.count { currentMap[it] == LumberMapElement.TREE } >= 1) {
                            nextMap[currentCoordinates] = LumberMapElement.LUMBERYARD
                        }
                    }
                }
            }

            currentMap = nextMap
            ++i
        }

        var treesCount = 0
        var lumberyardsCount = 0
        for (element in currentMap) {
            if (element.value == LumberMapElement.TREE) {
                ++treesCount
            } else if (element.value == LumberMapElement.LUMBERYARD) {
                ++lumberyardsCount
            }
        }

        return treesCount * lumberyardsCount
    }

    enum class LumberMapElement {
        TREE, LUMBERYARD
    }

    private fun parseInput(lumberMapStr: List<String>): Pair<Int, HashMap<Coordinate, LumberMapElement>> {
        val mapSize = lumberMapStr.size
        val lumberMap = HashMap<Coordinate, LumberMapElement>()
        for (y in 0 until mapSize) {
            for (x in 0 until mapSize) {
                when (lumberMapStr[y][x]) {
                    '|' -> lumberMap[Coordinate(x, y)] = LumberMapElement.TREE
                    '#' -> lumberMap[Coordinate(x, y)] = LumberMapElement.LUMBERYARD
                }
            }
        }

        return Pair(mapSize, lumberMap)
    }

}