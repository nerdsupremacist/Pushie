//
//  StackElement.swift
//  PDA
//
//  Created by Mathias Quintero on 7/8/16.
//  Copyright © 2016 Mathias Quintero. All rights reserved.
//

import Foundation
public struct StackElement: Hashable {
    let identifier: String
    
    public var hashValue: Int {
        get {
            return identifier.hashValue
        }
    }
}

public func ==(lhs: StackElement, rhs: StackElement) -> Bool {
    return lhs.identifier == rhs.identifier
}