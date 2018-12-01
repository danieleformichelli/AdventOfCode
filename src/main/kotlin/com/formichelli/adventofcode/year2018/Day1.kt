package com.formichelli.adventofcode.year2018

object Day1 {
    public fun step1(input: List<String>) = input.stream().mapToInt { it.toInt() }.sum()
}