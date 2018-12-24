package com.formichelli.adventofcode.year2018

object Day24 {
    /*
    --- Day 24: Immune System Simulator 20XX ---
    After a weird buzzing noise, you appear back at the man's cottage. He seems relieved to see his friend, but quickly notices that the little reindeer caught some kind of cold while out exploring.

    The portly man explains that this reindeer's immune system isn't similar to regular reindeer immune systems:

    The immune system and the infection each have an army made up of several groups; each group consists of one or more identical units. The armies repeatedly fight until only one army has units remaining.

    Units within a group all have the same hit points (amount of damage a unit can take before it is destroyed), attack damage (the amount of damage each unit deals), an attack type, an initiative (higher initiative units attack first and win ties), and sometimes weaknesses or immunities. Here is an example group:

    18 units each with 729 hit points (weak to fire; immune to cold, slashing)
     with an attack that does 8 radiation damage at initiative 10
    Each group also has an effective power: the number of units in that group multiplied by their attack damage. The above group has an effective power of 18 * 8 = 144. Groups never have zero or negative units; instead, the group is removed from combat.

    Each fight consists of two phases: target selection and attacking.

    During the target selection phase, each group attempts to choose one target. In decreasing order of effective power, groups choose their targets; in a tie, the group with the higher initiative chooses first. The attacking group chooses to target the group in the enemy army to which it would deal the most damage (after accounting for weaknesses and immunities, but not accounting for whether the defending group has enough units to actually receive all of that damage).

    If an attacking group is considering two defending groups to which it would deal equal damage, it chooses to target the defending group with the largest effective power; if there is still a tie, it chooses the defending group with the highest initiative. If it cannot deal any defending groups damage, it does not choose a target. Defending groups can only be chosen as a target by one attacking group.

    At the end of the target selection phase, each group has selected zero or one groups to attack, and each group is being attacked by zero or one groups.

    During the attacking phase, each group deals damage to the target it selected, if any. Groups attack in decreasing order of initiative, regardless of whether they are part of the infection or the immune system. (If a group contains no units, it cannot attack.)

    The damage an attacking group deals to a defending group depends on the attacking group's attack type and the defending group's immunities and weaknesses. By default, an attacking group would deal damage equal to its effective power to the defending group. However, if the defending group is immune to the attacking group's attack type, the defending group instead takes no damage; if the defending group is weak to the attacking group's attack type, the defending group instead takes double damage.

    The defending group only loses whole units from damage; damage is always dealt in such a way that it kills the most units possible, and any remaining damage to a unit that does not immediately kill it is ignored. For example, if a defending group contains 10 units with 10 hit points each and receives 75 damage, it loses exactly 7 units and is left with 3 units at full health.

    After the fight is over, if both armies still contain units, a new fight begins; combat only ends once one army has lost all of its units.

    For example, consider the following armies:

    Immune System:
    17 units each with 5390 hit points (weak to radiation, bludgeoning) with
     an attack that does 4507 fire damage at initiative 2
    989 units each with 1274 hit points (immune to fire; weak to bludgeoning,
     slashing) with an attack that does 25 slashing damage at initiative 3

    Infection:
    801 units each with 4706 hit points (weak to radiation) with an attack
     that does 116 bludgeoning damage at initiative 1
    4485 units each with 2961 hit points (immune to radiation; weak to fire,
     cold) with an attack that does 12 slashing damage at initiative 4
    If these armies were to enter combat, the following fights, including details during the target selection and attacking phases, would take place:

    Immune System:
    Group 1 contains 17 units
    Group 2 contains 989 units
    Infection:
    Group 1 contains 801 units
    Group 2 contains 4485 units

    Infection group 1 would deal defending group 1 185832 damage
    Infection group 1 would deal defending group 2 185832 damage
    Infection group 2 would deal defending group 2 107640 damage
    Immune System group 1 would deal defending group 1 76619 damage
    Immune System group 1 would deal defending group 2 153238 damage
    Immune System group 2 would deal defending group 1 24725 damage

    Infection group 2 attacks defending group 2, killing 84 units
    Immune System group 2 attacks defending group 1, killing 4 units
    Immune System group 1 attacks defending group 2, killing 51 units
    Infection group 1 attacks defending group 1, killing 17 units
    Immune System:
    Group 2 contains 905 units
    Infection:
    Group 1 contains 797 units
    Group 2 contains 4434 units

    Infection group 1 would deal defending group 2 184904 damage
    Immune System group 2 would deal defending group 1 22625 damage
    Immune System group 2 would deal defending group 2 22625 damage

    Immune System group 2 attacks defending group 1, killing 4 units
    Infection group 1 attacks defending group 2, killing 144 units
    Immune System:
    Group 2 contains 761 units
    Infection:
    Group 1 contains 793 units
    Group 2 contains 4434 units

    Infection group 1 would deal defending group 2 183976 damage
    Immune System group 2 would deal defending group 1 19025 damage
    Immune System group 2 would deal defending group 2 19025 damage

    Immune System group 2 attacks defending group 1, killing 4 units
    Infection group 1 attacks defending group 2, killing 143 units
    Immune System:
    Group 2 contains 618 units
    Infection:
    Group 1 contains 789 units
    Group 2 contains 4434 units

    Infection group 1 would deal defending group 2 183048 damage
    Immune System group 2 would deal defending group 1 15450 damage
    Immune System group 2 would deal defending group 2 15450 damage

    Immune System group 2 attacks defending group 1, killing 3 units
    Infection group 1 attacks defending group 2, killing 143 units
    Immune System:
    Group 2 contains 475 units
    Infection:
    Group 1 contains 786 units
    Group 2 contains 4434 units

    Infection group 1 would deal defending group 2 182352 damage
    Immune System group 2 would deal defending group 1 11875 damage
    Immune System group 2 would deal defending group 2 11875 damage

    Immune System group 2 attacks defending group 1, killing 2 units
    Infection group 1 attacks defending group 2, killing 142 units
    Immune System:
    Group 2 contains 333 units
    Infection:
    Group 1 contains 784 units
    Group 2 contains 4434 units

    Infection group 1 would deal defending group 2 181888 damage
    Immune System group 2 would deal defending group 1 8325 damage
    Immune System group 2 would deal defending group 2 8325 damage

    Immune System group 2 attacks defending group 1, killing 1 unit
    Infection group 1 attacks defending group 2, killing 142 units
    Immune System:
    Group 2 contains 191 units
    Infection:
    Group 1 contains 783 units
    Group 2 contains 4434 units

    Infection group 1 would deal defending group 2 181656 damage
    Immune System group 2 would deal defending group 1 4775 damage
    Immune System group 2 would deal defending group 2 4775 damage

    Immune System group 2 attacks defending group 1, killing 1 unit
    Infection group 1 attacks defending group 2, killing 142 units
    Immune System:
    Group 2 contains 49 units
    Infection:
    Group 1 contains 782 units
    Group 2 contains 4434 units

    Infection group 1 would deal defending group 2 181424 damage
    Immune System group 2 would deal defending group 1 1225 damage
    Immune System group 2 would deal defending group 2 1225 damage

    Immune System group 2 attacks defending group 1, killing 0 units
    Infection group 1 attacks defending group 2, killing 49 units
    Immune System:
    No groups remain.
    Infection:
    Group 1 contains 782 units
    Group 2 contains 4434 units
    In the example above, the winning army ends up with 782 + 4434 = 5216 units.

    You scan the reindeer's condition (your puzzle input); the white-bearded man looks nervous. As it stands now, how many units would the winning army have?
    */
    fun part1(immuneSystemBattle: List<String>): Int {
        val (immuneSystem, infection) = day24Helper(immuneSystemBattle, 0)
        return immuneSystem.sumBy { it.unitCount } + infection.sumBy { it.unitCount }
    }

