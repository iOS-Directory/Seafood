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
    
    //MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        //Get the image and downcasted from type Any to UIImage in order to assign it to the imageView.image outlet
        if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
             imageView.image = userPickedImage
            
            //Convert image to CIImage for interpretation by ML
            guard let ciImage = CIImage(image: userPickedImage) else {
                fatalError("Could not convert to CIImage")
            }
            //pass the image to our method for processing
            detect(image: ciImage)
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: - Methods
    
    
    func detect(image: CIImage) {
        //create an object from the model to clasify images
        //VNCoreMLModel comes from the Vision frameWork to allow us do the image recognizion using CoreML
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {
            fatalError("Loading CoreML model failed.")
        }
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Model failed to process image")
            }
            
            //Get the first result
            if let firstResult = results.first {
                self.navigationItem.title = firstResult.identifier
            }
        }
        
        
        let handler  = VNImageRequestHandler(ciImage: image)
        
        do{
            try handler.perform([request])
        }catch{
            print("Error in dected method do block.")
        }
    }
    
    

    //MARK: - Actions
    
    @IBAction func CameraTapped(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true, completion: nil)
    }
}

