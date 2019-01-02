package com.formichelli.adventofcode.year2018

import com.formichelli.adventofcode.utils.Utils
import org.junit.Assert
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.Parameterized

@RunWith(Parameterized::class)
class Day22Test(private val part1Result: Int, private val part2Result: Int, private val caveScan: List<String>) {
    companion object {
        @JvmStatic
        @Parameterized.Parameters
        fun data(): Collection<Array<Any>> {
            return listOf(
                    arrayOf(114, 45, listOf("depth: 510", "target: 10,10")),
                    arrayOf(5400, 190836, Utils.readLinesFromFile("year2018/day22input.txt"))
            )
        }
    }

    @Test
    fun part1() {
        Assert.assertEquals("The total risk level is $part1Result", part1Result, Day22.part1(caveScan))
    }

    @Test
    fun part2() {
        Assert.assertEquals("The minimum time required to reach the target is $part2Result", part2Result, Day22.part2(caveScan))
    }
}