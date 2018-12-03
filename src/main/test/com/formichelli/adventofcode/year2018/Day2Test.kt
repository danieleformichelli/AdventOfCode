package com.formichelli.adventofcode.year2018

import com.formichelli.adventofcode.utils.Utils
import org.junit.Assert
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.Parameterized

@RunWith(Parameterized::class)
class Day2Test(private val part1Result: Int, private val part2Result: String, private val part1BoxIds: List<String>, private val part2BoxIds: List<String>) {
    companion object {
        @JvmStatic
        @Parameterized.Parameters
        fun data(): Collection<Array<Any>> {
            return listOf(
                    arrayOf(12, "fgij", listOf("abcdef", "bababc", "abbcde", "abcccd", "aabcdd", "abcdee", "ababab"), listOf("abcde", "fghij", "klmno", "pqrst", "fguij", "axcye", "wvxyz")),
                    arrayOf(6916, "oeylbtcxjqnzhgyylfapviusr", Utils.readLinesFromFile("day2input.txt"), Utils.readLinesFromFile("day2input.txt"))
            )
        }
    }

    @Test
    fun part1() {
        Assert.assertEquals("Resulting product of part 1 should be $part1Result", part1Result, Day2.part1(part1BoxIds))
    }

    @Test
    fun part2() {
        Assert.assertEquals("Common letters in correct box IDs should be $part2Result", part2Result, Day2.part2(part2BoxIds))
    }
}