    /*
    --- Part Two ---
    Things aren't looking good for the reindeer. The man asks whether more milk and cookies would help you think.

    If only you could give the reindeer's immune system a boost, you might be able to change the outcome of the combat.

    A boost is an integer increase in immune system units' attack damage. For example, if you were to boost the above example's immune system's units by 1570, the armies would instead look like this:

    Immune System:
    17 units each with 5390 hit points (weak to radiation, bludgeoning) with
     an attack that does 6077 fire damage at initiative 2
    989 units each with 1274 hit points (immune to fire; weak to bludgeoning,
     slashing) with an attack that does 1595 slashing damage at initiative 3

    Infection:
    801 units each with 4706 hit points (weak to radiation) with an attack
     that does 116 bludgeoning damage at initiative 1
    4485 units each with 2961 hit points (immune to radiation; weak to fire,
     cold) with an attack that does 12 slashing damage at initiative 4
    With this boost, the combat proceeds differently:

    Immune System:
    Group 2 contains 989 units
    Group 1 contains 17 units
    Infection:
    Group 1 contains 801 units
    Group 2 contains 4485 units

    Infection group 1 would deal defending group 2 185832 damage
    Infection group 1 would deal defending group 1 185832 damage
    Infection group 2 would deal defending group 1 53820 damage
    Immune System group 2 would deal defending group 1 1577455 damage
    Immune System group 2 would deal defending group 2 1577455 damage
    Immune System group 1 would deal defending group 2 206618 damage

    Infection group 2 attacks defending group 1, killing 9 units
    Immune System group 2 attacks defending group 1, killing 335 units
    Immune System group 1 attacks defending group 2, killing 32 units
    Infection group 1 attacks defending group 2, killing 84 units
    Immune System:
    Group 2 contains 905 units
    Group 1 contains 8 units
    Infection:
    Group 1 contains 466 units
    Group 2 contains 4453 units

    Infection group 1 would deal defending group 2 108112 damage
    Infection group 1 would deal defending group 1 108112 damage
    Infection group 2 would deal defending group 1 53436 damage
    Immune System group 2 would deal defending group 1 1443475 damage
    Immune System group 2 would deal defending group 2 1443475 damage
    Immune System group 1 would deal defending group 2 97232 damage

    Infection group 2 attacks defending group 1, killing 8 units
    Immune System group 2 attacks defending group 1, killing 306 units
    Infection group 1 attacks defending group 2, killing 29 units
    Immune System:
    Group 2 contains 876 units
    Infection:
    Group 2 contains 4453 units
    Group 1 contains 160 units

    Infection group 2 would deal defending group 2 106872 damage
    Immune System group 2 would deal defending group 2 1397220 damage
    Immune System group 2 would deal defending group 1 1397220 damage

    Infection group 2 attacks defending group 2, killing 83 units
    Immune System group 2 attacks defending group 2, killing 427 units
    After a few fights...

    Immune System:
    Group 2 contains 64 units
    Infection:
    Group 2 contains 214 units
    Group 1 contains 19 units

    Infection group 2 would deal defending group 2 5136 damage
    Immune System group 2 would deal defending group 2 102080 damage
    Immune System group 2 would deal defending group 1 102080 damage

    Infection group 2 attacks defending group 2, killing 4 units
    Immune System group 2 attacks defending group 2, killing 32 units
    Immune System:
    Group 2 contains 60 units
    Infection:
    Group 1 contains 19 units
    Group 2 contains 182 units

    Infection group 1 would deal defending group 2 4408 damage
    Immune System group 2 would deal defending group 1 95700 damage
    Immune System group 2 would deal defending group 2 95700 damage

    Immune System group 2 attacks defending group 1, killing 19 units
    Immune System:
    Group 2 contains 60 units
    Infection:
    Group 2 contains 182 units

    Infection group 2 would deal defending group 2 4368 damage
    Immune System group 2 would deal defending group 2 95700 damage

    Infection group 2 attacks defending group 2, killing 3 units
    Immune System group 2 attacks defending group 2, killing 30 units
    After a few more fights...

    Immune System:
    Group 2 contains 51 units
    Infection:
    Group 2 contains 40 units

    Infection group 2 would deal defending group 2 960 damage
    Immune System group 2 would deal defending group 2 81345 damage

    Infection group 2 attacks defending group 2, killing 0 units
    Immune System group 2 attacks defending group 2, killing 27 units
    Immune System:
    Group 2 contains 51 units
    Infection:
    Group 2 contains 13 units

    Infection group 2 would deal defending group 2 312 damage
    Immune System group 2 would deal defending group 2 81345 damage

    Infection group 2 attacks defending group 2, killing 0 units
    Immune System group 2 attacks defending group 2, killing 13 units
    Immune System:
    Group 2 contains 51 units
    Infection:
    No groups remain.
    This boost would allow the immune system's armies to win! It would be left with 51 units.

    You don't even know how you could boost the reindeer's immune system or what effect it might have, so you need to be cautious and find the smallest boost that would allow the immune system to win.

    How many units does the immune system have left after getting the smallest boost it needs to win?
    */
    fun part2(immuneSystemBattle: List<String>): Int {
        var minBoost = Int.MIN_VALUE
        var maxBoost = Int.MAX_VALUE
        var currentBoost = 1024

        while (minBoost != maxBoost) {
            val (immuneSystem, _) = day24Helper(immuneSystemBattle, currentBoost)
            if (immuneSystem.isEmpty()) {
                // infection won
                minBoost = currentBoost + 1
                if (maxBoost == Int.MAX_VALUE) {
                    currentBoost *= 2
                } else {
                    currentBoost = (minBoost + maxBoost) / 2
                }
            } else {
                // immune system won
                maxBoost = currentBoost
                if (minBoost == Int.MIN_VALUE) {
                    currentBoost /= 2
                } else {
                    currentBoost = (minBoost + maxBoost) / 2
                }
            }
        }

        return day24Helper(immuneSystemBattle, currentBoost).first.sumBy { it.unitCount }
    }

