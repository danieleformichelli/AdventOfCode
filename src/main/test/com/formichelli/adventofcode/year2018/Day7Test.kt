package com.formichelli.adventofcode.year2018

import com.formichelli.adventofcode.utils.Utils
import org.junit.Assert
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.Parameterized

@RunWith(Parameterized::class)
class Day7Test(private val part1Result: String, private val part2Result: Int, private val part1Instructions: List<String>, private val part2Instructions: List<String>, private val part2WorkersCount: Int, private val part2BaseStepTime: Int) {
    companion object {
        @JvmStatic
        @Parameterized.Parameters
        fun data(): Collection<Array<Any>> {
            return listOf(
                    arrayOf("CABDFE", 15, listOf("Step C must be finished before step A can begin.", "Step C must be finished before step F can begin.", "Step A must be finished before step B can begin.", "Step A must be finished before step D can begin.", "Step B must be finished before step E can begin.", "Step D must be finished before step E can begin.", "Step F must be finished before step E can begin."), listOf("Step C must be finished before step A can begin.", "Step C must be finished before step F can begin.", "Step A must be finished before step B can begin.", "Step A must be finished before step D can begin.", "Step B must be finished before step E can begin.", "Step D must be finished before step E can begin.", "Step F must be finished before step E can begin."), 2, 0),
                    arrayOf("CQSWKZFJONPBEUMXADLYIGVRHT", 914, Utils.readLinesFromFile("year2018/day7input.txt"), Utils.readLinesFromFile("year2018/day7input.txt"), 5, 60)
            )
        }
    }

    @Test
    fun part1() {
        Assert.assertEquals("The correct order of the steps is $part1Result", part1Result, Day7.part1(part1Instructions))
    }

    @Test
    fun part2() {
        Assert.assertEquals("The total time to execute all the steps is $part2Result", part2Result, Day7.part2(part2Instructions, part2WorkersCount, part2BaseStepTime))
    }
}