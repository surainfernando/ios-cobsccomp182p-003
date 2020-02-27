//
//  EventViewController.swift
//  NIBM-Event-App
//
//  Created by user161121 on 2/26/20.
//  Copyright © 2020 surainfdo. All rights reserved.
//

import UIKit

class EventViewController: UIViewController {

    
    @IBOutlet weak var TitleTextView: UITextField!
    
    @IBOutlet weak var DescriptionTextView: UITextView!
    
    @IBOutlet weak var DatePicker: UIDatePicker!
    
    
    @IBOutlet weak var StartTimePicker: UIDatePicker!
    
    
    @IBOutlet weak var EndTimePicker: UIDatePicker!
    
    
    @IBOutlet weak var ContactnoTextField: UITextField!
    
    @IBOutlet weak var PhotoImageView: UIImageView!
    
    
    
    
    
    var imagePicker: ImagePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.imagePicker = ImagePicker(presentationController: self, delegate: self)

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func createEventAction(_ sender: Any) {
        
    }
    
    
   
    
    
    
    
    
    
    
    
    
    
    
    
    
//    func convertImageToBase64()
//    {
//        guard let  image = imageview1.image else{
//            return
//        }
//
//     guard  let jpegData = image.jpegData(compressionQuality: 1.0) else //converted to base 64
//       {return
//
//        }
//        let strBase64 = jpegData.base64EncodedString(options: .lineLength64Characters)
//        let nsd: NSData = NSData(base64Encoded: strBase64, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)!
//        if let image = UIImage(data: nsd as Data) {
//            imageview2.image=image
//        }
//
//
//
//
//
//
//
//    }

}
extension EventViewController: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        self.PhotoImageView.image = image
    }
}
