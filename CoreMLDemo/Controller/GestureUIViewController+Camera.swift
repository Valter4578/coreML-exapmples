//
//  GestureUIViewController+Camera.swift
//  CoreMLDemo
//
//  Created by Максим Алексеев on 18.11.2019.
//  Copyright © 2019 Максим Алексеев. All rights reserved.
//

import UIKit
import AVFoundation
import Vision

@available(iOS 13.0, *)
extension GestureUIViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    func prepareCamera() {
        let aviableDevice = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .front).devices
        captureDevice = aviableDevice[0]
        
        beginSession()
    }
    
    func beginSession() {
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: captureDevice)
            captureSession.addInput(captureDeviceInput)
        } catch {
            print("Couldn't create  video device input")
        }
        
        captureSession.beginConfiguration()
        captureSession.sessionPreset = .vga640x480
        
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_420YpCbCr8BiPlanarFullRange)]
        
        dataOutput.alwaysDiscardsLateVideoFrames = true
        
        if captureSession.canAddOutput(dataOutput) {
            captureSession.addOutput(dataOutput)
        }
        
        captureSession.commitConfiguration()
        
        let queue = DispatchQueue(label: "captureQueue")
        dataOutput.setSampleBufferDelegate(self, queue: queue)
        
        captureSession.startRunning()
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        let exifOrientation = exifOrientationFromDeviceOrientation()
        
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: exifOrientation, options: [:])
        
        do {
            try imageRequestHandler.perform(self.requests)
        } catch {
            print(error)
        }
    }
    
    func exifOrientationFromDeviceOrientation() -> CGImagePropertyOrientation {
        let currentDeviceOrientation = UIDevice.current.orientation
        let exifOrientation: CGImagePropertyOrientation
        
        switch currentDeviceOrientation {
        case UIDeviceOrientation.portraitUpsideDown: // Device oriented vertically, home button on the top
            exifOrientation = .left
        case UIDeviceOrientation.landscapeLeft: // Device oriented horizontally, home button on the right
            exifOrientation = .upMirrored
        case UIDeviceOrientation.landscapeRight: // Device oriented horizontally, home button on the left
            exifOrientation = .down
        case UIDeviceOrientation.portrait: // Device oriented vertically, home button on the bottom
            exifOrientation = .up
        default:
            exifOrientation = .up
        }
        return exifOrientation 
    }
}
