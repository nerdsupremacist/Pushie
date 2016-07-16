//
//  StackElement.swift
//  PDA
//
//  Created by Mathias Quintero on 7/8/16.
//  Copyright © 2016 Mathias Quintero. All rights reserved.
//

import Foundation
/// Stack Element Construct
public struct StackElement: Hashable {
    
    /// Identifier for the Element
    public let identifier: String
    
    /// Hash Value for using as keys in dictionaries.
    public var hashValue: Int {
        get {
            return identifier.hashValue
        }
    }
}

/**
 Will Compare to Stack Elements toghether
 
 - Parameters:
 - lhs: Left Element
 - rhs: Right Element
 
 - Returns: boolean value representing if both Elements are the same
 */
public func ==(lhs: StackElement, rhs: StackElement) -> Bool {
    return lhs.identifier == rhs.identifier
}