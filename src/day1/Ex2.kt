package day1

/*
Now, instead of considering the next digit, it wants you to consider the digit halfway around the circular list. That is, if your list contains 10 items, only include a digit in your sum if the digit 10/2 = 5 steps forward matches it. Fortunately, your list has an even number of elements.
For example:
1212 produces 6: the list contains 4 items, and all four digits match the digit 2 items ahead.
1221 produces 0, because every comparison is between a 1 and a 2.
123425 produces 4, because both 2s match each other, but no other digit has a match.
123123 produces 12.
12131415 produces 4.
*/
fun main(args: Array<String>) {
    print("Insert your input: ")
    val input = readLine() ?: throw IllegalArgumentException()
    var previousIndex = input.length / 2
    var captcha = 0
    input.forEach {
        if (it == input[previousIndex])
            captcha += it - '0'

        previousIndex = (previousIndex + 1) % input.length
    }

    println(captcha)
}