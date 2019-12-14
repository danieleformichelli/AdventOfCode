//
//  Day14.swift
//  AdventOfCode2019
//
//  Created by Daniele Formichelli on 14/12/2019.
//  Copyright © 2019 Daniele Formichelli. All rights reserved.
//

/**
--- Day 14: Space Stoichiometry ---
As you approach the rings of Saturn, your ship's low fuel indicator turns on. There isn't any fuel here, but the rings have plenty of raw material. Perhaps your ship's Inter-Stellar Refinery Union brand nanofactory can turn these raw materials into fuel.

You ask the nanofactory to produce a list of the reactions it can perform that are relevant to this process (your puzzle input). Every reaction turns some quantities of specific input chemicals into some quantity of an output chemical. Almost every chemical is produced by exactly one reaction; the only exception, ORE, is the raw material input to the entire process and is not produced by a reaction.

You just need to know how much ORE you'll need to collect before you can produce one unit of FUEL.

Each reaction gives specific quantities for its inputs and output; reactions cannot be partially run, so only whole integer multiples of these quantities can be used. (It's okay to have leftover chemicals when you're done, though.) For example, the reaction 1 A, 2 B, 3 C => 2 D means that exactly 2 units of chemical D can be produced by consuming exactly 1 A, 2 B and 3 C. You can run the full reaction as many times as necessary; for example, you could produce 10 D by consuming 5 A, 10 B, and 15 C.

Suppose your nanofactory produces the following list of reactions:

10 ORE => 10 A
1 ORE => 1 B
7 A, 1 B => 1 C
7 A, 1 C => 1 D
7 A, 1 D => 1 E
7 A, 1 E => 1 FUEL
The first two reactions use only ORE as inputs; they indicate that you can produce as much of chemical A as you want (in increments of 10 units, each 10 costing 10 ORE) and as much of chemical B as you want (each costing 1 ORE). To produce 1 FUEL, a total of 31 ORE is required: 1 ORE to produce 1 B, then 30 more ORE to produce the 7 + 7 + 7 + 7 = 28 A (with 2 extra A wasted) required in the reactions to convert the B into C, C into D, D into E, and finally E into FUEL. (30 A is produced because its reaction requires that it is created in increments of 10.)

Or, suppose you have the following list of reactions:

9 ORE => 2 A
8 ORE => 3 B
7 ORE => 5 C
3 A, 4 B => 1 AB
5 B, 7 C => 1 BC
4 C, 1 A => 1 CA
2 AB, 3 BC, 4 CA => 1 FUEL
The above list of reactions requires 165 ORE to produce 1 FUEL:

Consume 45 ORE to produce 10 A.
Consume 64 ORE to produce 24 B.
Consume 56 ORE to produce 40 C.
Consume 6 A, 8 B to produce 2 AB.
Consume 15 B, 21 C to produce 3 BC.
Consume 16 C, 4 A to produce 4 CA.
Consume 2 AB, 3 BC, 4 CA to produce 1 FUEL.
Here are some larger examples:

13312 ORE for 1 FUEL:

157 ORE => 5 NZVS
165 ORE => 6 DCFZ
44 XJWVT, 5 KHKGT, 1 QDVJ, 29 NZVS, 9 GPVTF, 48 HKGWZ => 1 FUEL
12 HKGWZ, 1 GPVTF, 8 PSHF => 9 QDVJ
179 ORE => 7 PSHF
177 ORE => 5 HKGWZ
7 DCFZ, 7 PSHF => 2 XJWVT
165 ORE => 2 GPVTF
3 DCFZ, 7 NZVS, 5 HKGWZ, 10 PSHF => 8 KHKGT
180697 ORE for 1 FUEL:

2 VPVL, 7 FWMGM, 2 CXFTF, 11 MNCFX => 1 STKFG
17 NVRVD, 3 JNWZP => 8 VPVL
53 STKFG, 6 MNCFX, 46 VJHF, 81 HVMC, 68 CXFTF, 25 GNMV => 1 FUEL
22 VJHF, 37 MNCFX => 5 FWMGM
139 ORE => 4 NVRVD
144 ORE => 7 JNWZP
5 MNCFX, 7 RFSQX, 2 FWMGM, 2 VPVL, 19 CXFTF => 3 HVMC
5 VJHF, 7 MNCFX, 9 VPVL, 37 CXFTF => 6 GNMV
145 ORE => 6 MNCFX
1 NVRVD => 8 CXFTF
1 VJHF, 6 MNCFX => 4 RFSQX
176 ORE => 6 VJHF
2210736 ORE for 1 FUEL:

171 ORE => 8 CNZTR
7 ZLQW, 3 BMBT, 9 XCVML, 26 XMNCP, 1 WPTQ, 2 MZWV, 1 RJRHP => 4 PLWSL
114 ORE => 4 BHXH
14 VRPVC => 6 BMBT
6 BHXH, 18 KTJDG, 12 WPTQ, 7 PLWSL, 31 FHTLT, 37 ZDVW => 1 FUEL
6 WPTQ, 2 BMBT, 8 ZLQW, 18 KTJDG, 1 XMNCP, 6 MZWV, 1 RJRHP => 6 FHTLT
15 XDBXC, 2 LTCX, 1 VRPVC => 6 ZLQW
13 WPTQ, 10 LTCX, 3 RJRHP, 14 XMNCP, 2 MZWV, 1 ZLQW => 1 ZDVW
5 BMBT => 4 WPTQ
189 ORE => 9 KTJDG
1 MZWV, 17 XDBXC, 3 XCVML => 2 XMNCP
12 VRPVC, 27 CNZTR => 2 XDBXC
15 KTJDG, 12 BHXH => 5 XCVML
3 BHXH, 2 VRPVC => 7 MZWV
121 ORE => 7 VRPVC
7 XCVML => 6 RJRHP
5 BHXH, 4 VRPVC => 5 LTCX
Given the list of reactions in your puzzle input, what is the minimum amount of ORE required to produce exactly 1 FUEL?

Your puzzle answer was 469536.

--- Part Two ---
After collecting ORE for a while, you check your cargo hold: 1 trillion (1000000000000) units of ORE.

With that much ore, given the examples above:

The 13312 ORE-per-FUEL example could produce 82892753 FUEL.
The 180697 ORE-per-FUEL example could produce 5586022 FUEL.
The 2210736 ORE-per-FUEL example could produce 460664 FUEL.
Given 1 trillion ORE, what is the maximum amount of FUEL you can produce?

Your puzzle answer was 3343477.
**/
struct Day14: DayBase {
  func part1(_ input: String) -> Any {
    return Self.requiredORE(for: 1, reactions: self.reactions)
  }

