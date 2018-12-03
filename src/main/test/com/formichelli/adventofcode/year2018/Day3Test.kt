package com.formichelli.adventofcode.year2018

import com.formichelli.adventofcode.utils.readLinesFromFile
import org.junit.Assert
import org.junit.Test

class Day3Test {
    private val inputFile = "day3input.txt"
    private val part1Result = 115304
    private val part2Result = "275"

    @Test
    fun part1() {
        Assert.assertEquals("$part1Result inches are claimed more than once", part1Result, Day3.part1(readLinesFromFile(inputFile)))
    }

    @Test
    fun part2() {
        Assert.assertEquals("$part2Result is the only claim that does not overlap", part2Result, Day3.part2(readLinesFromFile(inputFile)))
    }
}