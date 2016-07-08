//
//  Transition.swift
//  PDA
//
//  Created by Mathias Quintero on 7/8/16.
//  Copyright © 2016 Mathias Quintero. All rights reserved.
//

import Foundation
class Transition<T> {
    
    let action: Action<T>
    let deletes: Bool
    let nextState: State<T>?
    let handler: ((String, T) -> (T))?
    
    init(action: Action<T> = .Neutral, nextState: State<T>? = nil, handler: ((String, T) -> (T))? = nil, deletes: Bool = false) {
        self.action = action
        self.nextState = nextState
        self.handler = handler
        self.deletes = deletes
    }
    
    func handle(stack: Stack, accumulator: Accumulator<T>) -> State<T>? {
        action.handle(stack)
        if let handler = handler {
            accumulator.apply(handler)
        }
        if deletes {
            accumulator.deleteAccumulatedString()
        }
        return nextState
    }
    
}