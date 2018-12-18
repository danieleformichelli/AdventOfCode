package com.formichelli.adventofcode.year2018

import com.formichelli.adventofcode.utils.Coordinate
import java.util.*

object Day17 {
    /*
    --- Day 17: Reservoir Research ---
    You arrive in the year 18. If it weren't for the coat you got in 1018, you would be very cold: the North Pole base hasn't even been constructed.

    Rather, it hasn't been constructed yet. The Elves are making a little progress, but there's not a lot of liquid water in this climate, so they're getting very dehydrated. Maybe there's more underground?

    You scan a two-dimensional vertical slice of the ground nearby and discover that it is mostly sand with veins of clay. The scan only provides data with a granularity of square meters, but it should be good enough to determine how much water is trapped there. In the scan, x represents the distance to the right, and y represents the distance down. There is also a spring of water near the surface at x=500, y=0. The scan identifies which square meters are clay (your puzzle input).

    For example, suppose your scan shows the following veins of clay:

    x=495, y=2..7
    y=7, x=495..501
    x=501, y=3..7
    x=498, y=2..4
    x=506, y=1..2
    x=498, y=10..13
    x=504, y=10..13
    y=13, x=498..504
    Rendering clay as #, sand as ., and the water spring as +, and with x increasing to the right and y increasing downward, this becomes:

       44444455555555
       99999900000000
       45678901234567
     0 ......+.......
     1 ............#.
     2 .#..#.......#.
     3 .#..#..#......
     4 .#..#..#......
     5 .#.....#......
     6 .#.....#......
     7 .#######......
     8 ..............
     9 ..............
    10 ....#.....#...
    11 ....#.....#...
    12 ....#.....#...
    13 ....#######...
    The spring of water will produce water forever. Water can move through sand, but is blocked by clay. Water always moves down when possible, and spreads to the left and right otherwise, filling space that has clay on both sides and falling out otherwise.

    For example, if five squares of water are created, they will flow downward until they reach the clay and settle there. Water that has come to rest is shown here as ~, while sand through which water has passed (but which is now dry again) is shown as |:

    ......+.......
    ......|.....#.
    .#..#.|.....#.
    .#..#.|#......
    .#..#.|#......
    .#....|#......
    .#~~~~~#......
    .#######......
    ..............
    ..............
    ....#.....#...
    ....#.....#...
    ....#.....#...
    ....#######...
    Two squares of water can't occupy the same location. If another five squares of water are created, they will settle on the first five, filling the clay reservoir a little more:

    ......+.......
    ......|.....#.
    .#..#.|.....#.
    .#..#.|#......
    .#..#.|#......
    .#~~~~~#......
    .#~~~~~#......
    .#######......
    ..............
    ..............
    ....#.....#...
    ....#.....#...
    ....#.....#...
    ....#######...
    Water pressure does not apply in this scenario. If another four squares of water are created, they will stay on the right side of the barrier, and no water will reach the left side:

    ......+.......
    ......|.....#.
    .#..#.|.....#.
    .#..#~~#......
    .#..#~~#......
    .#~~~~~#......
    .#~~~~~#......
    .#######......
    ..............
    ..............
    ....#.....#...
    ....#.....#...
    ....#.....#...
    ....#######...
    At this point, the top reservoir overflows. While water can reach the tiles above the surface of the water, it cannot settle there, and so the next five squares of water settle like this:

    ......+.......
    ......|.....#.
    .#..#||||...#.
    .#..#~~#|.....
    .#..#~~#|.....
    .#~~~~~#|.....
    .#~~~~~#|.....
    .#######|.....
    ........|.....
    ........|.....
    ....#...|.#...
    ....#...|.#...
    ....#~~~~~#...
    ....#######...
    Note especially the leftmost |: the new squares of water can reach this tile, but cannot stop there. Instead, eventually, they all fall to the right and settle in the reservoir below.

    After 10 more squares of water, the bottom reservoir is also full:

    ......+.......
    ......|.....#.
    .#..#||||...#.
    .#..#~~#|.....
    .#..#~~#|.....
    .#~~~~~#|.....
    .#~~~~~#|.....
    .#######|.....
    ........|.....
    ........|.....
    ....#~~~~~#...
    ....#~~~~~#...
    ....#~~~~~#...
    ....#######...
    Finally, while there is nowhere left for the water to settle, it can reach a few more tiles before overflowing beyond the bottom of the scanned data:

    ......+.......    (line not counted: above minimum y value)
    ......|.....#.
    .#..#||||...#.
    .#..#~~#|.....
    .#..#~~#|.....
    .#~~~~~#|.....
    .#~~~~~#|.....
    .#######|.....
    ........|.....
    ...|||||||||..
    ...|#~~~~~#|..
    ...|#~~~~~#|..
    ...|#~~~~~#|..
    ...|#######|..
    ...|.......|..    (line not counted: below maximum y value)
    ...|.......|..    (line not counted: below maximum y value)
    ...|.......|..    (line not counted: below maximum y value)
    How many tiles can be reached by the water? To prevent counting forever, ignore tiles with a y coordinate smaller than the smallest y coordinate in your scan data or larger than the largest one. Any x coordinate is valid. In this example, the lowest y coordinate given is 1, and the highest is 13, causing the water spring (in row 0) and the water falling off the bottom of the render (in rows 14 through infinity) to be ignored.

    So, in the example above, counting both water at rest (~) and other sand tiles the water can hypothetically reach (|), the total number of tiles the water can reach is 57.

    How many tiles can the water reach within the range of y values in your scan?
     */
    fun part1(clayCoordinates: List<String>): Int {
        val (minAndMaxY, clayMap) = parseInput(clayCoordinates)
        val waterAtY = day17Helper(minAndMaxY, clayMap)

        return countWaterTiles(waterAtY, minAndMaxY)
    }

