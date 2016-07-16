//
//  Grammar.swift
//  Pods
//
//  Created by Mathias Quintero on 7/10/16.
//
//

import Foundation

/// Full Grammar. Consists of a starting Variable
public class Grammar<T> {
    
    /// Starting Variable. This is where you words will be parsed first.
    let startVariable: GrammarVariable<T>
    
    /**
     Initializes a new Grammar.
     
     - Parameters:
     - startVariable: Starting Variable for your Grammar.
     
     - Returns: An awesome Grammar. Obviously!. ;)
     */
    public init(startVariable: GrammarVariable<T>) {
        self.startVariable = startVariable
    }
    
    /**
     Will translate the Grammar into a PDA
     
     - Parameters:
     - start: First Object assigned to the Accumulator of your PDA
     
     - Returns: PDA accepting the Language of the Grammar.
     */
    public func automata(start: T) -> Pushie<T>? {
        let state = State<T>()
        let finalState = State<T>(final: true)
        let finalElement = StackElement(identifier: "final")
        var alreadyReachable = [startVariable]
        var index = 0
        var variablesWithEpsilon = [GrammarVariable<T>]()
        while index < alreadyReachable.count {
            for rule in alreadyReachable[index].rules.rules {
                if let (h, tail) = rule.resolvesTo.match {
                    if let head = h as? Regex {
                        if head.expression != "" {
                            state.when(String(alreadyReachable[index].hashValue)).on(head.expression).change(tail.map({ $0.id }).reverse())
                        }
                    } else {
                        state.when(String(alreadyReachable[index].hashValue)).change(rule.resolvesTo.map({ $0.id }).reverse())
                    }
                }
                let regex = rule.resolvesTo.flatMap({ $0 as? Regex })
                for reg in regex {
                    if reg.expression != "" {
                        state.when(reg.expression).on(reg.expression).pop()
                    } else {
                        variablesWithEpsilon.append(alreadyReachable[index])
                    }
                }
            }
            let reachableFromCurrent = alreadyReachable[index].rules.rules.flatMap({ $0.resolvesTo.flatMap({ $0 as? GrammarVariable<T> })})
            let reachableUnknown = reachableFromCurrent.filter({ !alreadyReachable.contains($0) })
            alreadyReachable.appendContentsOf(reachableUnknown)
            index += 1
        }
        for variable in variablesWithEpsilon {
            state.when(String(variable.hashValue)).pop()
        }
        state.when(finalElement).goTo(finalState)
        let result = Pushie(start: start, state: state, firstStackElement: finalElement)
        result.stack.push([StackElement(identifier: startVariable.id)])
        return result
    }
    
    /**
     Will calculate the result of an input
     
     - Parameters:
     - start: Start value of the Accumulator
     - input: Input that has to be evaluated
     
     - Returns: nil when the input is invalid. Result of the evaluation when it's valid.
     */
    public func handle(start: T, input: String) -> T? {
        return automata(start)?.handle(input)
    }
    
}