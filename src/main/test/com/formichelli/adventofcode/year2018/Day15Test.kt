package com.formichelli.adventofcode.year2018

import com.formichelli.adventofcode.utils.Utils
import org.junit.Assert
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.Parameterized

@RunWith(Parameterized::class)
class Day15Test(private val part1Result: Int, private val part2Result: Int, private val map: List<String>) {
    companion object {
        @JvmStatic
        @Parameterized.Parameters
        fun data(): Collection<Array<Any>> {
            return listOf(
                    arrayOf(39514, 31284, listOf("#######", "#E..EG#", "#.#G.E#", "#E.##E#", "#G..#.#", "#..E#.#", "#######")),
                    arrayOf(207059, 49120, Utils.readLinesFromFile("year2018/day15input.txt"))
            )
        }
    }

    @Test
    fun part1() {
        Assert.assertEquals("The outcome is $part1Result", part1Result, Day15.part1(map))
    }

    @Test
    fun part2() {
        Assert.assertEquals("The outcome is $part2Result", part2Result, Day15.part2(map))
    }
}