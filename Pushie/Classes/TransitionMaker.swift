//
//  RequestMaker.swift
//  PDA
//
//  Created by Mathias Quintero on 7/8/16.
//  Copyright © 2016 Mathias Quintero. All rights reserved.
//

import Foundation
/// Will create Transitions on the fly.
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
    
    /**
     Change the regular expression it should accept
     
     - Parameters:
     - string: regular Expression it should accept
     
     - Returns: A Transition Manager to keep editing the transition.
     */
    public func on(string: String) -> TransitionMaker<T> {
        manager.dict[currentReason] = nil
        currentReason = TransitionReason.Regex(string)
        manager.dict[currentReason] = currentTransition
        return self
    }
    
    /**
     Change the action of the transition to push a single Element onto the Stack
     
     - Parameters:
     - element: Stack Element it should push
     
     - Returns: A Transition Manager to keep editing the transition.
     */
    public func push(element: StackElement) -> TransitionMaker<T> {
        return push([element])
    }
    
    /**
     Change the action of the transition to push a single Element onto the Stack
     
     - Parameters:
     - element: Stack Element it should push as a String
     
     - Returns: A Transition Manager to keep editing the transition.
     */
    public func push(element: String) -> TransitionMaker<T> {
        return push(StackElement(identifier: element))
    }
    
    /**
     Change the action of the transition to push an array Element onto the Stack
     
     - Parameters:
     - element: array of elements it should push
     
     - Returns: A Transition Manager to keep editing the transition.
     */
    public func push(elements: [StackElement]) -> TransitionMaker<T> {
        currentTransition = Transition(action: .Push(elements), nextState: currentTransition.nextState, handler: currentTransition.handler, deletes: currentTransition.deletes)
        manager.dict[currentReason] = currentTransition
        return self
    }
    
    /**
     Change the action of the transition to push an array Element onto the Stack
     
     - Parameters:
     - element: array of elements it should push (as Strings)
     
     - Returns: A Transition Manager to keep editing the transition.
     */
    public func push(elements: [String]) -> TransitionMaker<T> {
        let newElements = elements.map({ StackElement(identifier: $0) })
        return push(newElements)
    }
    
    /**
     Change the action of the transition to pop something off the Stack.
     
     - Returns: A Transition Manager to keep editing the transition.
     */
    public func pop() -> TransitionMaker<T> {
        currentTransition = Transition(action: .Pop, nextState: currentTransition.nextState, handler: currentTransition.handler, deletes: currentTransition.deletes)
        manager.dict[currentReason] = currentTransition
        return self
    }
    
    /**
     Change the action of the transition change what's on top of the Stack with a single Element.
     
     - Parameters:
     - element: Element it should replace the top of the Stack with
     
     - Returns: A Transition Manager to keep editing the transition.
     */
    public func change(element: StackElement) -> TransitionMaker<T> {
        currentTransition = Transition(action: .Change([element]), nextState: currentTransition.nextState, handler: currentTransition.handler, deletes: currentTransition.deletes)
        manager.dict[currentReason] = currentTransition
        return self
    }
    
    
    /**
     Change the action of the transition change what's on top of the Stack with an array of Elements.
     
     - Parameters:
     - element: array of Elements if should replace the top of the Stack with (as Strings).
     
     - Returns: A Transition Manager to keep editing the transition.
     */
    public func change(elements: [String]) -> TransitionMaker<T> {
        return change(elements.map({ StackElement(identifier: $0) }))
    }
    
    /**
     Change the action of the transition change what's on top of the Stack with an array of Elements.
     
     - Parameters:
     - elements: array of Elements if should replace the top of the Stack with.
     
     - Returns: A Transition Manager to keep editing the transition.
     */
    public func change(elements: [StackElement]) -> TransitionMaker<T> {
        currentTransition = Transition(action: .Change(elements), nextState: currentTransition.nextState, handler: currentTransition.handler, deletes: currentTransition.deletes)
        manager.dict[currentReason] = currentTransition
        return self
    }
    
    /**
     Change the action of the transition change what's on top of the Stack with a single Element.
     
     - Parameters:
     - element: Element it should replace the top of the Stack with as String
     
     - Returns: A Transition Manager to keep editing the transition.
     */
    public func change(element: String) -> TransitionMaker<T> {
        return change(StackElement(identifier: element))
    }
    
    /**
     Change the destination State after the Transition
     
     - Parameters:
     - state: state if should go to after the transition is complete.
     
     - Returns: A Transition Manager to keep editing the transition.
     */
    public func goTo(state: State<T>) -> TransitionMaker<T> {
        currentTransition = Transition(action: currentTransition.action, nextState: state, handler: currentTransition.handler, deletes: currentTransition.deletes)
        manager.dict[currentReason] = currentTransition
        return self
    }
    
    /**
     Will set a transform function to the production that should take
     the string of the input read so far and the Accumulator and return the new Accumulator
     
     - Parameters:
     - handler: transform function
     
     - Returns: A Transition Manager to keep editing the transition.
     */
    public func transform(handler: (String, T) -> T) -> TransitionMaker<T> {
        currentTransition = Transition(action: currentTransition.action, nextState: currentTransition.nextState, handler: handler, deletes: currentTransition.deletes)
        manager.dict[currentReason] = currentTransition
        return self
    }
    
}