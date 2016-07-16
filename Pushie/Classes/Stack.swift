//
//  Stack.swift
//  PDA
//
//  Created by Mathias Quintero on 7/8/16.
//  Copyright © 2016 Mathias Quintero. All rights reserved.
//

import Foundation
public class Stack {
    
    var stack = [StackElement]()
    
    init(stack: [StackElement] = []) {
        self.stack = stack
    }
    
    var last: StackElement? {
        get {
            return stack.last
        }
    }
    
    func pop() {
        stack.removeLast()
    }
    
    func push(elements: [StackElement]) {
        stack.appendContentsOf(elements)
    }
    
    func push(elements: [String]) {
        let newElements = elements.map({ StackElement(identifier: $0) })
        push(newElements)
    }
    
    func change(elements: [StackElement]) {
        pop()
        push(elements)
    }
    
    func change(elements: [String]) {
        pop()
        push(elements)
    }
    
    func copy() -> Stack {
        let new = stack.flatMap({ $0 })
        return Stack(stack: new)
    }
    
}