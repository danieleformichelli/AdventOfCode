package com.formichelli.adventofcode.year2018

object Day12 {
    /*
    --- Day 12: Subterranean Sustainability ---
    The year 518 is significantly more underground than your history books implied. Either that, or you've arrived in a vast cavern network under the North Pole.

    After exploring a little, you discover a long tunnel that contains a row of small pots as far as you can see to your left and right. A few of them contain plantsIndexes - someone is trying to grow things in these geothermally-heated caves.

    The pots are numbered, with 0 in front of you. To the left, the pots are numbered -1, -2, -3, and so on; to the right, 1, 2, 3.... Your puzzle generationAndRules contains a list of pots from 0 to the right and whether they do (#) or do not (.) currently contain a plant, the initial state. (No other pots currently contain plantsIndexes.) For example, an initial state of #..##.... indicates that pots 0, 3, and 4 currently contain plantsIndexes.

    Your puzzle generationAndRules also contains some notes you find on a nearby table: someone has been trying to figure out how these plantsIndexes spread to nearby pots. Based on the notes, for each generation of plantsIndexes, a given pot has or does not have a plant based on whether that pot (and the two pots on either side of it) had a plant in the last generation. These are written as LLCRR => N, where L are pots to the left, C is the current pot being considered, R are the pots to the right, and N is whether the current pot will have a plant in the next generation. For example:

    A note like ..#.. => . means that a pot that contains a plant but with no plantsIndexes within two pots of it will not have a plant in it during the next generation.
    A note like ##.## => . means that an empty pot with two plantsIndexes on each side of it will remain empty in the next generation.
    A note like .##.# => # means that a pot has a plant in a given generation if, in the previous generation, there were plantsIndexes in that pot, the one immediately to the left, and the one two pots to the right, but not in the ones immediately to the right and two to the left.
    It's not clear what these plantsIndexes are for, but you're sure it's important, so you'd like to make sure the current configuration of plantsIndexes is sustainable by determining what will happen after 20 generations.

    For example, given the following generationAndRules:

    initial state: #..#.#..##......###...###

    ...## => #
    ..#.. => #
    .#... => #
    .#.#. => #
    .#.## => #
    .##.. => #
    .#### => #
    #.#.# => #
    #.### => #
    ##.#. => #
    ##.## => #
    ###.. => #
    ###.# => #
    ####. => #
    For brevity, in this example, only the combinations which do produce a plant are listed. (Your generationAndRules includes all possible combinations.) Then, the next 20 generations will look like this:

                     1         2         3
           0         0         0         0
     0: ...#..#.#..##......###...###...........
     1: ...#...#....#.....#..#..#..#...........
     2: ...##..##...##....#..#..#..##..........
     3: ..#.#...#..#.#....#..#..#...#..........
     4: ...#.#..#...#.#...#..#..##..##.........
     5: ....#...##...#.#..#..#...#...#.........
     6: ....##.#.#....#...#..##..##..##........
     7: ...#..###.#...##..#...#...#...#........
     8: ...#....##.#.#.#..##..##..##..##.......
     9: ...##..#..#####....#...#...#...#.......
    10: ..#.#..#...#.##....##..##..##..##......
    11: ...#...##...#.#...#.#...#...#...#......
    12: ...##.#.#....#.#...#.#..##..##..##.....
    13: ..#..###.#....#.#...#....#...#...#.....
    14: ..#....##.#....#.#..##...##..##..##....
    15: ..##..#..#.#....#....#..#.#...#...#....
    16: .#.#..#...#.#...##...#...#.#..##..##...
    17: ..#...##...#.#.#.#...##...#....#...#...
    18: ..##.#.#....#####.#.#.#...##...##..##..
    19: .#..###.#..#.#.#######.#.#.#..#.#...#..
    20: .#....##....#####...#######....#.#..##.
    The generation is shown along the left, where 0 is the initial state. The pot numbers are shown along the top, where 0 labels the center pot, negative-numbered pots extend to the left, and positive pots extend toward the right. Remember, the initial state begins at pot 0, which is not the leftmost pot used in this example.

    After one generation, only seven plantsIndexes remain. The one in pot 0 matched the rule looking for ..#.., the one in pot 4 matched the rule looking for .#.#., pot 9 matched .##.., and so on.

    In this example, after 20 generations, the pots shown as # contain plantsIndexes, the furthest left of which is pot -2, and the furthest right of which is pot 34. Adding up all the numbers of plant-containing pots after the 20th generation produces 325.

    After 20 generations, what is the sum of the numbers of all pots which contain a plant?
     */
    fun part1(generationAndRules: List<String>): Long {
        return day12Helper(generationAndRules, 20)
    }

