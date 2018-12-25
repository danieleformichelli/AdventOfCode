package com.formichelli.adventofcode.year2018

import com.formichelli.adventofcode.utils.Utils
import org.junit.Assert
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.Parameterized

@RunWith(Parameterized::class)
class Day25Test(private val part1Result: Int, private val part2Result: Int, private val immuneSystemBattle: List<String>) {
    companion object {
        @JvmStatic
        @Parameterized.Parameters
        fun data(): Collection<Array<Any>> {
            return listOf(
                    arrayOf(2, 2, listOf("0,0,0,0", "3,0,0,0", "0,3,0,0", "0,0,3,0", "0,0,0,3", "0,0,0,6", "9,0,0,0", "12,0,0,0")),
                    arrayOf(4, 4, listOf("-1,2,2,0", "0,0,2,-2", "0,0,0,-2", "-1,2,0,0", "-2,-2,-2,2", "3,0,2,-1", "-1,3,2,2", "-1,0,-1,0", "0,2,1,-2", "3,0,0,0")),
                    arrayOf(3, 3, listOf("1,-1,0,1", "2,0,-1,0", "3,2,-1,0", "0,0,3,1", "0,0,-1,-1", "2,3,-2,0", "-2,2,0,0", "2,-2,0,-1", "1,-1,0,-1", "3,2,0,2")),
                    arrayOf(8, 8, listOf("1,-1,-1,-2", "-2,-2,0,1", "0,2,1,3", "-2,3,-2,1", "0,2,3,-2", "-1,-1,1,-2", "0,-2,-1,0", "-2,2,3,-1", "1,2,2,0", "-1,-2,0,-2")),
                    arrayOf(352, 4606, Utils.readLinesFromFile("year2018/day25input.txt"))
            )
        }
    }

    @Test
    fun part1() {
        Assert.assertEquals("The number of constellations is $part1Result", part1Result, Day25.part1(immuneSystemBattle))
    }

    @Test
    fun part2() {
        Assert.assertEquals("The immune system ends up with $part2Result units using the minimum boost", part2Result, Day25.part2(immuneSystemBattle))
    }
}