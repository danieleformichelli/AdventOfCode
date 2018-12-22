package com.formichelli.adventofcode.year2018

import com.formichelli.adventofcode.utils.Utils
import org.junit.Assert
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.Parameterized

@RunWith(Parameterized::class)
class Day19Test(private val part1Result: Int, private val part2Result: Int, private val opCodes: List<String>) {
    companion object {
        @JvmStatic
        @Parameterized.Parameters
        fun data(): Collection<Array<Any>> {
            return listOf(
                    arrayOf(1080, 11106760, Utils.readLinesFromFile("year2018/day19input.txt"))
            )
        }
    }

    @Test
    fun part1() {
        Assert.assertEquals("Value of register 0 at the end of the execution is $part1Result", part1Result, Day19.part1(opCodes))
    }

    @Test
    fun part2() {
        Assert.assertEquals("Value of register 0 at the end of the execution is $part2Result", part2Result, Day19.part2(opCodes))
    }
}