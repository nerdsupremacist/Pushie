//
//  Rules.swift
//  Pods
//
//  Created by Mathias Quintero on 7/10/16.
//
//

import Foundation
class Rules<T> {
    
    var rules = [Rule<T>]()
    
    func add(rule: Rule<T>) {
        rules.append(rule)
    }
    
}