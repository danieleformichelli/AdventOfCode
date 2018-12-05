package com.formichelli.adventofcode.year2018

import com.formichelli.adventofcode.utils.Utils
import org.junit.Assert
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.Parameterized

@RunWith(Parameterized::class)
class Day4Test(private val part1Result: Int, private val part2Result: Int, private val part1Records: List<String>, private val part2Records: List<String>) {
    companion object {
        @JvmStatic
        @Parameterized.Parameters
        fun data(): Collection<Array<Any>> {
            return listOf(
                    arrayOf(240, 4455, listOf("[1518-11-04 00:46] wakes up", "[1518-11-01 00:05] falls asleep", "[1518-11-01 00:25] wakes up", "[1518-11-02 00:40] falls asleep", "[1518-11-02 00:50] wakes up", "[1518-11-03 00:05] Guard #10 begins shift", "[1518-11-03 00:24] falls asleep", "[1518-11-03 00:29] wakes up", "[1518-11-01 00:00] Guard #10 begins shift", "[1518-11-04 00:02] Guard #99 begins shift", "[1518-11-05 00:03] Guard #99 begins shift", "[1518-11-04 00:36] falls asleep", "[1518-11-05 00:55] wakes up", "[1518-11-05 00:45] falls asleep", "[1518-11-01 00:30] falls asleep", "[1518-11-01 00:55] wakes up", "[1518-11-01 23:58] Guard #99 begins shift"), listOf("[1518-11-04 00:46] wakes up", "[1518-11-01 00:05] falls asleep", "[1518-11-01 00:25] wakes up", "[1518-11-02 00:40] falls asleep", "[1518-11-02 00:50] wakes up", "[1518-11-03 00:05] Guard #10 begins shift", "[1518-11-03 00:24] falls asleep", "[1518-11-03 00:29] wakes up", "[1518-11-01 00:00] Guard #10 begins shift", "[1518-11-04 00:02] Guard #99 begins shift", "[1518-11-05 00:03] Guard #99 begins shift", "[1518-11-04 00:36] falls asleep", "[1518-11-05 00:55] wakes up", "[1518-11-05 00:45] falls asleep", "[1518-11-01 00:30] falls asleep", "[1518-11-01 00:55] wakes up", "[1518-11-01 23:58] Guard #99 begins shift")),
                    arrayOf(140932, 51232, Utils.readLinesFromFile("year2018/day4input.txt"), Utils.readLinesFromFile("year2018/day4input.txt"))
            )
        }
    }

    @Test
    fun part1() {
        Assert.assertEquals("The most sleeping guard multiplied by the most sleeping minute is $part1Result", part1Result, Day4.part1(part1Records))
    }

    @Test
    fun part2() {
        Assert.assertEquals("$part2Result is the only claim that does not overlap", part2Result, Day4.part2(part2Records))
    }
}