  func part2(_ input: String) -> Any {
    let reactions = self.reactions

    let orePerOneFuel = Self.requiredORE(for: 1, reactions: reactions)
    let availableORE = Int64(1_000_000_000_000)
    // for sure we can at least obtain availableORE / orePerOneFuel (i.e. not reusing the reminders)
    let minimumFuel = availableORE / orePerOneFuel
    // for sure we cannot obtain twice that value (or it means that we could obtain integer fuel from the reminder of 1 fuel)
    let maximumFuel = 2 * minimumFuel

    return Self.findMaxFuel(minimumFuel: minimumFuel, maximumFuel: maximumFuel, availableORE: availableORE, reactions: reactions)
  }

  private static func findMaxFuel(minimumFuel: Int64, maximumFuel: Int64, availableORE: Int64, reactions: [String: Reaction]) -> Int64 {

    guard minimumFuel != maximumFuel else { return minimumFuel }

    let midFuel = (maximumFuel + minimumFuel) / 2
    let minRequiredORE = Self.requiredORE(for: midFuel, reactions: reactions)

    if minRequiredORE > availableORE {
      return findMaxFuel(minimumFuel: minimumFuel, maximumFuel: midFuel - 1, availableORE: availableORE, reactions: reactions)
    } else {
      return findMaxFuel(minimumFuel: midFuel + 1, maximumFuel: maximumFuel, availableORE: availableORE, reactions: reactions)

    }
  }

