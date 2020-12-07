package com.formichelli.adventofcode.year2018

import org.junit.Assert
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.Parameterized

@RunWith(Parameterized::class)
class Day11Test(private val part1Result: Pair<Int, Int>, private val part2Result: Pair<Pair<Int, Int>, Int>, private val serialNumber: Int) {
    companion object {
        @JvmStatic
        @Parameterized.Parameters
        fun data(): Collection<Array<Any>> {
            return listOf<Array<Any>>(
                    arrayOf(Pair(33, 45), Pair(Pair(90, 269), 16), 18),
                    arrayOf(Pair(21, 53), Pair(Pair(233, 250), 12), 6548)
            )
        }
    }

    @Test
    fun part1() {
        Assert.assertEquals("The 3x3 square with the larger power is at $part1Result", part1Result, Day11.part1(serialNumber))
    }

    @Test
    fun part2() {
        Assert.assertEquals("The square with the larger power is at $part2Result", part2Result, Day11.part2(serialNumber))
    }
}