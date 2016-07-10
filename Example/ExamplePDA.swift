//
//  ExampleOne.swift
//  Pushie
//
//  Created by Mathias Quintero on 7/9/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import Pushie

func main() {
    let stateOne = State<Int>()
    let stateTwo = State<Int>()
    let stateThree = State<Int>(final: true)
    
    stateOne.when("Z").on("a").push("A").transform({ $1 + 1 })
    stateOne.when("Z").goTo(stateTwo)
    stateOne.when("A").on("a").push("A").transform({ $1 + 1 })
    stateOne.when("A").goTo(stateTwo)
    stateTwo.when("A").on("b").pop()
    stateTwo.when("Z").goTo(stateThree)
    
    let automat = Pushie(start: 0, state: stateOne)
    
    print(automat.handle("aabb"))
    print(automat.handle("aaabb"))
}