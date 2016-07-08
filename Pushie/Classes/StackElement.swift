//
//  StackElement.swift
//  PDA
//
//  Created by Mathias Quintero on 7/8/16.
//  Copyright © 2016 Mathias Quintero. All rights reserved.
//

import Foundation
struct StackElement: Hashable {
    let identifier: String
    
    var hashValue: Int {
        get {
            return identifier.hashValue
        }
    }
}

func ==(lhs: StackElement, rhs: StackElement) -> Bool {
    return lhs.identifier == rhs.identifier
}