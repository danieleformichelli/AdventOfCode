package com.formichelli.adventofcode.year2018

import com.formichelli.adventofcode.utils.Utils
import org.junit.Assert
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.Parameterized

@RunWith(Parameterized::class)
class Day12Test(private val part1Result: Long, private val part2Result: Long, private val generationAndRules: List<String>) {
    companion object {
        @JvmStatic
        @Parameterized.Parameters
        fun data(): Collection<Array<Any>> {
            return listOf(
                    arrayOf(2917L, 3250000000956L, Utils.readLinesFromFile("year2018/day12input.txt"))
            )
        }
    }

    @Test
    fun part1() {
        Assert.assertEquals("After 20 iterations the sum of the pot containing plantsIndexes is $part1Result", part1Result, Day12.part1(generationAndRules))
    }

    @Test
    fun part2() {
        Assert.assertEquals("After 50B iterations the sum of the pot containing plantsIndexes is $part2Result", part2Result, Day12.part2(generationAndRules))
    }
}