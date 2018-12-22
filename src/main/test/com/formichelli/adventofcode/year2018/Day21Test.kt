package com.formichelli.adventofcode.year2018

import com.formichelli.adventofcode.utils.Utils
import org.junit.Assert
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.Parameterized

@RunWith(Parameterized::class)
class Day21Test(private val part1Result: Int, private val part2Result: Int, private val opCodes: List<String>) {
    companion object {
        @JvmStatic
        @Parameterized.Parameters
        fun data(): Collection<Array<Any>> {
            return listOf(
                    arrayOf(7224964, 13813247, Utils.readLinesFromFile("year2018/day21input.txt"))
            )
        }
    }

    @Test
    fun part1() {
        Assert.assertEquals("Lowest number that causes the program to halt after executing the fewest operations is $part1Result", part1Result, Day21.part1(opCodes))
    }

    @Test
    fun part2() {
        Assert.assertEquals("Longest path to a room requires $part2Result steps", part2Result, Day21.part2(opCodes))
    }
}