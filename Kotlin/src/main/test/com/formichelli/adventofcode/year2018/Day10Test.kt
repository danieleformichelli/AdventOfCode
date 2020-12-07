package com.formichelli.adventofcode.year2018

import com.formichelli.adventofcode.utils.Utils
import org.junit.Assert
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.Parameterized

@RunWith(Parameterized::class)
class Day10Test(private val part1Result: String, private val part2Result: Int, private val points: List<String>) {
    companion object {
        @JvmStatic
        @Parameterized.Parameters
        fun data(): Collection<Array<Any>> {
            val hiMessage =
                    "#...#..###\n" +
                            "#...#...#.\n" +
                            "#...#...#.\n" +
                            "#####...#.\n" +
                            "#...#...#.\n" +
                            "#...#...#.\n" +
                            "#...#...#.\n" +
                            "#...#..###"

            val phfzcezxMessage =
                    "#####...#....#..######..######...####...######..######..#....#\n" +
                            "#....#..#....#..#............#..#....#..#............#..#....#\n" +
                            "#....#..#....#..#............#..#.......#............#...#..#.\n" +
                            "#....#..#....#..#...........#...#.......#...........#....#..#.\n" +
                            "#####...######..#####......#....#.......#####......#......##..\n" +
                            "#.......#....#..#.........#.....#.......#.........#.......##..\n" +
                            "#.......#....#..#........#......#.......#........#.......#..#.\n" +
                            "#.......#....#..#.......#.......#.......#.......#........#..#.\n" +
                            "#.......#....#..#.......#.......#....#..#.......#.......#....#\n" +
                            "#.......#....#..#.......######...####...######..######..#....#"
            return listOf(
                    arrayOf(hiMessage, 3, listOf("position=< 9,  1> velocity=< 0,  2>", "position=< 7,  0> velocity=<-1,  0>", "position=< 3, -2> velocity=<-1,  1>", "position=< 6, 10> velocity=<-2, -1>", "position=< 2, -4> velocity=< 2,  2>", "position=<-6, 10> velocity=< 2, -2>", "position=< 1,  8> velocity=< 1, -1>", "position=< 1,  7> velocity=< 1,  0>", "position=<-3, 11> velocity=< 1, -2>", "position=< 7,  6> velocity=<-1, -1>", "position=<-2,  3> velocity=< 1,  0>", "position=<-4,  3> velocity=< 2,  0>", "position=<10, -3> velocity=<-1,  1>", "position=< 5, 11> velocity=< 1, -2>", "position=< 4,  7> velocity=< 0, -1>", "position=< 8, -2> velocity=< 0,  1>", "position=<15,  0> velocity=<-2,  0>", "position=< 1,  6> velocity=< 1,  0>", "position=< 8,  9> velocity=< 0, -1>", "position=< 3,  3> velocity=<-1,  1>", "position=< 0,  5> velocity=< 0, -1>", "position=<-2,  2> velocity=< 2,  0>", "position=< 5, -2> velocity=< 1,  2>", "position=< 1,  4> velocity=< 2,  1>", "position=<-2,  7> velocity=< 2, -2>", "position=< 3,  6> velocity=<-1, -1>", "position=< 5,  0> velocity=< 1,  0>", "position=<-6,  0> velocity=< 2,  0>", "position=< 5,  9> velocity=< 1, -2>", "position=<14,  7> velocity=<-2,  0>", "position=<-3,  6> velocity=< 2, -1>")),
                    arrayOf(phfzcezxMessage, 10634, Utils.readLinesFromFile("year2018/day10input.txt"))
            )
        }
    }

    @Test
    fun part1() {
        Assert.assertEquals("The message that will appear is $part1Result", part1Result, Day10.part1(points))
    }

    @Test
    fun part2() {
        Assert.assertEquals("The message that will appear is $part2Result", part2Result, Day10.part2(points))
    }
}