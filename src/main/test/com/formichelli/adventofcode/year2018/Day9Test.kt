package com.formichelli.adventofcode.year2018

import com.formichelli.adventofcode.utils.Utils
import org.junit.Assert
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.Parameterized

@RunWith(Parameterized::class)
class Day9Test(private val part1Result: Long, private val part2Result: Long, private val elvesAndMarbles: String) {
    companion object {
        @JvmStatic
        @Parameterized.Parameters
        fun data(): Collection<Array<Any>> {
            return listOf(
                    arrayOf(32, 24020, "9 players; last marble is worth 25 points"),
                    arrayOf(8317, 74868857, "10 players; last marble is worth 1618 points"),
                    arrayOf(146373, 1406772579, "13 players; last marble is worth 7999 points"),
                    arrayOf(2764, 20605511, "17 players; last marble is worth 1104 points"),
                    arrayOf(54718, 507884602, "21 players; last marble is worth 6111 points"),
                    arrayOf(37305, 321200047, "30 players; last marble is worth 5807 points"),
                    arrayOf(439635, 3562722971, Utils.readSingleLineFromFile("year2018/day9input.txt"))
            )
        }
    }

    @Test
    fun part1() {
        Assert.assertEquals("The winning elf's score is $part1Result", part1Result, Day9.part1(elvesAndMarbles))
    }

    @Test
    fun part2() {
        Assert.assertEquals("The value of the root node is $part2Result", part2Result, Day9.part2(elvesAndMarbles))
    }
}