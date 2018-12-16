package com.formichelli.adventofcode.year2018

object Day16 {
    /*
    --- Day 16: Chronal Classification ---
    As you see the Elves defend their hot chocolate successfully, you go back to falling through time. This is going to become a problem.

    If you're ever going to return to your own time, you need to understand how this device on your wrist works. You have a little while before you reach your next destination, and with a bit of trial and error, you manage to pull up a programming manual on the device's tiny screen.

    According to the manual, the device has four registers (numbered 0 through 3) that can be manipulated by instructions containing one of 16 opcodes. The registers start with the value 0.

    Every instruction consists of four values: an opcode, two inputs (named A and B), and an output (named C), in that order. The opcode specifies the behavior of the instruction and how the inputs are interpreted. The output, C, is always treated as a register.

    In the opcode descriptions below, if something says "value A", it means to take the number given as A literally. (This is also called an "immediate" value.) If something says "register A", it means to use the number given as A to read from (or write to) the register with that number. So, if the opcode addi adds register A and value B, storing the result in register C, and the instruction addi 0 7 3 is encountered, it would add 7 to the value contained by register 0 and store the sum in register 3, never modifying registers 0, 1, or 2 in the process.

    Many opcodes are similar except for how they interpret their arguments. The opcodes fall into seven general categories:

    Addition:

    addr (add register) stores into register C the result of adding register A and register B.
    addi (add immediate) stores into register C the result of adding register A and value B.
    Multiplication:

    mulr (multiply register) stores into register C the result of multiplying register A and register B.
    muli (multiply immediate) stores into register C the result of multiplying register A and value B.
    Bitwise AND:

    banr (bitwise AND register) stores into register C the result of the bitwise AND of register A and register B.
    bani (bitwise AND immediate) stores into register C the result of the bitwise AND of register A and value B.
    Bitwise OR:

    borr (bitwise OR register) stores into register C the result of the bitwise OR of register A and register B.
    bori (bitwise OR immediate) stores into register C the result of the bitwise OR of register A and value B.
    Assignment:

    setr (set register) copies the contents of register A into register C. (Input B is ignored.)
    seti (set immediate) stores value A into register C. (Input B is ignored.)
    Greater-than testing:

    gtir (greater-than immediate/register) sets register C to 1 if value A is greater than register B. Otherwise, register C is set to 0.
    gtri (greater-than register/immediate) sets register C to 1 if register A is greater than value B. Otherwise, register C is set to 0.
    gtrr (greater-than register/register) sets register C to 1 if register A is greater than register B. Otherwise, register C is set to 0.
    Equality testing:

    eqir (equal immediate/register) sets register C to 1 if value A is equal to register B. Otherwise, register C is set to 0.
    eqri (equal register/immediate) sets register C to 1 if register A is equal to value B. Otherwise, register C is set to 0.
    eqrr (equal register/register) sets register C to 1 if register A is equal to register B. Otherwise, register C is set to 0.
    Unfortunately, while the manual gives the name of each opcode, it doesn't seem to indicate the number. However, you can monitor the CPU to see the contents of the registers before and after instructions are executed to try to work them out. Each opcode has a number from 0 through 15, but the manual doesn't say which is which. For example, suppose you capture the following sample:

    Before: [3, 2, 1, 1]
    9 2 1 2
    After:  [3, 2, 2, 1]
    This sample shows the effect of the instruction 9 2 1 2 on the registers. Before the instruction is executed, register 0 has value 3, register 1 has value 2, and registers 2 and 3 have value 1. After the instruction is executed, register 2's value becomes 2.

    The instruction itself, 9 2 1 2, means that opcode 9 was executed with A=2, B=1, and C=2. Opcode 9 could be any of the 16 opcodes listed above, but only three of them behave in a way that would cause the result shown in the sample:

    Opcode 9 could be mulr: register 2 (which has a value of 1) times register 1 (which has a value of 2) produces 2, which matches the value stored in the output register, register 2.
    Opcode 9 could be addi: register 2 (which has a value of 1) plus value 1 produces 2, which matches the value stored in the output register, register 2.
    Opcode 9 could be seti: value 2 matches the value stored in the output register, register 2; the number given for B is irrelevant.
    None of the other opcodes produce the result captured in the sample. Because of this, the sample above behaves like three opcodes.

    You collect many of these samples (the first section of your puzzle input). The manual also includes a small test program (the second section of your puzzle input) - you can ignore it for now.

    Ignoring the opcode numbers, how many samples in your puzzle input behave like three or more opcodes?
     */
    fun part1(opCodeSamples: List<String>): Int {
        val samples = parseInput(opCodeSamples).first

        var totalBehavesLikeCount = 0
        for (sample in samples) {
            var behavesLikeCount = 0
            for (opCode in OpCode.values()) {
                if (opCode.behavesLike(sample)) {
                    ++behavesLikeCount
                }
            }

            if (behavesLikeCount >= 3) {
                ++totalBehavesLikeCount
            }
        }

        return totalBehavesLikeCount
    }

