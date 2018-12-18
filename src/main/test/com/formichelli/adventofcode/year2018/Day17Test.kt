package com.formichelli.adventofcode.year2018

import com.formichelli.adventofcode.utils.Utils
import org.junit.Assert
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.Parameterized

@RunWith(Parameterized::class)
class Day17Test(private val part1Result: Int, private val part2Result: Int, private val clayCoordinates: List<String>) {
    companion object {
        @JvmStatic
        @Parameterized.Parameters
        fun data(): Collection<Array<Any>> {
            return listOf(
                    arrayOf(57, 29, listOf("x=495, y=2..7", "y=7, x=495..501", "x=501, y=3..7", "x=498, y=2..4", "x=506, y=1..2", "x=498, y=10..13", "x=504, y=10..13", "y=13, x=498..504")),
                    arrayOf(42389, 34754, Utils.readLinesFromFile("year2018/day17input.txt"))
            )
        }
    }

    @Test
    fun part1() {
        Assert.assertEquals("$part1Result tiles are reached by the water", part1Result, Day17.part1(clayCoordinates))
    }

    @Test
    fun part2() {
        Assert.assertEquals("$part2Result tiles are reached by still water", part2Result, Day17.part2(clayCoordinates))
    }
}