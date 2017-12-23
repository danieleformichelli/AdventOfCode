package day11

import utils.getSingleLineInput

/*
How many steps away is the furthest he ever got from his starting position?
*/
fun main(args: Array<String>) {
    val input = getSingleLineInput().split(",").map { Direction.fromString(it.trim()) }

    var y = 0
    var x = 0
    var maxDistance = 0
    input.forEach {
        x += it.x
        y += it.y
        val distance = computeDistance(x, y)
        if (distance > maxDistance) {
            maxDistance = distance
        }
    }

    println(maxDistance)
}