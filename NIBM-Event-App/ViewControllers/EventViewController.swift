//
//  EventViewController.swift
//  NIBM-Event-App
//
//  Created by user161121 on 2/26/20.
//  Copyright © 2020 surainfdo. All rights reserved.
//

import UIKit

class EventViewController: UIViewController {

    @IBOutlet weak var imageview1: UIImageView!
    @IBOutlet weak var imageview2: UIImageView!
    var imagePicker: ImagePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.imagePicker = ImagePicker(presentationController: self, delegate: self)

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func pickimage1(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    
    @IBAction func convertDiaplay(_ sender: Any) {
        convertImageToBase64()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func convertImageToBase64()
    {
        guard let  image = imageview1.image else{
            return
        }
       
     guard  let jpegData = image.jpegData(compressionQuality: 1.0) else //converted to base 64
       {return
        
        }
        let strBase64 = jpegData.base64EncodedString(options: .lineLength64Characters)
        let nsd: NSData = NSData(base64Encoded: strBase64, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)!
        if let image = UIImage(data: nsd as Data) {
            imageview2.image=image
        }
        
        
        
  
        
        
        
    }

}
extension EventViewController: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        self.imageview1.image = image
    }
}
