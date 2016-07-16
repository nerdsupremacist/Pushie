//
//  Rule.swift
//  Pods
//
//  Created by Mathias Quintero on 7/10/16.
//
//

import Foundation

/// Rule defining a possible way in which a Variable resolves into other Variables or Regular Expressions.
public class Rule<T> {
    
    var resolvesTo = [Resolvable]()
    var handler: ((String, T) -> T)?
    
    /**
     Will concatenate a Variable at the end of the production.
     
     - Parameters:
     - variable: Other GrammarVariable it should resolve into.
     
     - Returns: A Rule Object to keep on modifying the Rule.
     */
    public func and(variable: GrammarVariable<T>) -> Rule<T> {
        resolvesTo.append(variable)
        return self
    }
    
    /**
     Will concatenate a Regular Expression at the end of the production.
     
     - Parameters:
     - regex: Expected input as a Regular Expression
     
     - Returns: A Rule Object to keep on modifying the Rule.
     */
    public func and(regex: String) -> Rule<T> {
        resolvesTo.append(Regex(expression: regex))
        return self
    }
    
    /**
     Will set a transform function to the production that should take 
     the string of the input read so far and the Accumulator and return the new Accumulator
     
     - Parameters:
     - handler: transform function
     
     - Returns: A Rule Object to keep on modifying the Rule.
     */
    public func transform(handler: (String, T) -> T) -> Rule<T> {
        self.handler = handler
        return self
    }
    
}