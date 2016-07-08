//
//  TransitionReason.swift
//  PDA
//
//  Created by Mathias Quintero on 7/8/16.
//  Copyright © 2016 Mathias Quintero. All rights reserved.
//

import Foundation
enum TransitionReason: Hashable {
    case Regex(String)
    case Epsilon

    var hashValue: Int {
        get {
            switch self {
            case .Regex(let str): return str.hashValue
            case .Epsilon(): return "".hashValue
            }
        }
    }

}

func ==(lhs: TransitionReason, rhs: TransitionReason) -> Bool {
    switch (lhs, rhs) {
    case (.Regex(let left), .Regex(let right)):
        return left == right
    case (.Epsilon, .Epsilon):
        return true
    default:
        return false
    }
}