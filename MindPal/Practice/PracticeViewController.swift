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
    var isTimerRunning = false

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
//        runTimer()
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
        let cardCount = CGFloat(gameSession!.selectedCards.count)
        progressBarWidthConstraint.constant = (view.frame.size.width / cardCount) * CGFloat(gameSession!.currentCardIndex + 1)
//        progressBar.frame.size.width = (view.frame.size.width / 5) * CGFloat(gameSession!.currentCardIndex + 1)
        currentRenderedCard.image = UIImage(named: gameSession!.getCurrentCardName())
        cardCountLabel.text = "\(gameSession!.currentCardIndex + 1) / \(gameSession!.selectedCards.count)"
    }
    
    private func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        seconds -= 1     //This will decrement(count down)the seconds.
        timerLabel.text = "\(seconds)" //This will update the label.
    }
}
