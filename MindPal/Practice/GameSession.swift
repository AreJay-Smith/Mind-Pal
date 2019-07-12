//
//  GameSession.swift
//  MindPal
//
//  Created by Randall Smith on 7/9/19.
//  Copyright © 2019 Randall Smith. All rights reserved.
//

import Foundation

class GameSession {
    
    var allCards = ["2C","3C","4C","5C","6C","7C","8C","9C","10C","JC","QC","KC","AC","2S","3S","4S","5S","6S","7S","8S","9S","10S","JS","QS","KS","AS","2H","3H","4H","5H","6H","7H","8H","9H","10H","JH","QH","KH","AH","2D","3D","4D","5D","6D","7D","8D","9D","10D","JD","QD","KD","AD"]
    var selectedCards: Array<String> = []
    var currentCardIndex = 0
    
    init(_ numCards: Int) {
        generateSelectedList(with: numCards)
    }
    
    func generateSelectedList(with numCards: Int) {
        if (numCards != 0) {
        for _ in 1...numCards {
            let randomCardNumber = Int.random(in: 0...allCards.count)
            selectedCards.append(allCards[randomCardNumber])
            allCards.remove(at: randomCardNumber)
        }
        }
    }
    
    func nextCardInDeck() {
        if currentCardIndex < selectedCards.count-1 {
            currentCardIndex += 1
        }
    }
    
    func backCardInDeck() {
        if currentCardIndex > 0 {
            currentCardIndex -= 1
        }
    }
    
    func getCurrentCardName() -> String {
        return selectedCards[currentCardIndex]
    }
}
