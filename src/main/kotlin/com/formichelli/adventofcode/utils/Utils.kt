package com.formichelli.adventofcode.utils

fun getSingleLineInput(): String {
    print("Insert your input: ")
    return readLine() ?: throw IllegalArgumentException()
}

fun getSpaceSeparatedSingleLineInput(): List<String> = getSingleLineInput().split(" ", "\t")

fun getMultiLineInput(): List<String> {
    println("Insert your input (empty line to end):")

    val input = mutableListOf<String>()
    while (true) {
        val line = readLine() ?: throw IllegalArgumentException()
        if (line.isEmpty())
            break

        input.add(line)
    }
    return input
}

fun getSpaceSeparatedMultiLineInput(): List<List<String>> =
    getMultiLineInput().map { it.split(" ", "\t") }

fun MutableList<Int>.increaseAt(index: Int, increase: Int) {
    this.add(index, this[index] + increase)
    this.removeAt(index + 1)
}