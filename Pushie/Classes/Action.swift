//
//  Action.swift
//  PDA
//
//  Created by Mathias Quintero on 7/8/16.
//  Copyright © 2016 Mathias Quintero. All rights reserved.
//

import Foundation
enum Action<T> {
    
    case Neutral
    case Pop
    case Push([StackElement])
    case Change(StackElement)
    
    func handle(stack: Stack) {
        switch self {
        case .Neutral: return;
        case .Pop: stack.pop()
        case .Push(let elements): stack.push(elements)
        case .Change(let element): stack.change(element)
        }
    }
    
}