    /*
    --- Part Two ---
    After a very long time, the water spring will run dry. How much water will be retained?

    In the example above, water that won't eventually drain out is shown as ~, a total of 29 tiles.

    How many water tiles are left after the water spring stops producing water and all remaining water not at rest has drained?
    */
    fun part2(clayCoordinates: List<String>): Int {
        val (minAndMaxY, clayMap) = parseInput(clayCoordinates)
        val waterAtY = day17Helper(minAndMaxY, clayMap)

        for (y in minAndMaxY.first..minAndMaxY.second) {
            val toBeRemoved = HashSet<Int>()
            val waterAtLevel = waterAtY[y]!!
            for (x in waterAtLevel) {
                if (toBeRemoved.contains(x - 1) || (!clayMap.contains(Coordinate(x - 1, y)) && !waterAtLevel.contains(x - 1))) {
                    toBeRemoved.add(x)
                }

                if (!clayMap.contains(Coordinate(x + 1, y)) && !waterAtLevel.contains(x + 1)) {
                    var currentX = x
                    while (waterAtLevel.contains(currentX)) {
                        toBeRemoved.add(currentX--)
                    }
                }
            }

            toBeRemoved.forEach {
                waterAtLevel.remove(it)
            }
        }

        var minX = Int.MAX_VALUE
        var maxX = Int.MIN_VALUE
        for (waterAtLevel in waterAtY.values) {
            for (x in waterAtLevel) {
                minX = Math.min(minX, x)
                maxX = Math.max(maxX, x)
            }
        }

        clayMap.forEach {
            minX = Math.min(minX, it.x)
            maxX = Math.max(maxX, it.x)
        }

        for (y in minAndMaxY.first..minAndMaxY.second) {
            for (x in minX..maxX) {
                when {
                    waterAtY[y]!!.contains(x) -> System.out.print('~')
                    clayMap.contains(Coordinate(x, y)) -> System.out.print('#')
                    else -> System.out.print(' ')
                }
            }
            System.out.println()
        }

        return countWaterTiles(waterAtY, minAndMaxY)
    }

    private fun day17Helper(minAndMaxY: Pair<Int, Int>, clayMap: Set<Coordinate>): HashMap<Int, MutableSet<Int>> {
        val waterStartX = 500

        val waterAtY = HashMap<Int, MutableSet<Int>>()
        waterAtY[minAndMaxY.first - 1] = TreeSet(setOf(waterStartX))
        dropWater(waterStartX, minAndMaxY.first - 1, clayMap, waterAtY, minAndMaxY.second)

        var minX = Int.MAX_VALUE
        var maxX = Int.MIN_VALUE
        for (waterAtLevel in waterAtY.values) {
            for (x in waterAtLevel) {
                minX = Math.min(minX, x)
                maxX = Math.max(maxX, x)
            }
        }

        clayMap.forEach {
            minX = Math.min(minX, it.x)
            maxX = Math.max(maxX, it.x)
        }

        // cleanup
        for (y in minAndMaxY.first until minAndMaxY.second) {
            val waterAtLevel = waterAtY.computeIfAbsent(y) { TreeSet() }
            val waterAtNextLevel = waterAtY.computeIfAbsent(y + 1) { TreeSet() }
            val toBeRemoved = TreeSet<Int>()
            for (x in waterAtLevel) {
                if (!waterAtNextLevel.contains(x) && !clayMap.contains(Coordinate(x, y + 1))) {
                    toBeRemoved.add(x)
                }
            }
            for (x in toBeRemoved) {
                waterAtLevel.remove(x)
            }
        }

        return waterAtY
    }

