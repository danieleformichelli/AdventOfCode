package com.formichelli.adventofcode.year2018

import com.formichelli.adventofcode.utils.Utils
import org.junit.Assert
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.Parameterized

@RunWith(Parameterized::class)
class Day3Test(private val part1Result: Int, private val part2Result: Int, private val claims: List<String>) {
    companion object {
        @JvmStatic
        @Parameterized.Parameters
        fun data(): Collection<Array<Any>> {
            return listOf(
                    arrayOf(4, 3, listOf("#1 @ 1,3: 4x4", "#2 @ 3,1: 4x4", "#3 @ 5,5: 2x2")),
                    arrayOf(115304, 275, Utils.readLinesFromFile("year2018/day3input.txt"))
            )
        }
    }

    @Test
    fun part1() {
        Assert.assertEquals("$part1Result inches are claimed more than once", part1Result, Day3.part1(claims))
    }

    @Test
    fun part2() {
        Assert.assertEquals("$part2Result is the only claim that does not overlap", part2Result, Day3.part2(claims))
    }
}