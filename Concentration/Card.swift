//
//  Card.swift
//  Concentration
//
//  Created by Adam O'Leary on 2/17/18.
//  Copyright © 2018 Adam O'Leary. All rights reserved.
//

import Foundation

struct Card
{
    var isFaceUp = false
    var isMatched = false
    var id: Int
    
    static var idFactory = 0
    
    static func getUniqueId() -> Int{
        idFactory += 1
        return idFactory
    }
    
    init() {
        self.id = Card.getUniqueId()
    }
    
}
