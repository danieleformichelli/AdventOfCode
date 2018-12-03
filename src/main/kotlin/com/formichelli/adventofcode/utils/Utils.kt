package com.formichelli.adventofcode.utils

import java.nio.file.Files
import java.nio.file.Paths

class Utils {
    companion object {
        fun readSingleLineFromFile(filename: String): String {
            return readLinesFromFile(filename)[0]
        }

        fun readLinesFromFile(filename: String): List<String> {
            return Files.readAllLines(Paths.get(ClassLoader.getSystemResource(filename).file.substring(1)))
        }

        fun readIntsFromFile(filename: String): List<Int> {
            return Files.readAllLines(Paths.get(ClassLoader.getSystemResource(filename).file.substring(1))).map { it.toInt() }.toList()
        }

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
    }
}

public fun MutableList<Int>.increaseAt(index: Int, increase: Int) {
    this.add(index, this[index] + increase)
    this.removeAt(index + 1)
}