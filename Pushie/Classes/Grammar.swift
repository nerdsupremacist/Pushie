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
    
    public func automata() -> Pushie<T>? {
        let reachable = ReachableManager.findAllReachableVariables(startVariable)
        return nil
    }
    
    
}