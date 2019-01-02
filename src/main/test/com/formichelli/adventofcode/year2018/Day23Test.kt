package com.formichelli.adventofcode.year2018

import com.formichelli.adventofcode.utils.Utils
import org.junit.Assert
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.Parameterized

@RunWith(Parameterized::class)
class Day23Test(private val part1Result: Int, private val part2Result: Int, private val part1nanobots: List<String>, private val part2nanobots: List<String>) {
    companion object {
        @JvmStatic
        @Parameterized.Parameters
        fun data(): Collection<Array<Any>> {
            return listOf(
                    arrayOf(7, 36, listOf("pos=<0,0,0>, r=4", "pos=<1,0,0>, r=1", "pos=<4,0,0>, r=3", "pos=<0,2,0>, r=1", "pos=<0,5,0>, r=3", "pos=<0,0,3>, r=1", "pos=<1,1,1>, r=1", "pos=<1,1,2>, r=1", "pos=<1,3,1>, r=1"), listOf("pos=<10,12,12>, r=2", "pos=<12,14,12>, r=2", "pos=<16,12,12>, r=4", "pos=<14,14,14>, r=6", "pos=<50,50,50>, r=200", "pos=<10,10,10>, r=5")),
                    arrayOf(588, 111227643, Utils.readLinesFromFile("year2018/day23input.txt"), Utils.readLinesFromFile("year2018/day23input.txt"))
            )
        }
    }

    @Test
    fun part1() {
        Assert.assertEquals("$part1Result nanobots are in range of the nanobot with the largest radius", part1Result, Day23.part1(part1nanobots))
    }

    @Test
    fun part2() {
        Assert.assertEquals("The minimum distance to the coordinate in range of most nanobots is $part2Result", part2Result, Day23.part2(part2nanobots))
    }
}