    /*
    --- Part Two ---
    Using the samples you collected, work out the number of each opcode and execute the test program (the second section of your puzzle input).

    What value is contained in register 0 after executing the test program?
    */
    fun part2(opCodeSamples: List<String>): Int {
        val (samples, operations) = parseInput(opCodeSamples)

        val opCodesMap = computeOpCodes(samples)

        val registers = IntArray(4)
        for (operation in operations) {
            opCodesMap[operation.opCodeNum]?.execute(operation, registers)
        }

        return registers[0]
    }

    private fun computeOpCodes(samples: List<OpCodeSample>): Map<Int, OpCode> {
        val opCodesMap = HashMap<Int, OpCode>()
        val behavesLike = HashMap<Int, MutableSet<OpCode>>()
        for (sample in samples) {
            for (opCode in OpCode.values()) {
                if (opCode.behavesLike(sample)) {
                    behavesLike.computeIfAbsent(sample.opCodeAndInputs.opCodeNum) { HashSet() }.add(opCode)
                }
            }
        }

        while (!behavesLike.isEmpty()) {
            val figuredOutOpCodes = HashMap<Int, OpCode>()
            behavesLike.forEach {
                if (it.value.size == 1) {
                    figuredOutOpCodes[it.key] = it.value.first()
                }
            }

            figuredOutOpCodes.forEach {
                behavesLike.forEach { behavesLikeSet ->
                    behavesLikeSet.value.remove(it.value)
                }
                behavesLike.remove(it.key)
                opCodesMap[it.key] = it.value

            }
        }

        return opCodesMap
    }

    private fun parseInput(opCodeSamples: List<String>): Pair<List<OpCodeSample>, List<OpCodeAndInputs>> {
        val opCodesSamples = ArrayList<OpCodeSample>()
        var lineIndex = 0
        while (opCodeSamples[lineIndex].startsWith("Before")) {
            if (!opCodeSamples[lineIndex].startsWith("Before")) {
                break
            }

            val registersBefore = parseRegisters(opCodeSamples[lineIndex])
            val registersAfter = parseRegisters(opCodeSamples[lineIndex + 2])
            val opCodeAndInputs = parseOpCodeAndInputs(opCodeSamples[lineIndex + 1])
            opCodesSamples.add(OpCodeSample(registersBefore, opCodeAndInputs, registersAfter))
            lineIndex += 4
        }

        lineIndex += 3

        val opCodesAndInputs = ArrayList<OpCodeAndInputs>()
        while (lineIndex < opCodeSamples.size) {
            val line = opCodeSamples[lineIndex]
            if (line.isEmpty()) {
                break
            }

            opCodesAndInputs.add(parseOpCodeAndInputs(line))
            ++lineIndex
        }

        return Pair(opCodesSamples, opCodesAndInputs)
    }

    private fun parseRegisters(line: String) = line.split("Before: [", "After:  [", ", ", "]").filter { !it.isEmpty() }.map { it.toInt() }.toIntArray()

    private fun parseOpCodeAndInputs(line: String) = OpCodeAndInputs(line.split(" ").map { it.toInt() }.toIntArray())