  private static func requiredORE(for fuel: Int64, reactions: [String: Reaction]) -> Int64 {
    var requiredChemicals = ["FUEL": ChemicalAndQuantity(chemical: "FUEL", quantity: fuel)]
    var availableChemicals: [String: ChemicalAndQuantity]  = [:]
    var requiredORE: Int64 = 0

    while !requiredChemicals.isEmpty {
      let firstEntry = requiredChemicals.first!
      let requiredOutputChemicalAndQuantity = requiredChemicals.removeValue(forKey: firstEntry.key)!
      let requiredOutputChemical = requiredOutputChemicalAndQuantity.chemical
      var requiredOutputQuantity = requiredOutputChemicalAndQuantity.quantity

      if
        let availableOutputQuantity = availableChemicals[requiredOutputChemical]?.quantity,
        availableOutputQuantity > 0
      {
        // we already have some of the required chemical as result of other reactions
        if availableOutputQuantity >= requiredOutputQuantity {
          // the available chemical covers the entire request, use that
          availableChemicals[requiredOutputChemical] = ChemicalAndQuantity(
            chemical: requiredOutputChemical,
            quantity: availableOutputQuantity - requiredOutputQuantity
          )
          continue
        } else {
          // the available chemical covers part of the request, update the requiredOutputQuantity
          requiredOutputQuantity = requiredOutputQuantity - availableOutputQuantity
          availableChemicals[requiredOutputChemical] = nil
        }
      }

      let reaction = reactions[requiredOutputChemical]!
      let requiredReactions = Int64((Double(requiredOutputQuantity) / Double(reaction.output.quantity)).rounded(.up))

      reaction.inputs.forEach { reactionInput in
        let requiredInputChemical = reactionInput.chemical
        let requiredInputQuantity = requiredReactions * reactionInput.quantity

        if
          let availableInputQuantity = availableChemicals[requiredInputChemical]?.quantity,
          availableInputQuantity > 0
        {
          // we already have some of the required input chemical as result of other reactions
          if availableInputQuantity >= requiredInputQuantity {
            // the available chemical covers the entire request, use that
            availableChemicals[requiredInputChemical] = ChemicalAndQuantity(
              chemical: requiredInputChemical,
              quantity: availableInputQuantity - requiredInputQuantity
            )
          } else {
            // the available chemical covers part of the request, use that and add the remaining part to the requiredChemicals
            let remainingRequiredInputQuantity = requiredInputQuantity - availableInputQuantity
            let previouslyRequiredChemical = requiredChemicals[requiredInputChemical]?.quantity ?? 0
            requiredChemicals[requiredInputChemical] = ChemicalAndQuantity(
              chemical: requiredInputChemical,
              quantity: previouslyRequiredChemical + remainingRequiredInputQuantity
            )
            availableChemicals[requiredInputChemical] = nil
          }
        } else {
          if requiredInputChemical == "ORE" {
            requiredORE += requiredReactions * reactionInput.quantity
          } else {
            let previouslyRequiredChemical = requiredChemicals[requiredInputChemical]?.quantity ?? 0
            requiredChemicals[requiredInputChemical] = ChemicalAndQuantity(
              chemical: requiredInputChemical,
              quantity: previouslyRequiredChemical + requiredInputQuantity
            )
          }
        }

        let outputChemicalQuantity = requiredReactions * reaction.output.quantity
        if outputChemicalQuantity > requiredOutputQuantity {
          // some additional quantity is available after the required reactions
          let remainingQuantity = outputChemicalQuantity - requiredOutputQuantity
          availableChemicals[requiredOutputChemical] = ChemicalAndQuantity(
            chemical: requiredOutputChemical,
            quantity: remainingQuantity
          )
        }
      }
    }

    return requiredORE
  }
}

struct ChemicalAndQuantity {
  let chemical: String
  let quantity: Int64

  static func from(_ string: String) -> ChemicalAndQuantity {
    let quantityAndChemical = string.components(separatedBy: " ")
    let quantity = Int64(quantityAndChemical[0])!
    let chemical = quantityAndChemical[1]
    return ChemicalAndQuantity(chemical: chemical, quantity: quantity)
  }
}

struct Reaction {
  let inputs: [ChemicalAndQuantity]
  let output: ChemicalAndQuantity

  static func from(_ string: String) -> Reaction {
    let inputAndOutput = string.components(separatedBy: " => ")

    let inputs: [ChemicalAndQuantity] = inputAndOutput[0].components(separatedBy: ", ").map { ChemicalAndQuantity.from($0) }
    let output = ChemicalAndQuantity.from(inputAndOutput[1])
    return Reaction(inputs: inputs, output: output)
  }
}

