//
//  Grammar.swift
//  Pods
//
//  Created by Mathias Quintero on 7/10/16.
//
//

import Foundation
public class Grammar<T> {
    
    let startVariable: GrammarVariable<T>
    
    public init(startVariable: GrammarVariable<T>) {
        self.startVariable = startVariable
    }
    
    public func automata(start: T) -> Pushie<T>? {
        let state = State<T>()
        let finalState = State<T>(final: true)
        let finalElement = StackElement(identifier: startVariable.id)
        var alreadyReachable = [startVariable]
        var index = 0
        while index < alreadyReachable.count {
            for rule in alreadyReachable[index].rules.rules {
                if let (h, tail) = rule.resolvesTo.match {
                    if let head = h as? Regex {
                        state.when(String(alreadyReachable[index].hashValue)).on(head.expression).push(tail.map({ $0.id }))
                    } else {
                        state.when(String(alreadyReachable[index].hashValue)).push(rule.resolvesTo.map({ $0.id }))
                    }
                }
                let regex = rule.resolvesTo.flatMap({ $0 as? Regex })
                for reg in regex {
                    state.when(reg.expression).on(reg.expression).pop()
                }
            }
            let reachableFromCurrent = alreadyReachable[index].rules.rules.flatMap({ $0.resolvesTo.flatMap({ $0 as? GrammarVariable<T> })})
            let reachableUnknown = reachableFromCurrent.filter({ !alreadyReachable.contains($0) })
            alreadyReachable.appendContentsOf(reachableUnknown)
            index += 1
        }
        state.when(finalElement).goTo(finalState)
        return Pushie(start: start, state: state, firstStackElement: finalElement)
    }
    
}