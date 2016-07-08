//
//  Accumulator.swift
//  PDA
//
//  Created by Mathias Quintero on 7/8/16.
//  Copyright © 2016 Mathias Quintero. All rights reserved.
//

import Foundation
class Accumulator<T> {
    
    var accumulatedString = ""
    var accumulatedObject: T
    
    init(startObject: T) {
        accumulatedObject = startObject
    }
    
    func deleteAccumulatedString() {
        accumulatedString = ""
    }
    
    func append(str: String) {
        accumulatedString = accumulatedString + str
    }
    
    func apply(handler: (String, T) -> (T)) {
        accumulatedObject = handler(accumulatedString, accumulatedObject)
    }
    
    func copy() -> Accumulator<T> {
        let copy = Accumulator(startObject: accumulatedObject)
        copy.accumulatedString = self.accumulatedString
        return copy
    }
    
}