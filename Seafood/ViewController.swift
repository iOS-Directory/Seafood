//
//  ViewController.swift
//  Seafood
//
//  Created by FGT MAC on 3/24/20.
//  Copyright © 2020 FGT MAC. All rights reserved.
//

import UIKit
import CoreML

//Vision is use to process images
import Vision


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //MARK: - Oulets
    @IBOutlet weak var imageView: UIImageView!
    
    
    //MARK: - Properties
    
    let imagePicker = UIImagePickerController()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false

    }

    //MARK: - Actions
    
    @IBAction func CameraTapped(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    

}