    data class OpCodeSample(val registersBefore: IntArray, val opCodeAndInputs: OpCodeAndInputs, val registersAfter: IntArray)

    data class OpCodeAndInputs(val opCodeNum: Int, val a: Int, val b: Int, val c: Int) {
        constructor(opCodeAndInputs: IntArray) : this(opCodeAndInputs[0], opCodeAndInputs[1], opCodeAndInputs[2], opCodeAndInputs[3])
    }

    enum class OpCode {
        ADDR, ADDI, MULR, MULI, BANR, BANI, BORR, BORI, SETR, SETI, GTIR, GTRI, GTRR, EQIR, EQRI, EQRR;

        fun behavesLike(sample: OpCodeSample) = behavesLike(sample.registersBefore, sample.opCodeAndInputs.a, sample.opCodeAndInputs.b, sample.opCodeAndInputs.c, sample.registersAfter)

        fun behavesLike(registersBefore: IntArray, a: Int, b: Int, c: Int, registersAfter: IntArray) = when (this) {
            ADDR -> {
                registersAfter[c] == registersBefore[a] + registersBefore[b]
            }
            ADDI -> {
                registersAfter[c] == registersBefore[a] + b
            }
            MULR -> {
                registersAfter[c] == registersBefore[a] * registersBefore[b]
            }
            MULI -> {
                registersAfter[c] == registersBefore[a] * b
            }
            BANR -> {
                registersAfter[c] == registersBefore[a].and(registersBefore[b])
            }
            BANI -> {
                registersAfter[c] == registersBefore[a].and(b)
            }
            BORR -> {
                registersAfter[c] == registersBefore[a].or(registersBefore[b])
            }
            BORI -> {
                registersAfter[c] == registersBefore[a].or(b)
            }
            SETR -> {
                registersAfter[c] == registersBefore[a]
            }
            SETI -> {
                registersAfter[c] == a
            }
            GTIR -> {
                registersAfter[c] == if (a > registersBefore[b]) 1 else 0
            }
            GTRI -> {
                registersAfter[c] == if (registersBefore[a] > b) 1 else 0
            }
            GTRR -> {
                registersAfter[c] == if (registersBefore[a] > registersBefore[b]) 1 else 0
            }
            EQIR -> {
                registersAfter[c] == if (a == registersBefore[b]) 1 else 0
            }
            EQRI -> {
                registersAfter[c] == if (registersBefore[a] == b) 1 else 0
            }
            EQRR -> {
                registersAfter[c] == if (registersBefore[a] == registersBefore[b]) 1 else 0
            }
        }

        fun execute(opCodeAndInputs: OpCodeAndInputs, registers: IntArray) = execute(opCodeAndInputs.a, opCodeAndInputs.b, opCodeAndInputs.c, registers)

        fun execute(a: Int, b: Int, c: Int, registers: IntArray) = when (this) {
            ADDR -> {
                registers[c] = registers[a] + registers[b]
            }
            ADDI -> {
                registers[c] = registers[a] + b
            }
            MULR -> {
                registers[c] = registers[a] * registers[b]
            }
            MULI -> {
                registers[c] = registers[a] * b
            }
            BANR -> {
                registers[c] = registers[a].and(registers[b])
            }
            BANI -> {
                registers[c] = registers[a].and(b)
            }
            BORR -> {
                registers[c] = registers[a].or(registers[b])
            }
            BORI -> {
                registers[c] = registers[a].or(b)
            }
            SETR -> {
                registers[c] = registers[a]
            }
            SETI -> {
                registers[c] = a
            }
            GTIR -> {
                registers[c] = if (a > registers[b]) 1 else 0
            }
            GTRI -> {
                registers[c] = if (registers[a] > b) 1 else 0
            }
            GTRR -> {
                registers[c] = if (registers[a] > registers[b]) 1 else 0
            }
            EQIR -> {
                registers[c] = if (a == registers[b]) 1 else 0
            }
            EQRI -> {
                registers[c] = if (registers[a] == b) 1 else 0
            }
            EQRR -> {
                registers[c] = if (registers[a] == registers[b]) 1 else 0
            }
        }
    }
}