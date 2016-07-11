//
//  RequestMaker.swift
//  PDA
//
//  Created by Mathias Quintero on 7/8/16.
//  Copyright © 2016 Mathias Quintero. All rights reserved.
//

import Foundation
public class TransitionMaker<T> {
    
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
    
    public func on(string: String) -> TransitionMaker<T> {
        manager.dict[currentReason] = nil
        currentReason = TransitionReason.Regex(string)
        manager.dict[currentReason] = currentTransition
        return self
    }
    
    public func push(element: StackElement) -> TransitionMaker<T> {
        return push([element])
    }
    
    public func push(element: String) -> TransitionMaker<T> {
        return push(StackElement(identifier: element))
    }
    
    public func push(elements: [StackElement]) -> TransitionMaker<T> {
        currentTransition = Transition(action: .Push(elements), nextState: currentTransition.nextState, handler: currentTransition.handler, deletes: currentTransition.deletes)
        manager.dict[currentReason] = currentTransition
        return self
    }
    
    public func push(elements: [String]) -> TransitionMaker<T> {
        let newElements = elements.map({ StackElement(identifier: $0) })
        return push(newElements)
    }
    
    public func pop() -> TransitionMaker<T> {
        currentTransition = Transition(action: .Pop, nextState: currentTransition.nextState, handler: currentTransition.handler, deletes: currentTransition.deletes)
        manager.dict[currentReason] = currentTransition
        return self
    }
    
    public func change(element: StackElement) -> TransitionMaker<T> {
        currentTransition = Transition(action: .Change(element), nextState: currentTransition.nextState, handler: currentTransition.handler, deletes: currentTransition.deletes)
        manager.dict[currentReason] = currentTransition
        return self
    }
    
    public func change(element: String) -> TransitionMaker<T> {
        return change(StackElement(identifier: element))
    }
    
    public func goTo(state: State<T>) -> TransitionMaker<T> {
        currentTransition = Transition(action: currentTransition.action, nextState: state, handler: currentTransition.handler, deletes: currentTransition.deletes)
        manager.dict[currentReason] = currentTransition
        return self
    }
    
    public func transform(handler: (String, T) -> T) -> TransitionMaker<T> {
        currentTransition = Transition(action: currentTransition.action, nextState: currentTransition.nextState, handler: handler, deletes: currentTransition.deletes)
        manager.dict[currentReason] = currentTransition
        return self
    }
    
}