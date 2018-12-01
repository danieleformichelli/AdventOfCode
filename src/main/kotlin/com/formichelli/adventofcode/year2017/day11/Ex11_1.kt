package com.formichelli.adventofcode.year2017.day11

import com.formichelli.adventofcode.utils.getSingleLineInput

/*
Crossing the bridge, you've barely reached the other side of the stream when a program comes up to you, clearly in distress. "It's my child process," she says, "he's gotten lost in an infinite grid!"
Fortunately for her, you have plenty of experience with infinite grids.
Unfortunately for you, it's a hex grid.
The hexagons ("hexes") in this grid are aligned such that adjacent hexes can be found to the north, northeast, southeast, south, southwest, and northwest:
  \ n  /
nw +--+ ne
  /    \
-+      +-
  \    /
sw +--+ se
  / s  \
You have the path the child process took. Starting where he started, you need to determine the fewest number of steps required to reach him. (A "step" means to move from the hex you are in to any adjacent hex.)
For example:
ne,ne,ne is 3 steps away.
ne,ne,sw,sw is 0 steps away (back where you started).
ne,ne,s,s is 2 steps away (se,se).
se,sw,se,sw,sw is 3 steps away (s,s,sw).
*/
enum class Direction(val y: Int, val x: Int) {
    NW(1, -1), N(2, 0), NE(1, 1), SW(-1, -1), S(-2, 0), SE(-1, 1);

    companion object {
        fun fromString(str: String) = when (str) {
            "nw" -> NW
            "n" -> N
            "ne" -> NE
            "sw" -> SW
            "s" -> S
            "se" -> SE
            else -> throw IllegalArgumentException()
        }
    }
}

fun main(args: Array<String>) {
    val input = getSingleLineInput().split(",").map { Direction.fromString(it.trim()) }

    var y = 0
    var x = 0
    input.forEach {
        x += it.x
        y += it.y
    }

    println(computeDistance(x, y))
}

fun computeDistance(x: Int, y: Int): Int {
    var x1 = x
    var y1 = y
    x1 = Math.abs(x1)
    y1 = Math.abs(y1)

    // need to do x diagonal movement to go to x position
    val diagonalSteps = x1

    // while moving through x, we can also go x step in the y direction
    val verticalSteps = when {
        y1 > x1 -> (y1 - x1) / 2 // for each y step we move by 2 places
        y1 % 2 != x1 % 2 -> 1 // if x > y but x is even and y is odd or viceversa, we need an additional move
        else -> 0 // otherwise we are done
    }

    return diagonalSteps + verticalSteps
}