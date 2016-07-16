//
//  GrammarVariable.swift
//  Pods
//
//  Created by Mathias Quintero on 7/10/16.
//
//

import Foundation
/// Variable in a Grammar
public class GrammarVariable<T>: Resolvable, Equatable {
    
    let rules: Rules<T>
    
    /**
     Will instantiate a GrammarVariable
     
     - Returns: An empty GrammarVariable
    */
    public init() {
        rules = Rules<T>()
    }
    
    var id: String {
        get {
            return String(hashValue)
        }
    }
    
    var hashValue: Int {
        get {
            return Int(ObjectIdentifier(self).uintValue)
        }
    }
    
    /**
     Will add a Production Rule to the Variable. So that it may be translated into something else
     
     - Parameters:
     - regex: Expected input as a Regular Expression
     
     - Returns: A Rule Object to keep on modifying the Rule.
     */
    public func to(regex: String) -> Rule<T> {
        let rule = Rule<T>()
        rules.add(rule)
        return rule.and(regex)
    }
    
    /**
     Will add a Production Rule to the Variable. So that it may be translated into something else
     
     - Parameters:
     - variable: Other GrammarVariable it should resolve into.
     
     - Returns: A Rule Object to keep on modifying the Rule.
     */
    public func to(variable: GrammarVariable<T>) -> Rule<T> {
        let rule = Rule<T>()
        rules.add(rule)
        return rule.and(variable)
    }

}

/**
 Will Compare two Variables. Note: This is not the actual equality but only Identity Equality.
 This will not tell you if two Variables arrive at the same Language.
 
 - Parameters:
 - lhs: Left Variable
 - rhs: Right Variable
 
 - Returns: boolean value representing if both Variables are the exact same by comparing the Object ID.
 */
public func ==<T>(lhs: GrammarVariable<T>, rhs: GrammarVariable<T>) -> Bool {
    return lhs.hashValue == rhs.hashValue
}