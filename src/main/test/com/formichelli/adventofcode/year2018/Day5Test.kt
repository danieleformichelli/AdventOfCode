package com.formichelli.adventofcode.year2018

import com.formichelli.adventofcode.utils.Utils
import org.junit.Assert
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.Parameterized

@RunWith(Parameterized::class)
class Day5Test(private val part1Result: Int, private val part2Result: Int, private val part1Polymer: String, private val part2Polymer: String) {
    companion object {
        @JvmStatic
        @Parameterized.Parameters
        fun data(): Collection<Array<Any>> {
            return listOf(
                    arrayOf(10, 4, "dabAcCaCBAcCcaDA", "dabAcCaCBAcCcaDA"),
                    arrayOf(9154, 4556, Utils.readSingleLineFromFile("year2018/day5input.txt"), Utils.readSingleLineFromFile("year2018/day5input.txt"))
            )
        }
    }

    @Test
    fun part1() {
        Assert.assertEquals("The resulting polymer length is $part1Result", part1Result, Day5.part1(part1Polymer))
    }

    @Test
    fun part2() {
        Assert.assertEquals("The shortest resulting polymer after removing one unit length is $part2Result", part2Result, Day5.part2(part2Polymer))
    }
}