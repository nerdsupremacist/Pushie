//
//  Rule.swift
//  Pods
//
//  Created by Mathias Quintero on 7/10/16.
//
//

import Foundation
public class Rule<T> {
    
    var resolvesTo = [Resolvable]()
    var handler: ((String, T) -> T)?
    
    public func and(variable: GrammarVariable<T>) -> Rule<T> {
        resolvesTo.append(variable)
        return self
    }
    
    public func and(regex: String) -> Rule<T> {
        resolvesTo.append(Regex(expression: regex))
        return self
    }
    
    public func transform(handler: (String, T) -> T) -> Rule<T> {
        self.handler = handler
        return self
    }
    
}