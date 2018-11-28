package com.formichelli.adventofcode.year_2017.day8

import com.formichelli.adventofcode.utils.getSpaceSeparatedMultiLineInput

/*
Each instruction consists of several parts: the register to modify, whether to increase or decrease that register's value, the amount by which to increase or decrease it, and a condition. If the condition fails, skip the instruction without modifying the register. The registers all start at 0. The instructions look like this:
b inc 5 if a > 1
a inc 1 if b < 5
c dec -10 if a >= 1
c inc -20 if c == 10
These instructions would be processed as follows:
Because a starts at 0, it is not greater than 1, and so b is not modified.
a is increased by 1 (to 1) because b is less than 5 (it is 0).
c is decreased by -10 (to 10) because a is now greater than or equal to 1 (it is 1).
c is increased by -20 (to -10) because c is equal to 10.
After this process, the largest value in any register is 1.
You might also encounter <= (less than or equal to) or != (not equal to). However, the CPU doesn't have the bandwidth to tell you what all the registers are named, and leaves that to you to determine.
What is the largest value in any register after completing the instructions in your puzzle input?
*/
enum class Operation {
    INC, DEC;

    companion object {
        fun fromString(str: String) = when (str) {
            "inc" -> Operation.INC
            "dec" -> Operation.DEC
            else -> throw IllegalArgumentException()
        }
    }

    fun apply(a: Int, b: Int) = when(this) {
        Operation.INC -> a + b
        Operation.DEC -> a - b
    }
}

enum class Condition {
    GT, GE, E, NE, LE, LT;

    companion object {
        fun fromString(str: String) = when (str) {
            ">" -> GT
            ">=" -> GE
            "==" -> E
            "!=" -> NE
            "<=" -> LE
            "<" -> LT
            else -> throw IllegalArgumentException()
        }
    }

    fun check(a: Int, b: Int) = when(this) {
        GT -> a > b
        GE -> a >= b
        E -> a == b
        NE -> a != b
        LE -> a <= b
        LT -> a < b
    }
}

fun main(args: Array<String>) {
    val input = getSpaceSeparatedMultiLineInput()

    val registers = mutableMapOf<String, Int>()
    input.forEach {
        val condition = Condition.fromString(it[5])
        val conditionRegister = it[4]
        val conditionArg2 = it[6].toInt()
        if (condition.check(registers[conditionRegister] ?: 0, conditionArg2)) {
            val registerName = it[0]
            val operation = Operation.fromString(it[1])
            val operationArg = it[2].toInt()
            val registerValue = registers[registerName] ?: 0
            registers.put(registerName, operation.apply(registerValue, operationArg))
        }
    }

    print(registers.values.max())
}