    private fun parseInput(immuneSystemBattle: List<String>, boost: Int): Pair<MutableSet<UnitGroup>, MutableSet<UnitGroup>> {
        val immuneSystemGroups = HashSet<UnitGroup>()
        val infectionGroups = HashSet<UnitGroup>()
        var groupType = GroupType.IMMUNE_SYSTEM
        immuneSystemBattle.forEach {
            when (it) {
                "Immune System:" -> groupType = GroupType.IMMUNE_SYSTEM
                "Infection:" -> groupType = GroupType.INFECTION
                "" -> {
                }
                else -> {
                    val group = if (groupType == GroupType.IMMUNE_SYSTEM) immuneSystemGroups else infectionGroups
                    val groupBoost = if (groupType == GroupType.IMMUNE_SYSTEM) boost else 0
                    group.add(parseUnitGroup(groupType, it, groupBoost))
                }
            }
        }

        return Pair(immuneSystemGroups, infectionGroups)
    }

    private fun day24Helper(immuneSystemBattle: List<String>, boost: Int): Pair<Set<UnitGroup>, Set<UnitGroup>> {
        val (immuneSystem, infection) = parseInput(immuneSystemBattle, boost)
        while (!immuneSystem.isEmpty() && !infection.isEmpty()) {
            val remainingGroups = ArrayList(immuneSystem)
            remainingGroups.addAll(infection)

            val selectedTargets = HashMap<UnitGroup, UnitGroup>()
            remainingGroups.sortWith(compareByDescending(UnitGroup::effectivePower).thenByDescending(UnitGroup::initiative))
            remainingGroups.forEach { attackingGroup ->
                val defendingGroups = if (attackingGroup.groupType == GroupType.IMMUNE_SYSTEM) infection else immuneSystem
                var selectedTarget: UnitGroup? = null
                for (defendingGroup in defendingGroups) {
                    if (selectedTargets.values.contains(defendingGroup)) {
                        // target already selected
                        continue
                    }

                    selectedTarget = attackingGroup.preferredTarget(selectedTarget, defendingGroup)
                }

                if (selectedTarget != null) {
                    selectedTargets[attackingGroup] = selectedTarget
                }
            }

            var diedUnits = 0
            remainingGroups.sortByDescending { it.initiative }
            for (attackingGroup in remainingGroups) {
                if (attackingGroup.unitCount <= 0) {
                    // died in this turn
                    continue
                }
                val target = selectedTargets[attackingGroup]
                if (target != null) {
                    diedUnits += attackingGroup.attack(target)
                    if (target.unitCount <= 0) {
                        val defendingGroups = if (attackingGroup.groupType == GroupType.IMMUNE_SYSTEM) infection else immuneSystem
                        defendingGroups.remove(target)
                    }
                }
            }

            if (diedUnits == 0) {
                // no lost unit in turn, battle will never end
                return Pair(emptySet(), emptySet())
            }
        }

        return Pair(immuneSystem, infection)
    }

