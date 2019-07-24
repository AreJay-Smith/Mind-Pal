//
//  TestViewController.swift
//  MindPal
//
//  Created by Randall Smith on 7/16/19.
//  Copyright © 2019 Randall Smith. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var leftArrow: UIImageView!
    @IBOutlet weak var rightArrow: UIImageView!
    @IBOutlet weak var cardCountLabel: UILabel!
    @IBOutlet weak var progressBarWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var currentRenderedCard: UIImageView!
    
    var seconds = 60
    var timer = Timer()
    var currentGame = GameSession(52)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        leftArrow.isUserInteractionEnabled = true
        leftArrow.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.leftTap)))
        rightArrow.isUserInteractionEnabled = true
        rightArrow.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.rightTap)))
        
        seconds = seconds * 10
        updateTimer()
        runTimer()
        updateCurrentCard()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToFinalTestScreen" {
            if let finalTestViewController = segue.destination as? FinalTestViewController {
                finalTestViewController.gameSession = self.currentGame
            }
        }
    }
    
    // Func in your UIViewController
    @objc func leftTap() {
        currentGame.backCardInDeck()
        updateCurrentCard()
    }
    @objc func rightTap() {
        currentGame.nextCardInDeck()
        updateCurrentCard()
    }
    
    private func updateCurrentCard() {
        let cardCount = CGFloat(currentGame.selectedCards.count-1)
        progressBarWidthConstraint.constant = (view.frame.size.width / cardCount) * CGFloat(currentGame.currentCardIndex)
        
        currentRenderedCard.image = UIImage(named: currentGame.getCurrentCardName())
        cardCountLabel.text = "\(currentGame.currentCardIndex) / \(currentGame.selectedCards.count-1)"
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
