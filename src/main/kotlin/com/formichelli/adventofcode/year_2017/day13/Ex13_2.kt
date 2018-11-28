package com.formichelli.adventofcode.year_2017.day13

import com.formichelli.adventofcode.utils.getMultiLineInput

/*
Now, you need to pass through the firewall without being caught - easier said than done.
You can't control the speed of the packet, but you can delay it any number of picoseconds. For each picosecond you delay the packet before beginning your trip, all security scanners move one step. You're not in the firewall during this time; you don't enter layer 0 until you stop delaying the packet.
In the example above, if you delay 10 picoseconds (picoseconds 0 - 9), you won't get caught:
*/
fun main(args: Array<String>) {
    val input = getMultiLineInput()

    val scannerRanges = mutableListOf<Int>()
    val scannerTripLengths = mutableListOf<Int>()
    input.forEach {
        val split = it.split(":")
        val depth = split[0].trim().toInt()
        val range = split[1].trim().toInt()
        while (scannerRanges.size < depth) {
            scannerRanges.add(0)
            scannerTripLengths.add(0)
        }

        scannerRanges.add(range)
        scannerTripLengths.add((range - 1) * 2)
    }

    var delay = -1
    outer@ while (true) {
        ++delay

        for (i in 0 until scannerRanges.size) {
            if (scannerRanges[i] != 0 && (i + delay) % scannerTripLengths[i] == 0)
                continue@outer
        }

        println(delay)
        break
    }
}