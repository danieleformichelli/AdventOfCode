package com.formichelli.adventofcode.year2018

import com.formichelli.adventofcode.utils.readIntsFromFile
import org.junit.Assert
import org.junit.Test

class Day1Test {
    private val inputFile = "day1input.txt"
    private val part1Result = 486
    private val part2Result = 69285

    @Test
    fun part1() {
        Assert.assertEquals("Resulting frequency of part 1 should be $part1Result", part1Result, Day1.part1(readIntsFromFile(inputFile)))
    }

    @Test
    fun part2() {
        Assert.assertEquals("Resulting frequency of part 2 should be $part2Result", part2Result, Day1.part2(readIntsFromFile(inputFile)))
    }
}