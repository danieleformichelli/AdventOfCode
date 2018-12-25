package com.formichelli.adventofcode.year2018

import com.formichelli.adventofcode.utils.Utils
import org.junit.Assert
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.Parameterized

@RunWith(Parameterized::class)
class Day20Test(private val part1Result: Int, private val part2Result: Int, private val instructionsRegex: String) {
    companion object {
        @JvmStatic
        @Parameterized.Parameters
        fun data(): Collection<Array<Any>> {
            return listOf(
                    arrayOf(3, 0, "^WNE\$"),
                    arrayOf(10, 0, "^ENWWW(NEEE|SSE(EE|N))\$"),
                    arrayOf(18, 0, "^ENNWSWW(NEWS|)SSSEEN(WNSE|)EE(SWEN|)NNN\$"),
                    arrayOf(23, 0, "^ESSWWN(E|NNENN(EESS(WNSE|)SSS|WWWSSSSE(SW|NNNE)))\$"),
                    arrayOf(31, 0, "^WSSEESWWWNW(S|NENNEEEENN(ESSSSW(NWSW|SSEN)|WSWWN(E|WWS(E|SS))))\$"),
                    arrayOf(4344, 8809, Utils.readSingleLineFromFile("year2018/day20input.txt"))
            )
        }
    }

    @Test
    fun part1() {
        Assert.assertEquals("Longest path to a room requires $part1Result steps", part1Result, Day20.part1(instructionsRegex))
    }

    @Test
    fun part2() {
        Assert.assertEquals("Longest path to a room requires $part2Result steps", part2Result, Day20.part2(instructionsRegex))
    }
}