package com.formichelli.adventofcode.year2018

import com.formichelli.adventofcode.utils.Utils
import org.junit.Assert
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.Parameterized

@RunWith(Parameterized::class)
class Day18Test(private val part1Result: Int, private val part2Result: Int, private val lumberMapStr: List<String>) {
    companion object {
        @JvmStatic
        @Parameterized.Parameters
        fun data(): Collection<Array<Any>> {

            return listOf(
                    //arrayOf(1147, 554, listOf(".#.#...|#.", ".....#|##|", ".|..|...#.", "..|#.....#", "#.#|||#|#|", "...#.||...", ".|....|...", "||...#|.#|", "|.||||..|.", "...#.|..|.")),
                    arrayOf(486878, 554, Utils.readLinesFromFile("year2018/day18input.txt"))
            )
        }
    }

    @Test
    fun part1() {
        Assert.assertEquals("After 10 minutes, number of trees multiplied by number of lumberyards is $part1Result", part1Result, Day18.part1(lumberMapStr))
    }

    @Test
    fun part2() {
        Assert.assertEquals("$part2Result tiles are reached by the water $part2Result", part2Result, Day18.part2(lumberMapStr))
    }
}