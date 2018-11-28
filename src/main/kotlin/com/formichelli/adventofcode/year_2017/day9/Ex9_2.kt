package com.formichelli.adventofcode.year_2017.day9

import com.formichelli.adventofcode.utils.getSingleLineInput

/*
Now, you're ready to remove the garbage.
To prove you've removed it, you need to count all of the characters within the garbage. The leading and trailing < and > don't count, nor do any canceled characters or the ! doing the canceling.
<>, 0 characters.
<random characters>, 17 characters.
<<<<>, 3 characters.
<{!>}>, 2 characters.
<!!>, 0 characters.
<!!!>>, 0 characters.
<{o"i!a,<{i<a>, 10 characters.
How many non-canceled characters are within the garbage in your puzzle input?
*/
fun main(args: Array<String>) {
    val input = getSingleLineInput()

    var result = 0
    var ignoreNext = false
    var isGarbage = false
    input.toCharArray().forEach {
        if (ignoreNext) {
            ignoreNext = false
            return@forEach
        }

        when (it) {
            '!' -> ignoreNext = true
            '<' -> if (!isGarbage) isGarbage = true else ++result
            '>' -> isGarbage = false
            else -> if (isGarbage) ++result
        }
    }

    println(result)
}