extension Day14 {
  var reactions: [String: Reaction] {
    let reactions = self.inputLines.map { Reaction.from($0) }
    return Dictionary(uniqueKeysWithValues: reactions.map { ($0.output.chemical, $0)})
  }

  var input: String {
    """
    1 RNQHX, 1 LFKRJ, 1 JNGM => 8 DSRGV
    2 HCQGN, 1 XLNC, 4 WRPWG => 7 ZGVZL
    172 ORE => 5 WRPWG
    7 MXMQ, 1 SLTF => 3 JTBLB
    1 DSRGV => 4 SLZF
    2 HDVD, 32 LFKRJ => 4 FCZQD
    9 LNRS, 18 WKMWF => 8 RNQRM
    12 MWSGQ => 9 DCKC
    6 SLTF, 5 XLNC => 1 KFBX
    4 QNRZ, 1 QHLF, 15 FWSK => 9 SFJC
    9 KFBX, 15 RPKGX, 2 QNRZ => 6 LFKRJ
    8 SFJC, 6 ZQGL, 4 PFCGF => 3 THPCT
    2 RNQHX, 4 PFCGF, 1 ZQGL => 6 LNRS
    195 ORE => 4 PTHDF
    3 FJKSL => 7 FWSK
    12 KBJW, 9 MWSGQ => 9 WKMWF
    3 XLNC => 5 RPKGX
    188 ORE => 7 FJKSL
    6 ZNPNM, 3 KHXPM, 3 TJXB => 2 HSDS
    1 DGKW, 17 XLNC => 1 PFCGF
    2 VRPJZ, 3 DSRGV => 5 MWSGQ
    12 BJBQP, 5 XLNC => 4 HCQGN
    1 GFCGF => 3 HDVD
    18 TJXB, 2 THPCT, 1 WPGQN => 4 KHXPM
    1 ZGVZL => 1 JNGM
    3 ZGVZL => 8 KBJW
    12 GFCGF => 8 BJBQP
    7 MXMQ, 18 WRPWG => 9 XLNC
    13 ZGVZL, 1 QNRZ => 6 RNQHX
    5 HRBG, 16 QNRZ => 9 WPGQN
    5 SFJC, 1 PFCGF, 1 KHXPM => 5 FXDMQ
    1 KBJW, 5 BNFV, 16 XLNC, 1 JNGM, 1 PFCGF, 1 ZNPNM, 4 FXDMQ => 5 VBWCM
    5 ZGVZL, 5 LFKRJ => 9 QHLF
    14 JTBLB => 5 VRPJZ
    4 FWSK => 9 RXHC
    2 HRBG, 3 FCZQD => 8 DRLBG
    9 KLXC, 23 VBWCM, 44 VPTBL, 5 JRKB, 41 PFCGF, 4 WBCRL, 20 QNRZ, 28 SLZF => 1 FUEL
    1 DRLBG => 5 VPTBL
    13 LNRS => 7 ZNPNM
    3 WPGQN => 9 TJXB
    5 GFCGF, 3 HCQGN => 5 ZQGL
    1 KHXPM, 4 LMCSR, 1 QHLF, 4 WKMWF, 1 DGKW, 3 KBRM, 2 RNQRM => 4 KLXC
    171 ORE => 8 ZJGSJ
    3 ZJGSJ => 3 MXMQ
    124 ORE => 5 SLTF
    22 KHXPM, 10 FXDMQ => 6 KBRM
    2 FCZQD => 8 LMCSR
    7 DCKC, 8 HSDS, 7 PFCGF, 16 ZNPNM, 3 RNQRM, 3 WKMWF, 2 WBCRL, 14 RXHC => 7 JRKB
    7 DCKC, 2 MWSGQ => 3 BNFV
    2 ZQGL => 9 DGKW
    22 WRPWG => 6 HRBG
    22 KBJW, 1 KFBX, 1 THPCT => 6 WBCRL
    4 WRPWG, 1 RXHC, 21 FWSK => 8 QNRZ
    1 PTHDF => 8 GFCGF
    """
  }
}
