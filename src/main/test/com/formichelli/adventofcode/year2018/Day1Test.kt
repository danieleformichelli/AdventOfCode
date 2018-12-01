package com.formichelli.adventofcode.year2018

import com.formichelli.adventofcode.utils.readLinesFromFile
import org.junit.Assert
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.Parameterized

@RunWith(Parameterized::class)
class Day1Test(private val result: Int, private val inputFile: String) {
    companion object {
        @JvmStatic
        @Parameterized.Parameters
        fun data(): Collection<Array<Any>> {
            return listOf(
                    arrayOf(486, "day1input.txt"))
        }
    }

    @Test
    fun step1() {
        Assert.assertEquals("Resulting frequency should be $result", result, Day1.step1(readLinesFromFile(inputFile)))
    }
}