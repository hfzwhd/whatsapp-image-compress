//
//  ViewController.swift
//  wimage-compress
//
//  Created by Hafiz Wahid on 12/01/2017.
//  Copyright © 2017 hw. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
    @IBOutlet weak var originalImage: UIImageView!
    @IBOutlet weak var compressImage: UIImageView!
    
//    let imageData = UIImagePNGRepresentation(UIImage)
   // let getImageFromPreviousVC: UIImage? = nil
    //var resultImage = UIImageView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        originalImage.image = UIImage(named: "IMG_1546")
        
        let imageData = UIImagePNGRepresentation(originalImage.image!)
        let image = UIImage(data: imageData!)
        
        let resultImage  = compressImage(image: image!)
        
        compressImage.image = UIImage(data: resultImage)
        
        UIImageWriteToSavedPhotosAlbum(compressImage.image!, self, nil, nil)
       
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func compressImage(image:UIImage) -> Data {
        
        var originalHeight : CGFloat = (image.size.height)
        var originalWidth : CGFloat = (image.size.width)
        let maxHeight: CGFloat = 600.0
        let maxWidth: CGFloat = 800.00
        var imgRatio: CGFloat = originalWidth / originalHeight
        let maxRatio: CGFloat = maxWidth / maxHeight
        let compressionQuality: CGFloat = 0.5
        
        if originalHeight > maxHeight || originalWidth > maxWidth {
            
            if imgRatio < maxRatio {
                imgRatio = maxHeight / originalHeight
                originalWidth = imgRatio * originalWidth
                originalHeight = maxHeight
                
            } else if imgRatio > maxRatio {
                imgRatio = maxWidth / originalWidth
                originalHeight = imgRatio * originalHeight
                originalWidth = maxWidth
            } else {
                originalHeight = maxHeight
                originalWidth = maxWidth
            }

        }
        
        let rect = CGRect(x: CGFloat(0.0), y: CGFloat(0.0), width: CGFloat(originalWidth), height: CGFloat(originalHeight))
        UIGraphicsBeginImageContext(rect.size)
        image.draw(in: rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        let imageData = UIImageJPEGRepresentation(img!, compressionQuality)
        UIGraphicsEndImageContext()
        return imageData!
    }


}

