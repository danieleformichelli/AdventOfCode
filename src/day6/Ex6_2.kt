package day6

import utils.increaseAt
import utils.getSpaceSeparatedSingleLineInput

/*
Out of curiosity, the debugger would also like to know the size of the loop: starting from a state that has already been seen, how many block redistribution cycles must be performed before that same state is seen again?
In the example above, 2 4 1 2 is seen again after four cycles, and so the answer in that example would be 4.
How many cycles are in the infinite loop that arises from the configuration in your puzzle input?
*/
fun main(args: Array<String>) {
    val input = getSpaceSeparatedSingleLineInput().map { it.toInt() }.toMutableList()

    var steps = 0
    val previousConfigurations = mutableMapOf<String, Int>()
    var previousIndex : Int?
    do {
        steps++

        // find the maximum value and index
        var maxValue = -Integer.MAX_VALUE
        var maxIndex = -1
        input.forEachIndexed { index, value ->
            if (value > maxValue) {
                maxValue = value
                maxIndex = index
            }
        }

        // redistribute the blocks
        input.increaseAt(maxIndex, -maxValue)
        while (maxValue > 0) {
            --maxValue
            maxIndex = (maxIndex + 1) % input.size
            input.increaseAt(maxIndex, 1)
        }

        previousIndex = previousConfigurations.put(combinationToString(input), steps)
    }
    while (previousIndex == null)

    println(steps - previousIndex)
}

private fun combinationToString(input: MutableList<Int>) = input.joinToString()