//
//  ReachableManager.swift
//  Pods
//
//  Created by Mathias Quintero on 7/10/16.
//
//

import Foundation
class ReachableManager<T> {
    
    class func findAllReachableVariables(startVariable: GrammarVariable<T>) -> [GrammarVariable<T>] {
        var alreadyReachable = [startVariable]
        var index = 0
        while index < alreadyReachable.count {
            let reachableFromCurrent = alreadyReachable[index].rules.rules.flatMap({ $0.resolvesTo.flatMap({ $0 as? GrammarVariable<T> })})
            let reachableUnknown = reachableFromCurrent.filter({ !alreadyReachable.contains($0) })
            alreadyReachable.appendContentsOf(reachableUnknown)
            index += 1
        }
        return alreadyReachable
    }
    
}