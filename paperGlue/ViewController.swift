//
//  ViewController.swift
//  paperGlue
//
//  Created by vaevictis on 19/02/2015.
//  Copyright (c) 2015 guillaume hammadi. All rights reserved.
//

import UIKit
//class ViewController: UIViewController,UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPopoverControllerDelegate


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var imgOne:UIImageView!=nil
    @IBOutlet var imgTwo:UIImageView!=nil

    var currentBtn: UIButton!=nil
    
    @IBAction func buttonTapped(sender: UIButton) {
        currentBtn = sender
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            var imag = UIImagePickerController()
            imag.delegate = self
            imag.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
            imag.allowsEditing = false
            self.presentViewController(imag, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject: AnyObject]) {

        let selectedImage : UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage

        if currentBtn.titleLabel?.text == "Select image 1" {
            imgOne?.image = selectedImage
        } else {
            imgTwo?.image = selectedImage
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imgOne.contentMode = .ScaleAspectFit
        imgTwo.contentMode = .ScaleAspectFit
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

