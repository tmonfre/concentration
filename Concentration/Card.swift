//
//  Card.swift
//  Concentration
//
//  Created by Thomas Monfre on 6/2/18.
//  Copyright © 2018 Thomas Monfre. All rights reserved.
//

import Foundation

// struct for individual Card objects
struct Card {
    
    // visual instance variable for being face up and being matched
    var isFaceUp = false
    var isMatched = false
    
    // individual and unique identifier of each object
    var identifier : Int
    
    // instantiate by passing and storing the unique identifier
    init(identifier : Int) {
        self.identifier = identifier
    }
    
}
