package com.formichelli.adventofcode.year2017.day11

import com.formichelli.adventofcode.utils.Utils

/*
How many steps away is the furthest he ever got from his starting position?
*/
fun main(args: Array<String>) {
    val input = Utils.getSingleLineInput().split(",").map { Direction.fromString(it.trim()) }

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