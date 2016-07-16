//
//  PDA.swift
//  PDA
//
//  Created by Mathias Quintero on 7/8/16.
//  Copyright © 2016 Mathias Quintero. All rights reserved.
//

import Foundation
/// PDA Objects
public class Pushie<T> {
    
    var stack: Stack
    var state: State<T>?
    var start: T
    
    /**
     Will instantiate a PDA
     
     - Parameters:
     - start: first value for the Accumulator
     - state: first State in the PDA (Optional)
     - firstStackElement: firs Element that should be on the Stack. (Optional)
     
     - Returns: A beautiful PDA. Ready for calculation.
     */
    public init(start: T, state: State<T>? = nil, firstStackElement: StackElement? = nil) {
        self.start = start
        self.state = state
        self.stack = Stack()
        if let firstStackElement = firstStackElement {
            stack.push([firstStackElement])
        }
    }
    
    /**
     Will instantiate a PDA
     
     - Parameters:
     - start: first value for the Accumulator
     - state: first State in the PDA (Optional)
     - firstStackElementAsString: firs Element that should be on the Stack. (Optional)
     
     - Returns: A beautiful PDA. Ready for calculation.
     */
    public convenience init(start: T, state: State<T>? = nil, firstStackElementAsString: String? = nil) {
        if let element = firstStackElementAsString {
            self.init(start: start, state: state, firstStackElement: StackElement(identifier: element))
        } else {
            self.init(start: start, state: state, firstStackElement: nil)
        }
    }
    
    /**
     Will calculate the result of an input
     
     - Parameters:
     - input: Input that has to be evaluated
     
     - Returns: nil when the input is invalid. Result of the evaluation when it's valid.
     */
    public func handle(input: String) -> T? {
        return state?.handleInput(input, stack: stack, accumulator: Accumulator(startObject: start))
    }
    
}