    private fun parseUnitGroup(groupType: GroupType, unitGroupStr: String, attackBoost: Int): UnitGroup {
        val unitGroupSplit = unitGroupStr.split(" units each with ", " hit points", "with an attack that does ", " damage at initiative ")
        val unitCount = unitGroupSplit[0].toInt()
        val hp = unitGroupSplit[1].toInt()
        val weakTo = parseWeaknessOrImmunity(unitGroupSplit[2], "weak to")
        val immuneTo = parseWeaknessOrImmunity(unitGroupSplit[2], "immune to")
        val attackPower = unitGroupSplit[3].split(" ")[0].toInt() + attackBoost
        val attackType = AttackType.valueOf(unitGroupSplit[3].split(" ")[1].toUpperCase())
        val initiative = unitGroupSplit[4].toInt()
        return UnitGroup(groupType, unitCount, hp, attackPower, attackType, initiative, weakTo, immuneTo)
    }

    private fun parseWeaknessOrImmunity(weaknessAndImmunity: String, prefix: String): Set<AttackType> {
        val weaknessOrImmunity = HashSet<AttackType>()
        val startIndex = weaknessAndImmunity.indexOf(prefix)
        if (startIndex == -1) {
            return weaknessOrImmunity
        }

        val semiColumnIndex = weaknessAndImmunity.indexOf(";", startIndex)
        val closedParenthesisIndex = weaknessAndImmunity.indexOf(")", startIndex)
        val endIndex = Math.min(if (semiColumnIndex != -1) semiColumnIndex else Int.MAX_VALUE, if (closedParenthesisIndex != -1) closedParenthesisIndex else Int.MAX_VALUE)
        val weaknessOrImmunitySplit = weaknessAndImmunity.substring(startIndex + prefix.length + 1, endIndex).split(", ")
        weaknessOrImmunitySplit.forEach {
            weaknessOrImmunity.add(AttackType.valueOf(it.toUpperCase()))
        }
        return weaknessOrImmunity
    }

