package com.formichelli.adventofcode.year2018

import com.formichelli.adventofcode.utils.readLinesFromFile
import org.junit.Assert
import org.junit.Test

class Day2Test {
    private val inputFile = "day2input.txt"
    private val part1Result = 6916
    private val part2Result = "oeylbtcxjqnzhgyylfapviusr"

    @Test
    fun part1() {
        Assert.assertEquals("Resulting product of part 1 should be $part1Result", part1Result, Day2.part1(readLinesFromFile(inputFile)))
    }

    @Test
    fun part2() {
        Assert.assertEquals("Common letters in correct box IDs should be $part2Result", part2Result, Day2.part2(readLinesFromFile(inputFile)))
    }
}