//
//  DocumentClassification.swift
//  CoreMLDemo
//
//  Created by Максим Алексеев on 26/12/2018.
//  Copyright © 2018 Максим Алексеев. All rights reserved.
//

import UIKit
import WebKit
import DocumentClassifier


class DocumentClassificationViewController: UIViewController {
    var model = DocumentClassifier()
    
    lazy var percentFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 1
        return formatter
    }()
    
    //MARK: - Outlets
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var cetegoryLabel: UILabel!

    //MARK: - Standart function's
    override func viewDidLoad() {
        super.viewDidLoad()
        cetegoryLabel.text = ""
    }
    
    
    //MARK: - Methods
    func updateInterface(for prediction: Classification.Result) {
        guard let percent = percentFormatter.string(from: NSNumber(value: prediction.probability)) else {
            return
        }
        cetegoryLabel.text = prediction.category.rawValue + " " + "(\(percent))"
    }
    
    //MARK: - Action's
    @IBAction func done(_ sender: UIBarButtonItem) {
        classify(textView.text)
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - CoreML
    
    func classify(_ text: String) {
        let text = textView.text!
        guard let classification = model.classify(text) else {
            return
        }
        let prediction = classification.prediction
        print(classification.prediction)
        updateInterface(for: prediction)
    }
}
