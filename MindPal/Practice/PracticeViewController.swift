//
//  PracticeViewController.swift
//  MindPal
//
//  Created by Randall Smith on 7/8/19.
//  Copyright © 2019 Randall Smith. All rights reserved.
//

import UIKit

class PracticeViewController: UIViewController {
    
    var numCards = 0
    var numMinutes = 0
    var gameSession: GameSession?
    
    var seconds = 60
    var timer = Timer()

    @IBOutlet weak var leftArrow: UIImageView!
    @IBOutlet weak var rightArrow: UIImageView!
    @IBOutlet weak var currentRenderedCard: UIImageView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var cardCountLabel: UILabel!
    @IBOutlet weak var progressBar: UIView!
    @IBOutlet weak var progressBarWidthConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.viewControllers.remove(at: 1)
        
        gameSession = GameSession(numCards)
        updateCurrentCard()
        
        leftArrow.isUserInteractionEnabled = true
        leftArrow.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.leftTap)))
        rightArrow.isUserInteractionEnabled = true
        rightArrow.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.rightTap)))
        
        seconds = seconds * numMinutes
        updateTimer()
        runTimer()
    }
    
    // Func in your UIViewController
    @objc func leftTap() {
        gameSession!.backCardInDeck()
        updateCurrentCard()
    }
    @objc func rightTap() {
        gameSession!.nextCardInDeck()
        updateCurrentCard()
    }
    
    private func updateCurrentCard() {
        let cardCount = CGFloat(gameSession!.selectedCards.count-1)
        progressBarWidthConstraint.constant = (view.frame.size.width / cardCount) * CGFloat(gameSession!.currentCardIndex)

        currentRenderedCard.image = UIImage(named: gameSession!.getCurrentCardName())
        cardCountLabel.text = "\(gameSession!.currentCardIndex) / \(gameSession!.selectedCards.count-1)"
    }
    
    private func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if seconds < 1 {
            timer.invalidate()
            //Send alert to indicate "time's up!"
        } else {
            seconds -= 1
            timerLabel.text = timeString(time: TimeInterval(seconds))
        }
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
}
