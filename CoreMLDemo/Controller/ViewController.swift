//
//  ViewController.swift
//  CoreMLDemo
//
//  Created by Максим Алексеев on 5/12/18.
//®  Copyright © 2018 Максим Алексеев. All rights reserved.
//

import UIKit
import CoreML

class ViewController: UIViewController, UINavigationControllerDelegate {
    var model: Inceptionv3!
    var outerView: UIView!
    //MARK: -  Outlets
    @IBOutlet weak var classifer: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    //MARK: -  methods
    override func viewWillAppear(_ animated: Bool) {
        model = Inceptionv3()
        print(imageView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.layer.cornerRadius = 9
        imageView.clipsToBounds = true
    }
    //MARK: - Private methods
    private func setupImageView() {
        self.imageView.layer.cornerRadius = 9
        self.imageView.dropShadow()
        
    }
    
    //MARK: Actions
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    /// Runs when user click 'camera' button
    @IBAction func camera(_ sender: Any) {
        // Choose device camera
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            return
        }
        
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .camera
        cameraPicker.allowsEditing = false
        
        present(cameraPicker,animated: true)
    }
    
    @IBAction func openLibrary(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.allowsEditing = false
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
        self.imageView.dropShadow()
    }
    
    

}
extension ViewController: UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.setupImageView()
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // Get select image and put it's in constant "image"
        /* Start here*/
        picker.dismiss(animated: true)
        classifer.text = "Analyzing Image..."
        guard let image = info["UIImagePickerControllerOriginalImage"] as? UIImage else {
            return
        }
        /*End here*/
        
        // Convert new image to 299x229
        /* Start here */
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 299, height: 299), true, 2.0)
        image.draw(in: CGRect(x: 0, y: 0, width: 299, height: 299))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        /* End here */
        
        // Convert new image into a CVPixelBuffer
        /* Start here */
        let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
        var pixelBuffer : CVPixelBuffer?
        let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(newImage.size.width), Int(newImage.size.height), kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)
        guard (status == kCVReturnSuccess) else {
            return
        }
        /* End here */
        
        CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)
        
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: pixelData, width: Int(newImage.size.width), height: Int(newImage.size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
        
        // Get all pixels in image and conver it's into iPhone RGB
        /* Start here */
        context?.translateBy(x: 0, y: newImage.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        /* End here */
        
        // Render image
        /* Start here */
        UIGraphicsPushContext(context!)
        newImage.draw(in: CGRect(x: 0, y: 0, width: newImage.size.width, height: newImage.size.height))
        UIGraphicsPopContext()
        CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        imageView.image = newImage // Set for image space(Image View) changed the picture
        /* End here */
        
        

        guard let prediction = try? model.prediction(image: pixelBuffer!) else {
            return
        }
        
        classifer.text = "I think this is a \(prediction.classLabel)."
    }
}
