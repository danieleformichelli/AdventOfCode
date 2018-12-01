package com.formichelli.adventofcode.year2017.day14

import com.formichelli.adventofcode.year2017.day10.knotHash
import com.formichelli.adventofcode.utils.getSingleLineInput

/*
Now, all the defragmenter needs to know is the number of regions. A region is a group of used squares that are all adjacent, not including diagonals. Every used square is in exactly one region: lone used squares form their own isolated regions, while several adjacent squares all count as a single region.
In the example above, the following nine regions are visible, each marked with a distinct digit:
11.2.3..-->
.1.2.3.4
....5.6.
7.8.55.9
.88.5...
88..5..8
.8...8..
88.8.88.-->
|      |
V      V
Of particular interest is the region marked 8; while it does not appear contiguous in this small view, all of the squares marked 8 are connected when considering the whole 128x128 grid. In total, in this example, 1242 regions are present.
How many regions are present given your key string?
*/
fun main(args: Array<String>) {
    val digitToBits = mapOf(
            '0' to listOf(0, 0, 0, 0),
            '1' to listOf(0, 0, 0, -1),
            '2' to listOf(0, 0, -1, 0),
            '3' to listOf(0, 0, -1, -1),
            '4' to listOf(0, -1, 0, 0),
            '5' to listOf(0, -1, 0, -1),
            '6' to listOf(0, -1, -1, 0),
            '7' to listOf(0, -1, -1, -1),
            '8' to listOf(-1, 0, 0, 0),
            '9' to listOf(-1, 0, 0, -1),
            'a' to listOf(-1, 0, -1, 0),
            'b' to listOf(-1, 0, -1, -1),
            'c' to listOf(-1, -1, 0, 0),
            'd' to listOf(-1, -1, 0, -1),
            'e' to listOf(-1, -1, -1, 0),
            'f' to listOf(-1, -1, -1, -1)
    )
    val input = getSingleLineInput()
    val rows = (0 until 128).map { input + "-" + it }

    val charGrid = rows.map { knotHash(it.map { it.toInt() }.toMutableList()) }
    val bitsGrid = mutableListOf<MutableList<Int>>()
    charGrid.forEach {
        val bitsGridRow = mutableListOf<Int>()
        it.forEach {
            bitsGridRow.addAll(digitToBits[it]!!)
        }
        bitsGrid.add(bitsGridRow)
    }

    var regionsCount = 0
    for (i in 0 until 128) {
        for (j in 0 until 128) {
            regionsCount = bitsGrid.exploreRegion(i, j, regionsCount)
        }
    }

    println(regionsCount)
}

fun MutableList<MutableList<Int>>.exploreRegion(x: Int, y: Int, regionsCount: Int): Int {
    if (x in 0 until 128 && y in 0 until 128 && this[x][y] == -1) {
        this[x][y] = regionsCount + 1
        this.exploreRegion(x - 1, y, regionsCount)
        this.exploreRegion(x + 1, y, regionsCount)
        this.exploreRegion(x, y - 1, regionsCount)
        this.exploreRegion(x, y + 1, regionsCount)
        return regionsCount + 1
    }

    return regionsCount
}