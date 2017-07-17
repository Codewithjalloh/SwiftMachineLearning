//
//  ViewController.swift
//  Swift Machine Learning
//
//  Created by codewithjalloh on 16/07/2017.
//  Copyright © 2017 CWJ. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    func detectImageContent() {
        resultLabel.text = "analyzing"
        
        
        guard let model = try? VNCoreMLModel(for:GoogLeNetPlaces().model) else {
            fatalError("Failed to load model")
        }
        
        
        // create a vision request
        let request = VNCoreMLRequest(model: model) {[weak self ] request, error in
            
            guard let results = request.results as? [VNClassificationObservation], let topResult = results.first else {
                
                fatalError("Unexpected results")
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.resultLabel.text = "\(topResult.identifier) with \(Int(topResult.confidence * 100))% confidence"
            }
            
        }
        
        guard let ciImage = CIImage(image: self.photoView.image!) else {
            fatalError("cannot create CIImage from UIImage")
        }
        
        
        let handler = VNImageRequestHandler(ciImage: ciImage)
        DispatchQueue.global().async {
            do {
                try handler.perform([request])
            } catch {
                print(error)
            }
        }
        
        
        
    }
    
    
    // take a picture from your camera
    @IBAction func takePhoto(_ sender: Any) {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        
    }
    
    
    // select from photoLibrary
    @IBAction func photoLibrary(_ sender: Any) {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imgPick = UIImagePickerController()
            imgPick.delegate = self
            imgPick.sourceType = .photoLibrary
            imgPick.allowsEditing = true
            self.present(imgPick, animated: true, completion: nil)
        }
        
    }
    
    
    
    // use the imagePickerController didFinishPickingMediaWithInfo delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImg = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            photoView.contentMode = .scaleToFill
            photoView.image = pickedImg
        }
        
        picker.dismiss(animated: true, completion: nil)
        detectImageContent()
        
        
        
    }
    
    


}

