package com.formichelli.adventofcode.year2018

object Day6 {
    /*
    --- Day 6: Chronal Coordinates ---
    The device on your wrist beeps several times, and once again you feel like you're falling.

    "Situation critical," the device announces. "Destination indeterminate. Chronal interference detected. Please specify new target coordinates."

    The device then produces a list of coordinates (your puzzle input). Are they places it thinks are safe or dangerous? It recommends you check manual page 729. The Elves did not give you a manual.

    If they're dangerous, maybe you can minimize the danger by finding the coordinate that gives the largest distance from the other points.

    Using only the Manhattan distance, determine the area around each coordinate by counting the number of integer X,Y locations that are closest to that coordinate (and aren't tied in distance to any other coordinate).

    Your goal is to find the size of the largest area that isn't infinite. For example, consider the following list of coordinates:

    1, 1
    1, 6
    8, 3
    3, 4
    5, 5
    8, 9
    If we name these coordinates A through F, we can draw them on a grid, putting 0,0 at the top left:

    ..........
    .A........
    ..........
    ........C.
    ...D......
    .....E....
    .B........
    ..........
    ..........
    ........F.
    This view is partial - the actual grid extends infinitely in all directions. Using the Manhattan distance, each location's closest coordinate can be determined, shown here in lowercase:

    aaaaa.cccc
    aAaaa.cccc
    aaaddecccc
    aadddeccCc
    ..dDdeeccc
    bb.deEeecc
    bBb.eeee..
    bbb.eeefff
    bbb.eeffff
    bbb.ffffFf
    Locations shown as . are equally far from two or more coordinates, and so they don't count as being closest to any.

    In this example, the areas of coordinates A, B, C, and F are infinite - while not shown here, their areas extend forever outside the visible grid. However, the areas of coordinates D and E are finite: D is closest to 9 locations, and E is closest to 17 (both including the coordinate's location itself). Therefore, in this example, the size of the largest area is 17.

    What is the size of the largest area that isn't infinite?
     */
    fun part1(coordinates: List<String>): Int {
        val coordinatePairs = coordinates.map {
            val coordinateSplit = it.split(", ")
            Pair(coordinateSplit[0].toInt(), coordinateSplit[1].toInt())
        }

        val minX = coordinatePairs.map { it.first }.min()!!
        val maxX = coordinatePairs.map { it.first }.max()!!
        val minY = coordinatePairs.map { it.second }.min()!!
        val maxY = coordinatePairs.map { it.second }.max()!!

        // calculate min distances and areas
        val distanceMap = Array(maxX - minX + 1) { IntArray(maxY - minY + 1) }
        val areaSizes = HashMap<Int, Int>()
        for (x in minX..maxX) {
            for (y in minY..maxY) {
                var nearestPoint = -1
                var nearestPointDistance = Int.MAX_VALUE
                coordinatePairs.forEachIndexed { index, coordinate ->
                    val manhattanDistance = Math.abs(coordinate.first - x) + Math.abs(coordinate.second - y)
                    when {
                        manhattanDistance < nearestPointDistance -> {
                            nearestPointDistance = manhattanDistance
                            nearestPoint = index
                        }
                        manhattanDistance == nearestPointDistance -> nearestPoint = -1
                    }
                }

                distanceMap[x - minX][y - minY] = nearestPoint
                if (nearestPoint != -1) {
                    areaSizes[nearestPoint] = areaSizes.getOrDefault(nearestPoint, 0) + 1
                }
            }
        }

        // discard infinite areas
        for (x in 0 until distanceMap.size) {
            var pointWithInfiniteDistance = distanceMap[x][0]
            if (pointWithInfiniteDistance != -1) {
                areaSizes.remove(pointWithInfiniteDistance)
            }
            pointWithInfiniteDistance = distanceMap[x][distanceMap[0].size - 1]
            if (pointWithInfiniteDistance != -1) {
                areaSizes.remove(pointWithInfiniteDistance)
            }
        }
        for (y in 0 until distanceMap[0].size) {
            var pointWithInfiniteDistance = distanceMap[0][y]
            if (pointWithInfiniteDistance != -1) {
                areaSizes.remove(pointWithInfiniteDistance)
            }
            pointWithInfiniteDistance = distanceMap[distanceMap.size - 1][y]
            if (pointWithInfiniteDistance != -1) {
                areaSizes.remove(pointWithInfiniteDistance)
            }
        }

        return areaSizes.values.max()!!
    }

    /*
    --- Part Two ---
    On the other hand, if the coordinates are safe, maybe the best you can do is try to find a region near as many coordinates as possible.

    For example, suppose you want the sum of the Manhattan distance to all of the coordinates to be less than 32. For each location, add up the distances to all of the given coordinates; if the total of those distances is less than 32, that location is within the desired region. Using the same coordinates as above, the resulting region looks like this:

    ..........
    .A........
    ..........
    ...###..C.
    ..#D###...
    ..###E#...
    .B.###....
    ..........
    ..........
    ........F.
    In particular, consider the highlighted location 4,3 located at the top middle of the region. Its calculation is as follows, where abs() is the absolute value function:

    Distance to coordinate A: abs(4-1) + abs(3-1) =  5
    Distance to coordinate B: abs(4-1) + abs(3-6) =  6
    Distance to coordinate C: abs(4-8) + abs(3-3) =  4
    Distance to coordinate D: abs(4-3) + abs(3-4) =  2
    Distance to coordinate E: abs(4-5) + abs(3-5) =  3
    Distance to coordinate F: abs(4-8) + abs(3-9) = 10
    Total distance: 5 + 6 + 4 + 2 + 3 + 10 = 30
    Because the total distance to all coordinates (30) is less than 32, the location is within the region.

    This region, which also includes coordinates D and E, has a total size of 16.

    Your actual region will need to be much larger than this example, though, instead including all locations with a total distance of less than 10000.

    What is the size of the region containing all locations which have a total distance to all given coordinates of less than 10000?
     */
    fun part2(coordinates: List<String>, maxTotalDistance: Int): Int {
        val coordinatePairs = coordinates.map {
            val coordinateSplit = it.split(", ")
            Pair(coordinateSplit[0].toInt(), coordinateSplit[1].toInt())
        }

        val minX = coordinatePairs.map { it.first }.min()!!
        val maxX = coordinatePairs.map { it.first }.max()!!
        val minY = coordinatePairs.map { it.second }.min()!!
        val maxY = coordinatePairs.map { it.second }.max()!!

        // calculate total Manhattan distances for each coordinate
        var regionSize = 0
        for (x in minX..maxX) {
            for (y in minY..maxY) {
                var totalManhattanDistance = 0
                coordinatePairs.forEach {
                    val manhattanDistance = Math.abs(it.first - x) + Math.abs(it.second - y)
                    totalManhattanDistance += manhattanDistance
                }

                if (totalManhattanDistance < maxTotalDistance) {
                    ++regionSize
                }
            }
        }

        return regionSize
    }
}