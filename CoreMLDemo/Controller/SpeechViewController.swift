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

class SpeechViewController: UIViewController {
    // MARK:- Outlets
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    // MARK:- Private properties
    private let audioEngine = AVAudioEngine()
    private let speechRecognizer = SFSpeechRecognizer()
    private var request: SFSpeechAudioBufferRecognitionRequest?
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
    
    
    // MARK:- Actions
    
    @IBAction func startTapped(_ sender: UIButton) {
 
    }
    
}
