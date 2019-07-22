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
    @IBOutlet weak var recognitionText: UILabel!
    
    @IBOutlet weak var rightCard: UIImageView!
    @IBOutlet weak var listenButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.viewControllers.remove(at: 1)
        
        audioEngine = AVAudioEngine()
        speechRecognizer = SFSpeechRecognizer()
        request = SFSpeechAudioBufferRecognitionRequest()
        checkPermissions()
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
                self.recognitionText.text = "You say: \(result.bestTranscription.formattedString)"
                self.stopRecording()
                node.removeTap(onBus: 0)
            }
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
}
