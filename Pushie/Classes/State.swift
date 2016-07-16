//
//  State.swift
//  PDA
//
//  Created by Mathias Quintero on 7/8/16.
//  Copyright © 2016 Mathias Quintero. All rights reserved.
//

import Foundation
/// State in PDA
public class State<T> {
    
    let final: Bool
    
    var transitions: [StackElement:TransitionManager<T>]
    
    var id: String {
        get {
            return String(ObjectIdentifier(self).uintValue)
        }
    }

    private init(transitions: [StackElement:TransitionManager<T>] = [:], final: Bool = false) {
        self.transitions = transitions
        self.final = final
    }
    
    
    /**
     Will instantiate a PDA-State
     
     - Parameters:
     - final: is it a final State (Optional)
     
     - Returns: A beautiful PDA. Ready for calculation.
     */
    public init(final: Bool = false) {
        self.transitions = [:]
        self.final = final
    }
    
    func handleInput(input: String, stack: Stack, accumulator: Accumulator<T>) -> T? {
        if input.isEmpty && final {
            return accumulator.accumulatedObject
        }
        if let element = stack.last, transitionsForState = transitions[element]?.dict {
            let nextOptions = transitionsForState.filter() { (reason, transition) in
                switch reason {
                case .Regex(let str):
                    let range = input.rangeOfString(str, options: .RegularExpressionSearch)
                    if let index = range?.startIndex {
                        return index == input.startIndex
                    }
                    return false
                default:
                    return true
                }
            }
            for option in nextOptions {
                switch option.0 {
                case .Regex(let expr):
                    let ranges = input.matchesForRegexAtStart(for: expr)
                    for range in ranges {
                        let text = input.stringByReplacingCharactersInRange(input.rangeFromNSRange(range)!, withString: "")
                        let copy = accumulator.copy()
                        copy.append(input.substringWithRange(input.rangeFromNSRange(range)!))
                        let newStack = stack.copy()
                        let state = option.1.handle(newStack, accumulator: copy) ?? self
                        if let result = state.handleInput(text, stack: newStack, accumulator: copy) {
                            return result
                        }
                    }
                default:
                    let copy = accumulator.copy()
                    let newStack = stack.copy()
                    let state = option.1.handle(newStack, accumulator: copy) ?? self
                    if let result = state.handleInput(input, stack: newStack, accumulator: copy) {
                        return result
                    }
                }
            }
        }
        return nil
    }
    
    /**
     Will create a new Transition for a specific Stack Element
     
     - Parameters:
     - element: Stack Element as String
     
     - Returns: A Transition Manager to keep editing the transition.
     */
    public func when(element: String) -> TransitionMaker<T> {
        let stackElement = StackElement(identifier: element)
        return when(stackElement)
    }
    
    /**
     Will create a new Transition for a specific Stack Element
     
     - Parameters:
     - element: Stack Element
     
     - Returns: A Transition Manager to keep editing the transition.
     */
    public func when(element: StackElement) -> TransitionMaker<T> {
        let dict = transitions[element] ?? TransitionManager()
        transitions[element] = dict
        return TransitionMaker(state: self, manager: dict)
    }
    
}