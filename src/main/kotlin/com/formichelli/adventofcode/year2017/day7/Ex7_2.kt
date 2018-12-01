package com.formichelli.adventofcode.year2017.day7

import com.formichelli.adventofcode.utils.getMultiLineInput
import java.util.stream.Collectors

/*
For any program holding a disc, each program standing on that disc forms a sub-tower. Each of those sub-towers are supposed to be the same weight, or the disc itself isn't balanced. The weight of a tower is the sum of the weights of the programs in that tower.
In the example above, this means that for ugml's disc to be balanced, gyxo, ebii, and jptl must all have the same weight, and they do: 61.
However, for tknk to be balanced, each of the programs standing on its disc and all programs above it must each match. This means that the following sums must all be the same:
ugml + (gyxo + ebii + jptl) = 68 + (61 + 61 + 61) = 251
padx + (pbga + havc + qoyq) = 45 + (66 + 66 + 66) = 243
fwft + (ktlj + cntj + xhth) = 72 + (57 + 57 + 57) = 243
As you can see, tknk's disc is unbalanced: ugml's stack is heavier than the other two. Even though the nodes above ugml are balanced, ugml itself is too heavy: it needs to be 8 units lighter for its stack to weigh 243 and keep the towers balanced. If this change were made, its weight would be 60.
Given that exactly one program is the wrong weight, what would its weight need to be to balance the entire tower?
*/
fun main(args: Array<String>) {
    val input = getMultiLineInput()

    val programToChildren = mutableMapOf<String, Set<String>>()
    val programToWeight = mutableMapOf<String, Int>()
    val programToTowerWeight = mutableMapOf<String, Int>()

    // put all leaf and programs that are on top of other program in the set
    input.forEach {
        val split = it.split("->")
        val programName = it.split(" ")[0]
        val programWeight = it.split("(", ")")[1].toInt()
        if (split.size == 1) {
            programToChildren.put(programName, emptySet())
            programToWeight.put(programName, programWeight)
            programToTowerWeight.put(programName, programWeight)
        } else {
            programToChildren.put(programName, split[1].split(",").stream().map { it.trim() }.collect(Collectors.toSet()))
            programToWeight.put(programName, programWeight)
        }
    }

    val unbalancedTowers = mutableSetOf<String>()
    // compute the weight of each tower and find the unbalanced ones
    programToChildren.forEach { program, children ->
        if (!children.isEmpty()) {
            val firstTowerWeight = getOrComputeTowerWeight(children.first(), programToChildren, programToWeight, programToTowerWeight)
            if (children.any { getOrComputeTowerWeight(it, programToChildren, programToWeight, programToTowerWeight) != firstTowerWeight }) {
                unbalancedTowers.add(program)
            }
        }
    }

    // among the unbalanced towers, find the only one that doesn't have unbalanced children
    unbalancedTowers.forEach {
        val unbalancedChildren = programToChildren[it]!!
        if (unbalancedChildren.none { unbalancedTowers.contains(it) }) {
            if (unbalancedChildren.size < 3) {
                println("Invalid input")
            }

            val balancedWeight = computeBalancedWeight(unbalancedChildren.map { programToTowerWeight[it]!! })
            unbalancedChildren.forEach {
                val unbalancedTowerWeight = programToTowerWeight[it]!!
                if (unbalancedTowerWeight != balancedWeight) {
                    val unbalancedProgramWeight = programToWeight[it]!!
                    println(unbalancedProgramWeight - (unbalancedTowerWeight - balancedWeight))
                }
            }
        }
    }
}

fun getOrComputeTowerWeight(program: String, programToChildren: MutableMap<String, Set<String>>, programToWeight: MutableMap<String, Int>, programToTowerWeight: MutableMap<String, Int>): Int {
    val precomputedWeight = programToTowerWeight[program]
    if (precomputedWeight != null) {
        return precomputedWeight
    }

    val towerWeight = (programToWeight[program] ?: 0) + programToChildren[program]!!.sumBy { getOrComputeTowerWeight(it, programToChildren, programToWeight, programToTowerWeight) }
    programToTowerWeight[program] = towerWeight
    return towerWeight
}

fun computeBalancedWeight(unbalancedWeights: List<Int>): Int {
    var balanceWeight1: Int? = null
    var balanceWeight2: Int? = null

    unbalancedWeights.forEach {
        if (balanceWeight1 == null) {
            balanceWeight1 = it
        } else if (it == balanceWeight1) {
            return it
        } else if (balanceWeight2 == null) {
            balanceWeight2 = it
        } else {
            return it
        }
    }

    return 0
}