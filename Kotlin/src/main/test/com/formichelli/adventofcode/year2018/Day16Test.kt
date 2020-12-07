package com.formichelli.adventofcode.year2018

import com.formichelli.adventofcode.utils.Utils
import org.junit.Assert
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.Parameterized

@RunWith(Parameterized::class)
class Day16Test(private val part1Result: Int, private val part2Result: Int, private val part1TrackAndCarts: List<String>) {
    companion object {
        @JvmStatic
        @Parameterized.Parameters
        fun data(): Collection<Array<Any>> {
            return listOf(
                    arrayOf(596, 554, Utils.readLinesFromFile("year2018/day16input.txt"))
            )
        }
    }

    @Test
    fun part1() {
        Assert.assertEquals("The location of the first crash is $part1Result", part1Result, Day16.part1(part1TrackAndCarts))
    }

    @Test
    fun part2() {
        Assert.assertEquals("The location of the last cart is $part2Result", part2Result, Day16.part2(part1TrackAndCarts))
    }
}