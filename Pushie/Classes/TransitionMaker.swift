//
//  RequestMaker.swift
//  PDA
//
//  Created by Mathias Quintero on 7/8/16.
//  Copyright © 2016 Mathias Quintero. All rights reserved.
//

import Foundation
class TransitionMaker<T> {
    
    let state: State<T>
    var manager: TransitionManager<T>
    var currentTransition: Transition<T>
    var currentReason: TransitionReason
    
    init(state: State<T>, manager: TransitionManager<T>) {
        self.state = state
        self.currentTransition = Transition()
        self.manager = manager
        self.currentReason = .Epsilon
    }
    
    func on(string: String) -> TransitionMaker<T> {
        manager.dict[currentReason] = nil
        currentReason = TransitionReason.Regex(string)
        manager.dict[currentReason] = currentTransition
        return self
    }
    
    func push(element: StackElement) -> TransitionMaker<T> {
        currentTransition = Transition(action: .Push(element), nextState: currentTransition.nextState, handler: currentTransition.handler, deletes: currentTransition.deletes)
        manager.dict[currentReason] = currentTransition
        return self
    }
    
    func pop() -> TransitionMaker<T> {
        currentTransition = Transition(action: .Pop, nextState: currentTransition.nextState, handler: currentTransition.handler, deletes: currentTransition.deletes)
        manager.dict[currentReason] = currentTransition
        return self
    }
    
    func change(element: StackElement) -> TransitionMaker<T> {
        currentTransition = Transition(action: .Change(element), nextState: currentTransition.nextState, handler: currentTransition.handler, deletes: currentTransition.deletes)
        manager.dict[currentReason] = currentTransition
        return self
    }
    
    func goTo(state: State<T>) -> TransitionMaker<T> {
        currentTransition = Transition(action: currentTransition.action, nextState: state, handler: currentTransition.handler, deletes: currentTransition.deletes)
        manager.dict[currentReason] = currentTransition
        return self
    }
    
    func transform(handler: (String, T) -> T) -> TransitionMaker<T> {
        currentTransition = Transition(action: currentTransition.action, nextState: currentTransition.nextState, handler: handler, deletes: currentTransition.deletes)
        manager.dict[currentReason] = currentTransition
        return self
    }
    
}