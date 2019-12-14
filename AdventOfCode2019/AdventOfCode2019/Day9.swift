//
//  Day9.swift
//  AdventOfCode2019
//
//  Created by Daniele Formichelli on 09/12/2019.
//  Copyright © 2019 Daniele Formichelli. All rights reserved.
//

/**
--- Day 9: Sensor Boost ---
You've just said goodbye to the rebooted rover and left Mars when you receive a faint distress signal coming from the asteroid belt. It must be the Ceres monitoring station!

In order to lock on to the signal, you'll need to boost your sensors. The Elves send up the latest BOOST program - Basic Operation Of System Test.

While BOOST (your puzzle input) is capable of boosting your sensors, for tenuous safety reasons, it refuses to do so until the computer it runs on passes some checks to demonstrate it is a complete Intcode computer.

Your existing Intcode computer is missing one key feature: it needs support for parameters in relative mode.

Parameters in mode 2, relative mode, behave very similarly to parameters in position mode: the parameter is interpreted as a position. Like position mode, parameters in relative mode can be read from or written to.

The important difference is that relative mode parameters don't count from address 0. Instead, they count from a value called the relative base. The relative base starts at 0.

The address a relative mode parameter refers to is itself plus the current relative base. When the relative base is 0, relative mode parameters and position mode parameters with the same value refer to the same address.

For example, given a relative base of 50, a relative mode parameter of -7 refers to memory address 50 + -7 = 43.

The relative base is modified with the relative base offset instruction:

Opcode 9 adjusts the relative base by the value of its only parameter. The relative base increases (or decreases, if the value is negative) by the value of the parameter.
For example, if the relative base is 2000, then after the instruction 109,19, the relative base would be 2019. If the next instruction were 204,-34, then the value at address 1985 would be output.

Your Intcode computer will also need a few other capabilities:

The computer's available memory should be much larger than the initial program. Memory beyond the initial program starts with the value 0 and can be read or written like any other memory. (It is invalid to try to access memory at a negative address, though.)
The computer should have support for large numbers. Some instructions near the beginning of the BOOST program will verify this capability.
Here are some example programs that use these features:

109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99 takes no input and produces a copy of itself as output.
1102,34915192,34915192,7,4,7,99,0 should output a 16-digit number.
104,1125899906842624,99 should output the large number in the middle.
The BOOST program will ask for a single input; run it in test mode by providing it the value 1. It will perform a series of checks on each opcode, output any opcodes (and the associated parameter modes) that seem to be functioning incorrectly, and finally output a BOOST keycode.

Once your Intcode computer is fully functional, the BOOST program should report no malfunctioning opcodes when run in test mode; it should only output a single value, the BOOST keycode. What BOOST keycode does it produce?

Your puzzle answer was 4006117640.

--- Part Two ---
You now have a complete Intcode computer.

Finally, you can lock on to the Ceres distress signal! You just need to boost your sensors using the BOOST program.

The program runs in sensor boost mode by providing the input instruction the value 2. Once run, it will boost the sensors automatically, but it might take a few seconds to complete the operation on slower hardware. In sensor boost mode, the program will output a single value: the coordinates of the distress signal.

Run the BOOST program in sensor boost mode. What are the coordinates of the distress signal?

Your puzzle answer was 88231.
**/
struct Day9: DayBase {
  func part1(_ input: String) -> Any {
    var memory = self.inputAsIntCodeMemory
    return IntCode.executeProgram(memory: &memory, input: { 1 })!
  }

  func part2(_ input: String) -> Any {
    var memory = self.inputAsIntCodeMemory
    return IntCode.executeProgram(memory: &memory, input: { 2 })!
  }
}

