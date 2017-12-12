package utils

fun getSingleLineInput(): String {
    print("Insert your input: ")
    return readLine() ?: throw IllegalArgumentException()
}

fun getSpaceSeparatedMultiLineInput(): MutableList<List<Int>> {
    println("Insert your input (empty line to end):")

    val input = mutableListOf<List<Int>>()
    while (true) {
        val inputLine = readLine() ?: throw IllegalArgumentException()
        if (inputLine.isEmpty())
            break

        input.add(inputLine.split(" ", "\t").map { it.toInt() })
    }
    return input
}