    data class UnitGroup(var groupType: GroupType, var unitCount: Int, val hp: Int, val attackPower: Int, val attackType: AttackType, val initiative: Int, val weakTo: Set<AttackType>, val immuneTo: Set<AttackType>) {
        override fun equals(other: Any?) = this === other

        override fun hashCode(): Int {
            return super.hashCode()
        }

        fun effectivePower() = unitCount * attackPower

        private fun wouldDealDamage(defendingGroup: UnitGroup?) = when {
            defendingGroup == null -> 0
            defendingGroup.immuneTo.contains(attackType) -> 0
            defendingGroup.weakTo.contains(attackType) -> 2 * effectivePower()
            else -> effectivePower()
        }

        fun preferredTarget(selectedTarget: UnitGroup?, newTarget: UnitGroup): UnitGroup? {
            val selectedTargetDamage = wouldDealDamage(selectedTarget)
            val newTargetDamage = wouldDealDamage(newTarget)
            if (newTargetDamage > selectedTargetDamage) {
                return newTarget
            } else if (newTargetDamage == 0 || newTargetDamage < selectedTargetDamage) {
                return selectedTarget
            }

            // tie on damage, choose by effective power
            if (newTarget.effectivePower() > selectedTarget!!.effectivePower()) {
                return newTarget
            } else if (newTarget.effectivePower() < selectedTarget.effectivePower()) {
                return selectedTarget
            }

            // tie on damage, choose by initiative
            return if (newTarget.initiative > selectedTarget.initiative) {
                newTarget
            } else {
                selectedTarget
            }
        }

        fun attack(defendingGroup: UnitGroup): Int {
            val dealtDamage = wouldDealDamage(defendingGroup)
            val lostUnits = dealtDamage / defendingGroup.hp
            defendingGroup.unitCount -= lostUnits
            return lostUnits
        }
    }

    enum class GroupType {
        IMMUNE_SYSTEM, INFECTION
    }

    enum class AttackType {
        COLD, BLUDGEONING, SLASHING, RADIATION, FIRE
    }
}