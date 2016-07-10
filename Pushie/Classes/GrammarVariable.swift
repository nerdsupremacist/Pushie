//
//  GrammarVariable.swift
//  Pods
//
//  Created by Mathias Quintero on 7/10/16.
//
//

import Foundation
public class GrammarVariable<T>: Resolvable, Equatable {
    
    let rules: Rules<T>
    
    public init() {
        rules = Rules<T>()
    }
    
    var hashValue: Int {
        get {
            return Int(String(ObjectIdentifier(self).uintValue)) ?? 0
        }
    }
    
    func to(regex: String) -> Rule<T> {
        let rule = Rule<T>()
        return rule.and(regex)
    }
    
    func to(variable: GrammarVariable<T>) -> Rule<T> {
        let rule = Rule<T>()
        return rule.and(variable)
    }

}

public func ==<T>(lhs: GrammarVariable<T>, rhs: GrammarVariable<T>) -> Bool {
    return lhs.hashValue == rhs.hashValue
}