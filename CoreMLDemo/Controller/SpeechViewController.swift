//
//  SpeechViewController.swift
//  CoreMLDemo
//
//  Created by Максим Алексеев on 03.03.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit
import Speech
import AVKit

class SpeechViewController: UIViewController, SFSpeechRecognizerDelegate {
    // MARK:- Outlets
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    // MARK:- Private properties
    private let audioEngine: AVAudioEngine? = AVAudioEngine()
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "ru"))
    private var request: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        
        speechRecognizer?.delegate = self
        
        SFSpeechRecognizer.requestAuthorization { (status) in
            var buttonState = false
            
            switch status {
            case .authorized:
                buttonState = true
                print("Permission denied")
            case .denied:
                buttonState = false
                print("User didn't give permission")
            case .notDetermined:
                buttonState = false
                print("Permission has not been received yet")
            case .restricted:
                buttonState = false
                print("Voice recognizer doesn't supported on this device")
            
            }
            
            DispatchQueue.main.async {
                self.startButton.isEnabled = buttonState
            }
        }
    }
    
    // MARK:- Private methods
    private func setupViews() {
        self.startButton.layer.cornerRadius = 10
        startButton.isEnabled = false
    }
    
    private func startRecording() {
        
        if recognitionTask == nil {
            let audioSession = AVAudioSession.sharedInstance()
            
            do {
                try audioSession.setCategory(AVAudioSessionCategoryRecord)
                try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
            } catch {
                print("Can not configure audio session")
            }
            
            request = SFSpeechAudioBufferRecognitionRequest()
        
            guard let inputNode = audioEngine?.inputNode else {
                fatalError("Audio engine does not have input node")
            }
            
            guard let recognitionRequest = request else {
                fatalError("Can not create instant of SFSpeechAudioBufferRecognitionRequest")
            }
            
            recognitionRequest.shouldReportPartialResults = true
            
            recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
                var isFinal = false
                
                if result != nil {
                     self.textLabel.text = result?.bestTranscription.formattedString
                     isFinal = (result?.isFinal)!
                 }
                
                
                if error != nil || isFinal {
                    self.audioEngine?.stop()
                    inputNode.removeTap(onBus: 0)
                    
                    self.request = nil
                    self.recognitionTask = nil
                    
                    self.startButton.isEnabled = true
                }
            })
            
            let format = inputNode.outputFormat(forBus: 0)
            inputNode.installTap(onBus: 0, bufferSize: 1024, format: format) { (buffer, _) in
                self.request?.append(buffer)
            }
            
            
            audioEngine?.prepare()
            
            do {
                try audioEngine?.start()
            } catch {
                print("Couldn't start audio engine")
            }
            
        } else { // if there is recognitionTask then stop it
            recognitionTask?.cancel()
            recognitionTask = nil
        }
    }
    
    // MARK:- Actions
    
    @IBAction func startTapped(_ sender: UIButton) {
 
    }
    
}
