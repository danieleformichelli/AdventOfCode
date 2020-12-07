package com.formichelli.adventofcode.year2018

import com.formichelli.adventofcode.utils.Coordinate
import com.formichelli.adventofcode.utils.Utils
import org.junit.Assert
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.Parameterized

@RunWith(Parameterized::class)
class Day13Test(private val part1Result: Coordinate, private val part2Result: Coordinate, private val part1TrackAndCarts: List<String>, private val part2TrackAndCarts: List<String>) {
    companion object {
        @JvmStatic
        @Parameterized.Parameters
        fun data(): Collection<Array<Any>> {
            return listOf(
                    arrayOf(Coordinate(7, 3), Coordinate(6, 4), listOf("/->-\\", "|   |  /----\\", "| /-+--+-\\  |", "| | |  | v  |", "\\-+-/  \\-+--/", "\\------/"), listOf("/>-<\\", "|   |", "| /<+-\\", "| | | v", "\\>+</ |", "  |   ^", "  \\<->/")),
                    arrayOf(Coordinate(38, 72), Coordinate(68, 27), Utils.readLinesFromFile("year2018/day13input.txt"), Utils.readLinesFromFile("year2018/day13input.txt"))
            )
        }
    }

    @Test
    fun part1() {
        Assert.assertEquals("The location of the first crash is $part1Result", part1Result, Day13.part1(part1TrackAndCarts))
    }

    @Test
    fun part2() {
        Assert.assertEquals("The location of the last cart is $part2Result", part2Result, Day13.part2(part2TrackAndCarts))
    }
}