    /*
    --- Part Two ---
    You realize that 20 generations aren't enough. After all, these plants will need to last another 1500 years to even reach your timeline, not to mention your future.

    After fifty billion (50000000000) generations, what is the sum of the numbers of all pots which contain a plant?
    */
    fun part2(generationAndRules: List<String>): Long {
        return day12Helper(generationAndRules, 50000000000L)
    }

    private fun day12Helper(generationAndRules: List<String>, generationsCount: Long): Long {
        val (firstGeneration, rules) = parseInput(generationAndRules)
        val generations = HashMap<Generation, Long>()

        var nextGeneration = firstGeneration
        var generationIndex = 0L
        var loopDone = false
        while (generationIndex < generationsCount) {
            var currentGeneration: Generation
            if (!loopDone && generations.containsKey(nextGeneration)) {
                loopDone = true
                val repeatedGenerationEntry = generations.entries.find { it.key == nextGeneration }!!
                val repeatedGeneration = repeatedGenerationEntry.key
                val repeatedGenerationIndex = repeatedGenerationEntry.value
                val repeatedGenerationLoopSize = generationIndex - repeatedGenerationIndex
                val repeatedGenerationDrift = nextGeneration.minPlantIndex - repeatedGeneration.minPlantIndex

                val numberOfLoops = (generationsCount - generationIndex) / repeatedGenerationLoopSize
                val totalDrift = numberOfLoops * repeatedGenerationDrift
                generationIndex += numberOfLoops * repeatedGenerationLoopSize

                currentGeneration = Generation()
                nextGeneration.plantsIndexes.forEach {
                    currentGeneration.addPlant(it + totalDrift)
                }

                if (generationIndex == generationsCount) {
                    nextGeneration = currentGeneration
                    break
                } else {
                    nextGeneration = Generation()
                }
            } else {
                currentGeneration = nextGeneration
                generations[currentGeneration] = generationIndex
                nextGeneration = Generation()
            }

            for (j in currentGeneration.minPlantIndex - 2..currentGeneration.maxPlantIndex + 2) {
                val numberAtJ = computeNumberAtIndex(currentGeneration, j)

                if (rules.contains(numberAtJ)) {
                    nextGeneration.addPlant(j)
                }
            }

            ++generationIndex
        }

        var sum = 0L
        nextGeneration.plantsIndexes.forEach { sum += it }
        return sum
    }

    private fun computeNumberAtIndex(currentGeneration: Generation, i: Long): Int {
        var numberAtJ = 0
        (-2..2).forEach {
            if (currentGeneration.plantsIndexes.contains(i + it)) {
                numberAtJ = numberAtJ.or(1.shl(2 - it))
            }
        }
        return numberAtJ
    }

    class Generation {
        val plantsIndexes = HashSet<Long>()
        var minPlantIndex: Long = Long.MAX_VALUE
        var maxPlantIndex: Long = Long.MIN_VALUE

        override fun equals(other: Any?): Boolean {
            if (other !is Generation) {
                return false
            }

            if (plantsIndexes.size != other.plantsIndexes.size) {
                return false
            }

            return plantsIndexes.all { other.plantsIndexes.contains(it - minPlantIndex + other.minPlantIndex) }
        }

        fun addPlant(i: Long) {
            plantsIndexes.add(i)
            minPlantIndex = Math.min(minPlantIndex, i)
            maxPlantIndex = Math.max(maxPlantIndex, i)
        }

        override fun hashCode(): Int {
            return plantsIndexes.map { it - minPlantIndex }.hashCode()
        }
    }

    private fun parseInput(generationAndRules: List<String>): Pair<Generation, Set<Int>> {
        val generation = Generation()
        val generationStr = generationAndRules[0]
        val generationPrefixLength = "initial state: ".length
        for (i in generationPrefixLength until generationStr.length) {
            if (generationStr[i] == '#') {
                val plantIndex = i - generationPrefixLength
                generation.addPlant(plantIndex.toLong())
            }
        }
        val rules = HashSet<Int>()
        for (i in 2 until generationAndRules.size) {
            val ruleSplit = generationAndRules[i].split(" => ")
            val ruleOutput = ruleSplit[1] == "#"
            if (!ruleOutput) {
                continue
            }

            var ruleInt = 0
            for (j in 0 until 5) {
                if (ruleSplit[0][j] == '#') {
                    ruleInt = ruleInt.or(1.shl(4 - j))
                }
            }

            rules.add(ruleInt)
        }

        return Pair(generation, rules)
    }
}