//
//  SpeechViewController.swift
//  CoreMLDemo
//
//  Created by Максим Алексеев on 03.03.2020.
//  Copyright © 2020 AppCoda. All rights reserved.
//

import UIKit
import Speech

class SpeechViewController: UIViewController {
    // MARK:- Outlets
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    // MARK:- Private properties
    private let audioEngine = AVAudioEngine()
    private let speechRecognizer = SFSpeechRecognizer()
    private let request = SFSpeechAudioBufferRecognitionRequest()
    private var recognitionTask: SFSpeechRecognitionTask?
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    // MARK:- Private methods
    private func setupView() {
        self.startButton.layer.cornerRadius = 10
    }
    
    
    private func recordAndRecognizeSpeech() {
        let node = audioEngine.inputNode
        let recordingFormat = node.outputFormat(forBus: 0)
        
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, _) in
            self.request.append(buffer)
        }
        
        // Prepare and start recognizer
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            print(error)
            return
        }
        
        guard let recognizer = SFSpeechRecognizer() else { return }
        if !recognizer.isAvailable { return }
        
        // Call recognizer task method
        recognitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: { (result, error) in
            if let result = result {
                
                let bestString = result.bestTranscription.formattedString
                self.textLabel.text = bestString
                
            } else if let error = error {
                print(error)
            }
        })
    }

    // MARK:- Actions
    
    @IBAction func startTapped(_ sender: UIButton) {
        recordAndRecognizeSpeech()
    }
    
}
