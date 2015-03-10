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
    
    
    @IBAction func openImagesFromInbox(sender: UIBarButtonItem) {
        open2ImagesFromInbox()
    }
    
    @IBAction func deleteFilesInInbox(sender: UIBarButtonItem) {
        let fileManager = NSFileManager.defaultManager()
        var theError = NSErrorPointer()
        
        let urls = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        
        if let documentDirectory: NSURL = urls.first as? NSURL {
            let inboxUrl = documentDirectory.URLByAppendingPathComponent("Inbox")
            let fileList = fileManager.contentsOfDirectoryAtURL(inboxUrl, includingPropertiesForKeys: nil, options: nil, error: theError)

            if let fileURLs = fileList as? [NSURL] {
                for fileURL in fileURLs {
                    println("file: \(fileURL.lastPathComponent)")
                    fileManager.removeItemAtURL(fileURL, error: theError)
                }
            }
        }
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

    func open2ImagesFromInbox() {
        let fileManager = NSFileManager.defaultManager()
        var theError = NSErrorPointer()
        
        let urls = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        
        if let documentDirectory: NSURL = urls.first as? NSURL {
            let inboxUrl = documentDirectory.URLByAppendingPathComponent("Inbox")
            let fileList = fileManager.contentsOfDirectoryAtURL(inboxUrl, includingPropertiesForKeys: nil, options: nil, error: theError)
            
            if let fileURLs = fileList as? [NSURL] {
                for fileURL in fileURLs {
                    let img = UIImage(data: NSData(contentsOfURL: fileURL)!)
                    imgOne.image = img

                    //            TODO: fill a collection
                }
            }
        }
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
        
        if currentBarBtn.title == "Img 1" {
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

