package com.formichelli.adventofcode.year2018

import com.formichelli.adventofcode.utils.Utils
import org.junit.Assert
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.Parameterized

@RunWith(Parameterized::class)
class Day8Test(private val part1Result: Int, private val part2Result: Int, private val part1Tree: String, private val part2Tree: String) {
    companion object {
        @JvmStatic
        @Parameterized.Parameters
        fun data(): Collection<Array<Any>> {
            return listOf(
                    arrayOf(138, 66, "2 3 0 3 10 11 12 1 1 0 1 99 2 1 1 2", "2 3 0 3 10 11 12 1 1 0 1 99 2 1 1 2"),
                    arrayOf(138, 20849, Utils.readSingleLineFromFile("year2018/day8input.txt"), Utils.readSingleLineFromFile("year2018/day8input.txt"))
            )
        }
    }

    @Test
    fun part1() {
        Assert.assertEquals("The sum of the metadata values is $part1Result", part1Result, Day8.part1(part1Tree))
    }

    @Test
    fun part2() {
        Assert.assertEquals("The value of the root node is $part2Result", part2Result, Day8.part2(part2Tree))
    }
}