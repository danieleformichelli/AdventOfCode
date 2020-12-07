//
//  Year2019Day14.swift
//  AdventOfCode2019
//
//  Created by Daniele Formichelli on 14/12/2019.
//  Copyright © 2019 Daniele Formichelli. All rights reserved.
//

import Utils

/// https://adventofcode.com/2019/day/14
struct Year2019Day14: DayBase {
  func part1(_ input: String) -> CustomDebugStringConvertible {
    Self.requiredORE(for: 1, reactions: input.reactions)
  }

  func part2(_ input: String) -> CustomDebugStringConvertible {
    let reactions = input.reactions

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
      return self.findMaxFuel(minimumFuel: minimumFuel, maximumFuel: midFuel - 1, availableORE: availableORE, reactions: reactions)
    } else {
      return self.findMaxFuel(minimumFuel: midFuel + 1, maximumFuel: maximumFuel, availableORE: availableORE, reactions: reactions)
    }
  }

  private static func requiredORE(for fuel: Int64, reactions: [String: Reaction]) -> Int64 {
    var requiredChemicals = ["FUEL": ChemicalAndQuantity(chemical: "FUEL", quantity: fuel)]
    var availableChemicals: [String: ChemicalAndQuantity] = [:]
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
          requiredOutputQuantity -= availableOutputQuantity
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

extension String {
  var reactions: [String: Year2019Day14.Reaction] {
    let reactions = lines.map { Year2019Day14.Reaction.from($0) }
    return Dictionary(uniqueKeysWithValues: reactions.map { ($0.output.chemical, $0) })
  }
}

extension Year2019Day14 {
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
