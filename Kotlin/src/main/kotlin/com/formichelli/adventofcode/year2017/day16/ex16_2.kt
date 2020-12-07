package com.formichelli.adventofcode.year2017.day16

import com.formichelli.adventofcode.utils.Utils

/*
Now that you're starting to get a feel for the dance moves, you turn your attention to the dance as a whole.
Keeping the positions they ended up in from their previous dance, the programs perform it again and again: including the first dance, a total of one billion (1000000000) times.
In the example above, their second dance would begin with the order baedc, and use the same dance moves:
s1, a spin of size 1: cbaed.
x3/4, swapping the last two programs: cbade.
pe/b, swapping programs e and b: ceadb.
In what order are the programs standing after their billion dances?
*/
fun main(args: Array<String>) {
    val input = Utils.getSingleLineInput().split(",")
    var programs = "abcdefghijklmnop"
    val previousMoves = mutableSetOf<String>()

    for (i in 0 until 1_000_000_000) {
        if (previousMoves.contains(programs)) {
            for (j in 0 until 1_000_000_000 % i) {
                input.forEach {
                    programs = programs.dance(it)
                }
            }
            break
        }
        previousMoves.add(programs)

        input.forEach {
            programs = programs.dance(it)
        }
    }

    println(programs)
}

private fun String.dance(move: String) = when (move[0]) {
    's' -> this.spin(move.substring(1).toInt())
    'x' -> this.exchange(move.substring(1).split("/").map { it.toInt() })
    'p' -> this.partner(move.substring(1).split("/").map { it[0] })
    else -> throw IllegalArgumentException("Invalid move: " + move)
}

private fun String.spin(spinSize: Int): String {
    val splitAt = this.length - spinSize
    return this.substring(splitAt) + this.substring(0 until splitAt)
}

private fun String.exchange(indexes: List<Int>): String {
    return this.replaceRange(indexes[0], indexes[0] + 1, this[indexes[1]].toString()).replaceRange(indexes[1], indexes[1] + 1, this[indexes[0]].toString())
}

private fun String.partner(partners: List<Char>) = this.exchange(listOf(this.indexOf(partners[0]), this.indexOf(partners[1])))
