//
//  PDA.swift
//  PDA
//
//  Created by Mathias Quintero on 7/8/16.
//  Copyright © 2016 Mathias Quintero. All rights reserved.
//

import Foundation
class Pushie<T> {
    
    var stack: Stack
    var state: State<T>?
    var start: T
    
    init(start: T, state: State<T>? = nil, firstStackElement: StackElement? = nil) {
        self.start = start
        self.state = state
        self.stack = Stack()
        if let firstStackElement = firstStackElement {
            stack.push(firstStackElement)
        }
    }
    
    func handle(input: String) -> T? {
        return state?.handleInput(input, stack: stack, accumulator: Accumulator(startObject: start))
    }
    
}