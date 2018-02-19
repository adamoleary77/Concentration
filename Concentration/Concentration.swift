//
//  Concentration.swift
//  Concentration
//
//  Created by Adam O'Leary on 2/17/18.
//  Copyright © 2018 Adam O'Leary. All rights reserved.
//

import Foundation
import GameplayKit.GKRandomSource

class Concentration{
    
    var cards = [Card]()
    
    var shuffledTemp = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard: Int? //optional bc it will have the index
                                          //only if there is one face up card
                                          //otherwise is nill
    let topColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    let bottomColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
    
    func chooseCard(at index: Int){
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].id == cards[index].id {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfCardPairs: Int) {
        
        for _ in 1...numberOfCardPairs {
        let card = Card()
        cards.append(card) //actually creates cop of the card
        cards.append(card) //again
                            //cards += [card, card] also works
        }
        
        for i in 0..<cards.count
        {
            let rand = Int(arc4random_uniform(UInt32(cards.count)))
            shuffledTemp.append(cards[rand])
            cards.remove(at: rand)
            
            cards.append(shuffledTemp[i])
        }
    }
    
}






