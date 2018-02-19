//
//  ViewController.swift
//  Concentration
//
//  Created by Adam O'Leary on 2/15/18.
//  Copyright © 2018 Adam O'Leary. All rights reserved.
//

import UIKit

class ViewController: UIViewController { //class classname: superclass
    
    lazy var game = Concentration(numberOfCardPairs: (cardButtons.count+1)/2)
    
    var emojiChoices = ["😡","😇","😜","😍","😘","😯","😂","😱"]
    
    let topColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
    let bottomColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
    
    var flipCount = 0 {
        didSet{
            flipCountLabel.text = "Flip Count: \(flipCount)"
        }
    }
    
    var flipCount2: String {
        get {
            return String(flipCount)
        }
        set {
            flipCount = Int(newValue)!
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]! //[] indecates array of UIButtons
    
    override func viewDidLoad(){
        
        flipCount2 = "0"
        
        super.viewDidLoad()
        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        let gradientLocations: [NSNumber] = [0.0, 1.0]
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations
        
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        if sender.backgroundColor != #colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 0), sender.backgroundColor != #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
        else{
            print("Chosen card not in cardButtons")
        }
        }
    }
    
    @IBOutlet weak var newGameButton: UIButton!
    
    @IBAction func newGameButtonPressed(_ sender: UIButton) {
        game = Concentration(numberOfCardPairs: (cardButtons.count + 1) / 2)
        flipCount = 0
        for button in cardButtons{
            button.backgroundColor = #colorLiteral(red: 0.7174234986, green: 0.7163253427, blue: 1, alpha: 0.5412632042)
            button.setTitle("", for: UIControlState.normal)
        }
        for index in cardButtons.indices{
            var card = game.cards[index]
            card.isFaceUp = false
            card.isMatched = false
        }
        emojiChoices = ["😡","😇","😜","😍","😘","😯","😂","😱"]
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 0.5716329225)
            } else {
                button.setTitle("", for: UIControlState.normal)
                
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 0) : #colorLiteral(red: 0.7174234986, green: 0.7163253427, blue: 1, alpha: 0.5412632042)
                
            }
        }
    }
    
    
    
    var emoji = [Int:String]()
    
    func emoji(for card : Card) -> String {
        
        if emoji[card.id] == nil, emojiChoices.count > 0 {
            
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.id] = emojiChoices.remove(at: randomIndex)
        }
     
    return emoji[card.id] ?? "?" //if not nill return emoji else return "?"
    
}
    
}
