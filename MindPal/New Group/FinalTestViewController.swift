//
//  FinalTestViewController.swift
//  MindPal
//
//  Created by Randall Smith on 7/21/19.
//  Copyright © 2019 Randall Smith. All rights reserved.
//

import UIKit
import AVKit
import Speech

class FinalTestViewController: UIViewController {
    
    var gameSession: GameSession!
    var audioEngine: AVAudioEngine!
    var speechRecognizer: SFSpeechRecognizer!
    var request: SFSpeechAudioBufferRecognitionRequest!
    var recognitionTask: SFSpeechRecognitionTask?
    var voiceResponse = ""
    @IBOutlet weak var recognitionText: UILabel!
    
    
    @IBOutlet weak var rightCard: UIImageView!
    @IBOutlet weak var listenButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var progressBarConstraint: NSLayoutConstraint!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.viewControllers.remove(at: 1)
        gameSession.currentCardIndex = 0
        renderCard()
        audioEngine = AVAudioEngine()
        speechRecognizer = SFSpeechRecognizer()
        request = SFSpeechAudioBufferRecognitionRequest()
        checkPermissions()
        showResponseButtons(false)
        updateProgress()
    }
    
    private func checkPermissions() {
        SFSpeechRecognizer.requestAuthorization { (status) in
            switch status {
            case .authorized:
                
                break
            default:
                break
            }
        }
    }
    
    @IBAction func onDownPress(_ sender: Any) {
        try? startRecording()
    }
    @IBAction func onUpPress(_ sender: Any) {
        stopRecording()
        showResponseButtons(true)
    }
    
    func showResponseButtons(_ show: Bool) {
        if show {
            recordButton.isHidden = true
            yesButton.isHidden = false
            noButton.isHidden = false
        } else {
            recordButton.isHidden = false
            yesButton.isHidden = true
            noButton.isHidden = true
        }
    }
    
    func startRecording() throws {
        let node = audioEngine.inputNode
        let recordingFormat = node.outputFormat(forBus: 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, _) in
            self.request.append(buffer)
        }
        audioEngine.prepare()
        try audioEngine.start()
        
        recognitionTask = speechRecognizer.recognitionTask(with: self.request, resultHandler: { (result, error) in
            guard let result = result else {
                self.cancelRecording()
                return
            }
            self.recognitionText.text = result.bestTranscription.formattedString
            if result.isFinal {
                self.recognitionText.text = "Did you say: \(result.bestTranscription.formattedString)?"
                self.stopRecording()
                node.removeTap(onBus: 0)
            }
            self.voiceResponse = result.bestTranscription.formattedString
        })
    }
    
    func stopRecording() {
        audioEngine.stop()
        request.endAudio()
    }
    
    func cancelRecording() {
        audioEngine.stop()
        recognitionTask?.cancel()
    }
    
    private func renderCard() {
        rightCard.image = UIImage(named: gameSession!.getCurrentCardName())
    }
    
    private func checkIfCorrect(_ recording: String) -> Bool {
        return gameSession.checkVoicRecording(is: recording)
    }
    
    @IBAction func noButton(_ sender: Any) {
        showResponseButtons(false)
        recognitionText.text = ""
    }
    
    @IBAction func yesButton(_ sender: Any) {
        var result = self.checkIfCorrect(voiceResponse)
        if result {
            // User correct and continues
            gameSession.nextCardInDeck()
            renderCard()
            showResponseButtons(false)
            recognitionText.text = ""
            updateProgress()
        } else {
            // User lost
            if let score = UserDefaults.standard.value(forKey: "score") as? Int {
                if (gameSession.currentCardIndex) > score {
                    UserDefaults.standard.set(gameSession.currentCardIndex, forKey: "score")
                }
            } else {
            UserDefaults.standard.set(gameSession.currentCardIndex, forKey: "score")
            }
        navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func updateProgress() {
        let cardCount = CGFloat(gameSession.selectedCards.count-1)
        progressBarConstraint.constant = (view.frame.size.width / cardCount) * CGFloat(gameSession.currentCardIndex)
        
        progressLabel.text = "\(gameSession.currentCardIndex) / \(gameSession.selectedCards.count-1)"
    }
}

