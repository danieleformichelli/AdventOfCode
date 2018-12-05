package com.formichelli.adventofcode.year2018

import com.formichelli.adventofcode.utils.Utils
import org.junit.Assert
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.Parameterized

@RunWith(Parameterized::class)
class Day1Test(private val part1Result: Int, private val part2Result: Int, private val part1Frequencies: List<Int>, private val part2Frequencies: List<Int>) {
    companion object {
        @JvmStatic
        @Parameterized.Parameters
        fun data(): Collection<Array<Any>> {
            return listOf(
                    arrayOf(3, 10, listOf(+1, +1, +1), listOf(+3, +3, +4, -2, -4)),
                    arrayOf(0, 5, listOf(+1, +1, -2), listOf(-6, +3, +8, +5, -6)),
                    arrayOf(-6, 14, listOf(-1, -2, -3), listOf(+7, +7, -2, -7, -4)),
                    arrayOf(486, 69285, Utils.readIntsFromFile("year2018/day1input.txt"), Utils.readIntsFromFile("year2018/day1input.txt"))
            )
        }
    }

    @Test
    fun part1() {
        Assert.assertEquals("Resulting frequency of part 1 should be $part1Result", part1Result, Day1.part1(part1Frequencies))
    }

    @Test
    fun part2() {
        Assert.assertEquals("Resulting frequency of part 2 should be $part2Result", part2Result, Day1.part2(part2Frequencies))
    }
}