package day8

import utils.getSpaceSeparatedMultiLineInput

/*
To be safe, the CPU also needs to know the highest value held in any register during this process so that it can decide how much memory to allocate to these operations
*/
fun main(args: Array<String>) {
    val input = getSpaceSeparatedMultiLineInput()

    val registers = mutableMapOf<String, Int>()
    var allTimeMax = 0
    input.forEach {
        val condition = Condition.fromString(it[5])
        val conditionRegister = it[4]
        val conditionArg2 = it[6].toInt()
        if (condition.check(registers[conditionRegister] ?: 0, conditionArg2)) {
            val registerName = it[0]
            val operation = Operation.fromString(it[1])
            val operationArg = it[2].toInt()
            val oldRegisterValue = registers[registerName] ?: 0
            val newRegisterValue = operation.apply(oldRegisterValue, operationArg)
            registers.put(registerName, newRegisterValue)

            if (newRegisterValue > allTimeMax) {
                allTimeMax = newRegisterValue
            }
        }
    }

    print(allTimeMax)
}