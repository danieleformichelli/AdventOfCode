package com.formichelli.adventofcode.year2017.day2

import com.formichelli.adventofcode.utils.Utils

/*
The spreadsheet consists of rows of apparently-random numbers. To make sure the recovery process is on the right track, they need you to calculate the spreadsheet's checksum. For each row, determine the difference between the largest value and the smallest value; the checksum is the sum of all of these differences.
For example, given the following spreadsheet:
5 1 9 5
7 5 3
2 4 6 8
The first row's largest and smallest values are 9 and 1, and their difference is 8.
The second row's largest and smallest values are 7 and 3, and their difference is 4.
The third row's difference is 6.
In this example, the spreadsheet's checksum would be 8 + 4 + 6 = 18.
*/
fun main(args: Array<String>) {
    val input = Utils.getSpaceSeparatedMultiLineInput()

    var captcha = 0
    input.forEach { list ->
        if (list.isEmpty())
            throw IllegalArgumentException()

        list.subList(0, list.lastIndex).forEachIndexed lineFor@{ index, value ->
            val intValue = value.toInt()
            list.subList(index + 1, list.lastIndex + 1).forEach { innerValue ->
                val intInnerValue = innerValue.toInt()
                if (intInnerValue % intValue == 0) {
                    captcha += intInnerValue / intValue
                    return@lineFor
                } else if (intValue % intInnerValue == 0) {
                    captcha += intValue / intInnerValue
                    return@lineFor
                }
            }
        }
    }

    println(captcha)
}