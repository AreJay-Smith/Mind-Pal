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
    
    let voiceIndex = [
        "2C": ["two of clubs", "2 of clubs"],
        "3C": ["three of clubs", "3 of clubs"],
        "4C": ["four of clubs", "4 of clubs"],
        "5C": ["five of clubs", "5 of clubs"],
        "6C": ["six of clubs", "6 of clubs"],
        "7C": ["seven of clubs", "7 of clubs"],
        "8C": ["eight of clubs", "8 of clubs"],
        "9C": ["nine of clubs", "9 of clubs"],
        "10C": ["10 of clubs", "10 of clubs"],
        "JC": ["jack of clubs"],
        "QC": ["queen of clubs"],
        "KC": ["king of clubs"],
        "AC": ["ace of clubs"],
        "2S": ["two of spades", "2 of spades"],
        "3S": ["three of spades", "3 of spades"],
        "4S": ["four of spades", "4 of spades"],
        "5S": ["five of spades", "5 of spades"],
        "6S": ["six of spades", "6 of spades"],
        "7S": ["seven of spades", "7 of spades"],
        "8S": ["eight of spades", "8 of spades"],
        "9S": ["nine of spades", "9 of spades"],
        "10S": ["ten of spades", "10 of spades"],
        "JS": ["jack of spades"],
        "QS": ["queen of spades"],
        "KS": ["king of spades"],
        "AS": ["ace of spades"],
        "2D": ["two of diamonds", "2 of diamonds"],
        "3D": ["three of diamonds", "3 of diamonds"],
        "4D": ["four of diamonds", "4 of diamonds"],
        "5D": ["five of diamonds", "5 of diamonds"],
        "6D": ["six of diamonds", "6 of diamonds"],
        "7D": ["seven of diamonds", "7 of diamonds"],
        "8D": ["eight of diamonds", "8 of diamonds"],
        "9D": ["nine of diamonds", "9 of diamonds"],
        "10D": ["ten of diamonds", "10 of diamonds"],
        "JD": ["jack of diamonds"],
        "QD": ["queen of diamonds"],
        "KD": ["king of diamonds"],
        "AD": ["ace of diamonds"],
        "2H": ["two of hearts", "2 of hearts"],
        "3H": ["three of hearts", "3 of hearts"],
        "4H": ["four of hearts", "4 of hearts"],
        "5H": ["five of hearts", "5 of hearts"],
        "6H": ["six of hearts", "6 of hearts"],
        "7H": ["seven of hearts", "7 of hearts"],
        "8H": ["eight of hearts", "8 of hearts"],
        "9H": ["nine of hearts", "9 of hearts"],
        "10H": ["ten of hearts", "10 of hearts"],
        "JH": ["jack of hearts"],
        "QH": ["queen of hearts"],
        "KH": ["king of hearts"],
        "AH": ["ace of hearts"],
    ]
    
    var selectedCards: Array<String> = []
    var currentCardIndex = 0
    
    init(_ numCards: Int) {
        generateSelectedList(with: numCards)
    }
    
    func generateSelectedList(with numCards: Int) {
        if (numCards != 0) {
            selectedCards.append("yellow_back")
        for _ in 1...numCards {
            let randomCardNumber = Int.random(in: 0..<allCards.count)
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
    
    func checkVoicRecording(is recording: String) -> Bool {
        if let possibleVoicResponse = voiceIndex[getCurrentCardName()] {
            return possibleVoicResponse.contains(recording.lowercased())
        }
        return false
    }
}