    private fun dropWater(x: Int, y: Int, clayMap: Set<Coordinate>, waterAtY: HashMap<Int, MutableSet<Int>>, maxY: Int): Boolean {
        if (y > maxY) {
            return true
        }

        var currentY = y
        while (!clayMap.contains(Coordinate(x, currentY + 1))) {
            // water drops down
            waterAtY.computeIfAbsent(currentY + 1) { TreeSet() }.add(x)
            ++currentY
            if (currentY > maxY) {
                return true
            }
        }

        // water fills nearby
        while (true) {
            if (!waterAtY.computeIfAbsent(currentY) { TreeSet() }.contains(x)) {
                return false
            }

            // TODO something is wrong here, cleanup is required because some tiles remain water filled
            val (lastXOnLeft, lastXOnRight) = waterFills(clayMap, waterAtY, x, currentY)
            if (!waterAtY.computeIfAbsent(currentY + 1) { TreeSet() }.contains(lastXOnLeft) && waterAtY.computeIfAbsent(currentY + 1) { TreeSet() }.contains(lastXOnLeft + 1)) {
                waterAtY[currentY]!!.remove(lastXOnLeft)
                return true
            }
            if (!waterAtY.computeIfAbsent(currentY + 1) { TreeSet() }.contains(lastXOnRight) && waterAtY.computeIfAbsent(currentY + 1) { TreeSet() }.contains(lastXOnRight - 1)) {
                waterAtY[currentY]!!.remove(lastXOnRight)
                return true
            }

            val leftDrops = !clayMap.contains(Coordinate(lastXOnLeft, currentY + 1)) && !waterAtY.computeIfAbsent(currentY + 1) { TreeSet() }.contains(lastXOnLeft)
            val rightDrops = !clayMap.contains(Coordinate(lastXOnRight, currentY + 1)) && !waterAtY.computeIfAbsent(currentY + 1) { TreeSet() }.contains(lastXOnRight)
            val done = if (leftDrops || rightDrops) {
                val leftDone = if (leftDrops) dropWater(lastXOnLeft, currentY, clayMap, waterAtY, maxY) else true
                val rightDone = if (rightDrops) dropWater(lastXOnRight, currentY, clayMap, waterAtY, maxY) else true

                leftDone && rightDone
            } else {
                // walls on both sides, fill previous level
                false
            }

            if (done) {
                return true
            }

            --currentY
        }
    }

    private fun waterFills(clayMap: Set<Coordinate>, waterAtY: Map<Int, MutableSet<Int>>, x: Int, y: Int): Pair<Int, Int> {
        val lastXOnLeft = fillDirection(clayMap, waterAtY, x, y, -1)
        val lastXOnRight = fillDirection(clayMap, waterAtY, x, y, +1)
        return Pair(lastXOnLeft, lastXOnRight)
    }

    private fun fillDirection(clayMap: Set<Coordinate>, waterAtY: Map<Int, MutableSet<Int>>, x: Int, y: Int, dx: Int): Int {
        var currentX = x
        val waterAtLevel = waterAtY[y]!!
        val waterBelow = waterAtY[y + 1] ?: emptySet<Int>()
        while (clayMap.contains(Coordinate(currentX, y + 1)) || waterBelow.contains(currentX)) {
            currentX += dx
            if (clayMap.contains(Coordinate(currentX, y))) {
                // wall found
                return currentX - dx
            }

            waterAtLevel.add(currentX)
        }

        return currentX
    }

    private fun parseInput(clayCoordinates: List<String>): Pair<Pair<Int, Int>, Set<Coordinate>> {
        val clayMap = HashSet<Coordinate>()
        var minY = Int.MAX_VALUE
        var maxY = Int.MIN_VALUE
        for (clayCoordinate in clayCoordinates) {
            val coordinateSplit = clayCoordinate.split("x=", ", ", "y=", "..")
            val fixedCoordinate = coordinateSplit[1].toInt()
            val movingCoordinateFrom = coordinateSplit[3].toInt()
            val movingCoordinateTo = coordinateSplit[4].toInt()
            for (movingCoordinate in movingCoordinateFrom..movingCoordinateTo) {
                if (clayCoordinate.startsWith("x")) {
                    clayMap.add(Coordinate(fixedCoordinate, movingCoordinate))
                    minY = Math.min(minY, movingCoordinate)
                    maxY = Math.max(maxY, movingCoordinate)
                } else {
                    clayMap.add(Coordinate(movingCoordinate, fixedCoordinate))
                    minY = Math.min(minY, fixedCoordinate)
                    maxY = Math.max(maxY, fixedCoordinate)
                }
            }
        }

        return Pair(Pair(minY, maxY), clayMap)
    }

    private fun countWaterTiles(waterAtY: HashMap<Int, MutableSet<Int>>, minAndMaxY: Pair<Int, Int>): Int {
        return waterAtY.filter { it.key >= minAndMaxY.first && it.key <= minAndMaxY.second }.map { it.value.size }.sum()
    }

}