//
//  Concentration.swift
//  Concentration
//
//  Created by Thomas Monfre on 6/2/18.
//  Copyright © 2018 Thomas Monfre. All rights reserved.
//

import Foundation

// underlying model of gameplay for Concentration
class Concentration {
    
    // collection of Card objects -- associated with cards on the View
    var cards = [Card]()
    
    // if a singular card is face up on the screen, hold onto its index in the collection of Cards
    var indexOfOnlyFaceUpCard : Int?
    
    // static variable and method to grab and store unique identifiers for the Card objects
    static var currIdentifier = 0
    static func getUniqueIdentifier() -> Int {
        currIdentifier += 1
        return currIdentifier
    }

    // constructor method to initialize the class
    init(numberOfPairsOfCards : Int) {
        
        // loop over each card in the collection (so long as it is full) and create Card objects
        if numberOfPairsOfCards > 0 {
            for _ in 0..<numberOfPairsOfCards {
                let card = Card(identifier : Concentration.getUniqueIdentifier())
                cards.append(card)
                cards.append(card)
            }
            
            // shuffle the cards
            for index in cards.indices {
                let otherIndex = Int(arc4random_uniform(UInt32(cards.count)))
                let temp = cards[index]
                cards[index] = cards[otherIndex]
                cards[otherIndex] = temp
            }
        }
    }

    // method called when a user clicks on a button associated with a Card
    // check for matches and deem whether or not cards should be face up or face down
    func chooseCard(at index: Int) {
        
        if !cards[index].isMatched {
            if let matchIndex = indexOfOnlyFaceUpCard, matchIndex != index {
                
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOnlyFaceUpCard = nil
            }
                
            else {
                // either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOnlyFaceUpCard = index
                
            }
        }
    }
}
