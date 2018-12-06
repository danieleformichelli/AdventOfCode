package com.formichelli.adventofcode.year2018

import com.formichelli.adventofcode.utils.Utils
import org.junit.Assert
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.Parameterized

@RunWith(Parameterized::class)
class Day6Test(private val part1Result: Int, private val part2Result: Int, private val part1Coordinates: List<String>, private val part2Coordinates: List<String>, private val part2MaxTotalDistance: Int) {
    companion object {
        @JvmStatic
        @Parameterized.Parameters
        fun data(): Collection<Array<Any>> {
            return listOf(
                    arrayOf(17, 16, listOf("1, 1", "1, 6", "8, 3", "3, 4", "5, 5", "8, 9"), listOf("1, 1", "1, 6", "8, 3", "3, 4", "5, 5", "8, 9"), 32),
                    arrayOf(3293, 45176, Utils.readLinesFromFile("year2018/day6input.txt"), Utils.readLinesFromFile("year2018/day6input.txt"), 10000)
            )
        }
    }

    @Test
    fun part1() {
        Assert.assertEquals("The resulting polymer length is $part1Result", part1Result, Day6.part1(part1Coordinates))
    }

    @Test
    fun part2() {
        Assert.assertEquals("The shortest resulting polymer after removing one unit length is $part2Result", part2Result, Day6.part2(part2Coordinates, part2MaxTotalDistance))
    }
}