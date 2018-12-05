//
//  ViewController.swift
//  CoreMLDemo
//
//  Created by Максим Алексеев on 5/12/18.
//  Copyright © 2018 Максим Алексеев. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate {
    // Outlets
    @IBOutlet weak var classifer: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    }
    
    

}
extension ViewController: UIImagePickerControllerDelegate {
    func imagePickerControllerDidяCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
