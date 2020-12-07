package com.formichelli.adventofcode.year2018

import com.formichelli.adventofcode.utils.Utils
import org.junit.Assert
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.Parameterized

@RunWith(Parameterized::class)
class Day24Test(private val part1Result: Int, private val part2Result: Int, private val immuneSystemBattle: List<String>) {
    companion object {
        @JvmStatic
        @Parameterized.Parameters
        fun data(): Collection<Array<Any>> {
            return listOf(
                    arrayOf(5216, 51, listOf("Immune System:", "17 units each with 5390 hit points (weak to radiation, bludgeoning) with an attack that does 4507 fire damage at initiative 2", "989 units each with 1274 hit points (immune to fire; weak to bludgeoning, slashing) with an attack that does 25 slashing damage at initiative 3", "", "Infection:", "801 units each with 4706 hit points (weak to radiation) with an attack that does 116 bludgeoning damage at initiative 1", "4485 units each with 2961 hit points (immune to radiation; weak to fire, cold) with an attack that does 12 slashing damage at initiative 4")),
                    arrayOf(19974, 4606, Utils.readLinesFromFile("year2018/day24input.txt"))
            )
        }
    }

    @Test
    fun part1() {
        Assert.assertEquals("The winning army ends up with $part1Result units", part1Result, Day24.part1(immuneSystemBattle))
    }

    @Test
    fun part2() {
        Assert.assertEquals("The immune system ends up with $part2Result units using the minimum boost", part2Result, Day24.part2(immuneSystemBattle))
    }
}