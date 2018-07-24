//
//  ViewController.swift
//  Concentration
//
//  Created by Thomas Monfre on 5/28/18.
//  Copyright © 2018 Thomas Monfre. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // instantiate a Concentration object to run the game
    var game = Concentration(numberOfPairsOfCards: 0)
    
    // once the view loads, create a game with the proper number of pairs of cards
    override func viewDidLoad() {
        createNewGame(isFirstGame: true)
    }
    
    // outlet collection of button objects on the UI
    @IBOutlet var cards: [UIButton]!
    
    // label counting how many times the user flipped a card
    @IBOutlet weak var flipCounter: UILabel!
    
    // integer count of user flips -- on each increment, update flipCounter label text
    var flipCount = 0.0 {
        didSet {
            flipCounter.text = "Flips: \(Int(flipCount))"
        }
    }
    
    // callback function for user clicking a card
    @IBAction func clickCard(_ sender: UIButton) {
        flipCount += 1.0
        
        // if the user selected a card in the collection, call that card's chooseCard method and update view
        if let cardNum = cards.index(of: sender) {
            game.chooseCard(at: cardNum)
            updateViewFromModel()
        }
        else {
            print("chosen card not in array of cards")
        }
    }
    
    // update the visual characteristics of the buttons in the view
    func updateViewFromModel() {
        for index in cards.indices {
            let button = cards[index]
            let card = game.cards[index]

            // set colors and titles
            if card.isFaceUp {
                button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                button.setTitle(getEmoji(for: card), for: UIControlState.normal)
            }
            else {
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 0) : #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
                button.setTitle("", for: UIControlState.normal)
            }
        }
        
        // reset the game if all cards are matched
        if checkAllCardsMatched() {
            newGameButton.setTitle("Press to Restart", for: UIControlState.normal)
            view.bringSubview(toFront: newGameButton)
            
            // make sure all cards are transparent
            for index in cards.indices {
                let button = cards[index]
                button.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 0)
                button.setTitle("", for: UIControlState.normal)
            }
        }
    }
    
    // collection of emojis that could be used
    var emojiOptions = Array<String>()
    
    // dictionary of card identifiers (key) and their emojis (value)
    var emoji = Dictionary<Int,String>()

    // grab this given Card's emoji from the dictionary
    func getEmoji(for card : Card) -> String {
        // if not in the dictionary, add it
        if emoji[card.identifier] == nil && emojiOptions.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiOptions.count)))
            emoji[card.identifier] = emojiOptions.remove(at: randomIndex)
        }
        
        // return what is in the dictionary or a question mark if emoji list not long enough
        return emoji[card.identifier] ?? "?"
    }
    
    // button that appears to prompt a new game
    @IBOutlet weak var newGameButton: UIButton!
    
    // instantiate and reset instance variables for a new game
    func createNewGame(isFirstGame: Bool) {
        game = Concentration(numberOfPairsOfCards: cards.count / 2)
        
        if !isFirstGame {
            updateTopScore()
        }

        flipCount = 0
        emojiOptions = ["👩‍💻", "🏈", "🎧", "🤠", "👽", "⛑", "🐶", "⚡️", "🍩", "🚲", "🚤", "⌚️", "🔓", "🗂", "📬", "💵", "🔦", "☎️", "🌇", "🏔", "🗽", "🏰", "🌠", "🎢"]
        newGameButton.setTitle("", for: UIControlState.normal)
        updateViewFromModel()
        
        for card in cards {
            view.bringSubview(toFront: card)
        }

    }
    
    // callback function from new game button -- calls createNewGame
    @IBAction func startNewGame() {
        createNewGame(isFirstGame: false)
    }
    
    // check if all the cards are matched
    func checkAllCardsMatched() -> Bool {
        var allMatched = true
        
        for card in game.cards {
            if !card.isMatched {
                allMatched = false
            }
        }
        return allMatched
    }
    
    // label showing current top score
    @IBOutlet weak var topScoreCounter: UILabel!
    
    // current top score in the game -- initialize to inf
    var topScore = Double.infinity {
        didSet{
            topScoreCounter.text = "Top Score: \(Int(topScore))"
        }
    }
    
    // update the top score by checking the current top score with the flip count
    func updateTopScore() {
        if flipCount < topScore {
            topScore = flipCount
        }
    }
    
}
