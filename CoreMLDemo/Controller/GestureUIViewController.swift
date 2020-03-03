//
//  GestureUIViewController.swift
//  CoreMLDemo
//
//  Created by Максим Алексеев on 11.11.2019.
//  Copyright © 2019 AppCoda. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import Vision
import AVFoundation
import AVKit

enum RemoteCommand: String {
    case none = "no-hand"
    case open = "FIVE-UB-RHand"
    case fist = "fist-UB-RHand"
}


@available(iOS 13.0, *)
class GestureUIViewController: UIViewController {

    @IBOutlet weak var playerView: PlayerView!
    @IBOutlet weak var emojiLabel: UILabel!
    
    var isGestureUIPresented: Bool = false
    // Camera properties
    let captureSession = AVCaptureSession()
    var captureDevice: AVCaptureDevice! = nil
    var devicePosition: AVCaptureDevice.Position = .front
    // Vision
    var requests = [VNRequest]()
    
    let bufferSize = 4
    var commandBuffer = [RemoteCommand]()
    var currentCommand: RemoteCommand = .none{
        didSet {
            commandBuffer.append(currentCommand)
            if commandBuffer.count == bufferSize {
                if commandBuffer.filter({$0 == currentCommand}).count == bufferSize {
                    showAndSendCommand(currentCommand)
                }
                commandBuffer.removeAll()
            }
        }
    }
    
    
    //MARK: - Lyfecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emojiLabel.text = ""
        
        isGestureUIPresented = true
        
        if isGestureUIPresented {
            setupPlayer()
            setupVision()
            setupAirPlay()
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isGestureUIPresented = true
        prepareCamera()
    }
    
    
    //MARK: - Private methods
    private func setupVision() {
        guard let visionModel = try? VNCoreMLModel(for: example_5s0_hand_model().model) else { fatalError("Can't load CoreML model") }
        
        let classificationRequest = VNCoreMLRequest(model: visionModel, completionHandler: self.handleClassification(request:error:))
        
        classificationRequest.imageCropAndScaleOption = .centerCrop
        
        self.requests = [classificationRequest]
    }
    
    private func setupAirPlay() {
        let airplay = AVRoutePickerView(frame: CGRect(x: 0, y: 40, width: 80, height: 80))
        airplay.center = self.view.center
        airplay.tintColor = UIColor.systemBackground
        self.view.addSubview(airplay)
    }
    
    private func setupPlayer() {
        guard let url = URL(string: "http:/commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4") else { return }
        playerView.setPlayerURL(url: url)
        print(#function)
        playerView.player.play()
        print(#function)
    }
    
    private func handleClassification(request: VNRequest, error: Error?) {
        guard let observation = request.results  else {
            print("There aren't results")
            return
        }
        
        let classification = observation
            .compactMap({$0 as? VNClassificationObservation})
            .filter({$0.confidence > 0.5})
            .map({$0.identifier})
        
        switch classification.first {
        case "no-hand":
            currentCommand = .none
        case "FIVE-UB-RHand":
            currentCommand = .open
        case "fist-UB-RHand":
            currentCommand = .fist
        default:
            currentCommand = .none
        }
        
        print(classification)
    }
    

    
    func showAndSendCommand(_ command: RemoteCommand) {
        DispatchQueue.main.async {
            if command == .open {
                self.playerView.player.play()
                self.emojiLabel.text = "✋"
            } else if command == .fist {
                self.playerView.player.pause()
                self.emojiLabel.text = "✊"
            } else if command == .none {
                self.emojiLabel.text = "❎"
            }
        }
    }
    
    //MARK: - Actions
    @IBAction func cancelClicked(_ sender: UIBarButtonItem) {
        isGestureUIPresented = false
        dismiss(animated: true, completion: nil)
    }
    
}
