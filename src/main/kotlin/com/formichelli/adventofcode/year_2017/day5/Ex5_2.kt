package com.formichelli.adventofcode.year_2017.day5

import com.formichelli.adventofcode.utils.getMultiLineInput
import com.formichelli.adventofcode.utils.increaseAt

/*
Now, the jumps are even stranger: after each jump, if the offset was three or more, instead decrease it by 1. Otherwise, increase it by 1 as before.
Using this rule with the above example, the process now takes 10 steps, and the offset values after finding the exit are left as 2 3 2 3 -1.
How many steps does it now take to reach the exit?
*/
fun main(args: Array<String>) {
    val input = getMultiLineInput().map { it.toInt() }.toMutableList()

    var index = 0
    var steps = 0
    while (index >= 0 && index < input.size) {
        ++steps
        val jump = input[index]
        val increase = if (jump >= 3) -1 else 1
        input.increaseAt(index, increase)
        index += jump
    }

    println(steps)
}