extension Day9 {
  var input: String {
    """
    1102,34463338,34463338,63,1007,63,34463338,63,1005,63,53,1102,1,3,1000,109,988,209,12,9,1000,209,6,209,3,203,0,1008,1000,1,63,1005,63,65,1008,1000,2,63,1005,63,904,1008,1000,0,63,1005,63,58,4,25,104,0,99,4,0,104,0,99,4,17,104,0,99,0,0,1101,0,641,1026,1101,0,24,1014,1101,30,0,1015,1101,0,0,1020,1101,35,0,1000,1101,0,708,1029,1101,0,27,1009,1102,38,1,1007,1102,638,1,1027,1101,1,0,1021,1102,32,1,1003,1101,0,34,1012,1102,20,1,1017,1102,1,37,1010,1101,0,713,1028,1101,33,0,1019,1102,1,36,1001,1102,22,1,1005,1101,23,0,1018,1101,21,0,1016,1102,28,1,1006,1101,0,26,1011,1102,1,215,1022,1102,1,29,1013,1102,25,1,1004,1102,1,31,1008,1102,1,292,1025,1102,297,1,1024,1101,208,0,1023,1102,1,39,1002,109,12,1206,9,197,1001,64,1,64,1106,0,199,4,187,1002,64,2,64,109,11,2105,1,0,1001,64,1,64,1105,1,217,4,205,1002,64,2,64,109,2,21107,40,41,-9,1005,1016,235,4,223,1105,1,239,1001,64,1,64,1002,64,2,64,109,-28,1207,3,36,63,1005,63,261,4,245,1001,64,1,64,1105,1,261,1002,64,2,64,109,5,1207,1,31,63,1005,63,281,1001,64,1,64,1105,1,283,4,267,1002,64,2,64,109,22,2105,1,0,4,289,1105,1,301,1001,64,1,64,1002,64,2,64,109,-16,1201,0,0,63,1008,63,31,63,1005,63,323,4,307,1106,0,327,1001,64,1,64,1002,64,2,64,109,18,1205,-5,345,4,333,1001,64,1,64,1105,1,345,1002,64,2,64,109,-21,2101,0,-2,63,1008,63,32,63,1005,63,367,4,351,1106,0,371,1001,64,1,64,1002,64,2,64,109,6,21102,41,1,7,1008,1018,38,63,1005,63,395,1001,64,1,64,1105,1,397,4,377,1002,64,2,64,109,-1,21107,42,41,2,1005,1012,413,1106,0,419,4,403,1001,64,1,64,1002,64,2,64,109,-10,2107,36,0,63,1005,63,435,1106,0,441,4,425,1001,64,1,64,1002,64,2,64,109,9,21108,43,44,9,1005,1018,461,1001,64,1,64,1105,1,463,4,447,1002,64,2,64,109,-10,2102,1,8,63,1008,63,39,63,1005,63,483,1105,1,489,4,469,1001,64,1,64,1002,64,2,64,109,21,21108,44,44,-1,1005,1019,511,4,495,1001,64,1,64,1106,0,511,1002,64,2,64,109,-18,1208,1,32,63,1005,63,533,4,517,1001,64,1,64,1105,1,533,1002,64,2,64,109,5,2101,0,-5,63,1008,63,37,63,1005,63,557,1001,64,1,64,1105,1,559,4,539,1002,64,2,64,109,8,1208,-8,35,63,1005,63,575,1105,1,581,4,565,1001,64,1,64,1002,64,2,64,109,-5,1202,-3,1,63,1008,63,38,63,1005,63,607,4,587,1001,64,1,64,1106,0,607,1002,64,2,64,109,-17,2107,31,10,63,1005,63,629,4,613,1001,64,1,64,1106,0,629,1002,64,2,64,109,31,2106,0,3,1105,1,647,4,635,1001,64,1,64,1002,64,2,64,109,-7,1201,-9,0,63,1008,63,32,63,1005,63,667,1106,0,673,4,653,1001,64,1,64,1002,64,2,64,109,-5,1202,-5,1,63,1008,63,41,63,1005,63,693,1105,1,699,4,679,1001,64,1,64,1002,64,2,64,109,16,2106,0,0,4,705,1105,1,717,1001,64,1,64,1002,64,2,64,109,-6,1205,-2,729,1105,1,735,4,723,1001,64,1,64,1002,64,2,64,109,-18,2102,1,1,63,1008,63,22,63,1005,63,761,4,741,1001,64,1,64,1105,1,761,1002,64,2,64,109,-2,2108,32,1,63,1005,63,783,4,767,1001,64,1,64,1105,1,783,1002,64,2,64,109,13,21102,45,1,-2,1008,1013,45,63,1005,63,809,4,789,1001,64,1,64,1105,1,809,1002,64,2,64,109,-13,2108,24,3,63,1005,63,829,1001,64,1,64,1106,0,831,4,815,1002,64,2,64,109,13,21101,46,0,-3,1008,1012,43,63,1005,63,851,1106,0,857,4,837,1001,64,1,64,1002,64,2,64,109,14,1206,-9,875,4,863,1001,64,1,64,1106,0,875,1002,64,2,64,109,-3,21101,47,0,-7,1008,1019,47,63,1005,63,901,4,881,1001,64,1,64,1105,1,901,4,64,99,21101,27,0,1,21101,0,915,0,1106,0,922,21201,1,66926,1,204,1,99,109,3,1207,-2,3,63,1005,63,964,21201,-2,-1,1,21102,942,1,0,1105,1,922,21202,1,1,-1,21201,-2,-3,1,21101,957,0,0,1106,0,922,22201,1,-1,-2,1106,0,968,22102,1,-2,-2,109,-3,2106,0,0
    """
  }
}
