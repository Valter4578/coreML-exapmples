//
//  ViewController.swift
//  coreML-image-classifer
//
//  Created by Максим Алексеев on 07/12/2018.
//  Copyright © 2018 Pineapple team. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

// MARK: - Methods
extension ViewController {
    
    func detectScene(image: CIImage) {
        answerLabel.text = "detecting scene..."
        
        // Load the ML model through its generated class
        guard let model = try? VNCoreMLModel(for: GoogLeNetPlaces().model) else {
            fatalError("can't load Places ML model")
        }
    }
}
