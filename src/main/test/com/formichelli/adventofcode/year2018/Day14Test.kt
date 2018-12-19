package com.formichelli.adventofcode.year2018

import org.junit.Assert
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.Parameterized

@RunWith(Parameterized::class)
class Day14Test(private val part1Result: Long, private val part2Result: Long, private val input: Int) {
    companion object {
        @JvmStatic
        @Parameterized.Parameters
        fun data(): Collection<Array<Any>> {
            return listOf<Array<Any>>(
                    arrayOf(1611732174L, 20279772L, 864801)
            )
        }
    }

    @Test
    fun part1() {
        Assert.assertEquals("The score after $input is $part1Result", part1Result, Day14.part1(input))
    }

    @Test
    fun part2() {
        Assert.assertEquals("$part2Result recipes appear to the left of $input", part2Result, Day14.part2(input))
    }
}