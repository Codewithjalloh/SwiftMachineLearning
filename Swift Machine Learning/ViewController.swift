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
    
    
    @IBAction func takePhoto(_ sender: Any) {
    }
    
    
    @IBAction func photoLibrary(_ sender: Any) {
    }
    
    
    


}

