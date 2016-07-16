//
//  ExampleCFG.swift
//  Pushie
//
//  Created by Mathias Quintero on 7/16/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import Pushie

func main() {
    let A = GrammarVariable<Int>()
    A.to("0").and(A).and("1")
    A.to("")
    
    let grammar = Grammar(A)
    
    let automata = grammar.automata(0)
    
    print(automata.handle("0011"))
    print(automata.handle("00011"))    
}

main()