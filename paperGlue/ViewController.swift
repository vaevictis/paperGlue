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

    var currentBarBtn: UIBarButtonItem!=nil
    
    @IBAction func selectImage(sender: UIBarButtonItem) {
        currentBarBtn = sender
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            
            var picker = UIImagePickerController()
            
            picker.delegate = self
            picker.sourceType = .PhotoLibrary;
            picker.allowsEditing = false
            picker.modalPresentationStyle = .Popover
            presentViewController(picker, animated: true, completion: nil)
            picker.popoverPresentationController?.barButtonItem = sender
        }
    }
    
    
    @IBAction func openImageFromInbox(sender: UIBarButtonItem) {
        println("open Image from Inbox")
        
        let fileManager: NSFileManager = NSFileManager.defaultManager()
        var documentsPathArray: NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        
        var documentsPath: NSString = documentsPathArray.firstObject as! NSString
        var imagePath: NSString = documentsPath as! String + "/Inbox/Faces - 1.png"
        var imgFromExt: UIImage = UIImage(contentsOfFile: imagePath as! String)!
        imgOne.image = imgFromExt
    }
    
    @IBAction func mergeImages(sender: UIBarButtonItem) {
        var imgOneSize: CGSize! = imgOne?.image?.size
        var imgTwoSize: CGSize! = imgTwo?.image?.size
        var mergedImgHeight = imgOneSize.height + imgTwoSize.height
        var mergedImgSize: CGSize = CGSizeMake(mergedImgWidth(), mergedImgHeight)
        var rectangle = CGRectMake(0.0, 0.0, mergedImgWidth(), mergedImgHeight)

        UIGraphicsBeginImageContext(mergedImgSize)
            imgOne?.image?.drawInRect(CGRectMake(0.0, 0.0, imgOneSize.width, imgOneSize.height))
            imgTwo?.image?.drawInRect(CGRectMake(0.0, imgOneSize.height, imgTwoSize.width, imgTwoSize.height))
            var mergedImg: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        resultImg.image = mergedImg
    }

    
    @IBAction func saveToLibrary(sender: UIBarButtonItem) {
        let alertController = UIAlertController(
                title: "paperGlue",
                message: "Do you want to save merged image to photo library?",
                preferredStyle: UIAlertControllerStyle.Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let saveAction = UIAlertAction(title: "Save", style: .Default) { (action) in
            self.writeImgToLibrary()
        }
        alertController.addAction(saveAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }

    
    func writeImgToLibrary() {
        UIImageWriteToSavedPhotosAlbum(resultImg.image, self, "image:didFinishSavingWithError:contextInfo:", nil)
    }
    
    func mergedImgWidth() -> CGFloat {
        var imgOneSize: CGSize! = imgOne?.image?.size
        var imgTwoSize: CGSize! = imgTwo?.image?.size
        
        return CGFloat(max(imgOneSize!.width,imgTwoSize.width))
    }
    
    func image(image: UIImage, didFinishSavingWithError
        error: NSErrorPointer, contextInfo:UnsafePointer<Void>) {
            if error != nil {
                println("error: \(error)")
            }
    }
    
    
    //MARK: Default class functions
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imgOne.contentMode = .ScaleAspectFit
        imgTwo.contentMode = .ScaleAspectFit
        resultImg.contentMode = .ScaleAspectFit
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    //MARK: Delegates
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject: AnyObject]) {
        let selectedImage : UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        if currentBarBtn.title == "Image 1" {
            imgOne?.image = selectedImage
        } else {
            imgTwo?.image = selectedImage
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    

}

