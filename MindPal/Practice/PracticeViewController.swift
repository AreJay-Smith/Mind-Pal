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
        currentRenderedCard.image = UIImage(named: gameSession!.getCurrentCardName())
        cardCountLabel.text = "\(gameSession!.currentCardIndex + 1) / \(gameSession!.selectedCards.count)"
        progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(gameSession!.currentCardIndex+1)
    }
    
//    private func runTimer() {
//        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
//    }
    
    func updateTimer() {
        seconds -= 1     //This will decrement(count down)the seconds.
        timerLabel.text = "\(seconds)" //This will update the label.
    }
}
