//
//  ViewController.swift
//  paperGlue
//
//  Created by vaevictis on 19/02/2015.
//  Copyright (c) 2015 guillaume hammadi. All rights reserved.
//

import UIKit
import CoreImage

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var imgOne:UIImageView!=nil
    @IBOutlet var imgTwo:UIImageView!=nil
    @IBOutlet var resultImg:UIImageView!=nil

    var currentBtn: UIButton!=nil
    
    @IBAction func selectImage(sender: UIButton) {
        currentBtn = sender
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            var imag = UIImagePickerController()
            imag.delegate = self
            imag.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
            imag.allowsEditing = false
            self.presentViewController(imag, animated: true, completion: nil)
        }
    }
    
    @IBAction func mergeImages(sender: UIButton) {
        /* TODO
        *   - Get size of image 1 and image 2
        *   - Create empty image of:
        *       -width = max(image 1 width, image 2 width)
        *       - height = image 1 height + image 2 height
        *   - position image 1 top left
        *   - position image 2 bottom left
        *   - PROFIT!!
        */
        
        var imgOneSize: CGSize! = imgOne?.image?.size
        var imgTwoSize: CGSize! = imgTwo?.image?.size
        
        var mergedImgHeight = imgOneSize.height + imgTwoSize.height
        
        var mergedImgSize: CGSize = CGSizeMake(mergedImgWidth(), mergedImgHeight)
        
        var rectangle = CGRectMake(0.0, 0.0, mergedImgWidth(), mergedImgHeight)
        var imageRef = CGImageCreateWithImageInRect(imgOne.image?.CGImage, rectangle)
        var mergedImg = UIImage(CGImage: imageRef)
        resultImg.image = mergedImg
    }
    
    func mergedImgWidth() -> CGFloat {
        var imgOneSize: CGSize! = imgOne?.image?.size
        var imgTwoSize: CGSize! = imgTwo?.image?.size
        
        let imgOneWidth: CGFloat! = imgOneSize!.width
        println("imgOneWidth = \(imgOneWidth)")
        
        
        let imgTwoWidth: CGFloat! = imgTwoSize.width
        println("imgTwoWidth = \(imgTwoWidth)")
        
        return CGFloat(max(imgOneWidth!,imgTwoWidth!))
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
        resultImg.contentMode = .ScaleAspectFit
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

