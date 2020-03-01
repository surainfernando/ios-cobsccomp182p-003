//
//  EventViewController.swift
//  NIBM-Event-App
//
//  Created by user161121 on 2/26/20.
//  Copyright © 2020 surainfdo. All rights reserved.
//

import UIKit
import Foundation
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage


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
        initiationCode()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func createEventAction(_ sender: Any) {
   
        let z=checkIfAllFieldsAreFilled()
        if(!z)
        {
           createAlert(messagestring: "Please Fill All Text Fleds")
            return
        }
        
        ContactnoTextField.text="sucees"
        writeEventToDatabase()
        
       
        
    }
    
    
   
    
    @IBAction func chooseLocationAction(_ sender: Any) {
    }
    
    
    @IBAction func chooseImageAction(_ sender: UIButton) {
         self.imagePicker.present(from: sender)
    }
    
    func checkIfAllFieldsAreFilled()->Bool{
        var check=true
        check=checkContactNo()
        check=checkIfTimesAreCorrect()
        check=checkIfImageSelected()
        if(TitleTextView.text=="")
        {check=false}
        if(DescriptionTextView.text=="")
        {check=false}
        if(ContactnoTextField.text=="")
        {check=false}
        
        return check
    }
    
    func clearTexTFields()
    {
        TitleTextView.text=""
        DescriptionTextView.text=""
        ContactnoTextField.text=""
       PhotoImageView.image = nil
    }
    
    func checkContactNo()->Bool
    {
       
       
        guard let phoneText=ContactnoTextField.text else
        {return false}
         let phoneNumberLength=phoneText.count
        
        if(phoneNumberLength != 10)
        {createAlert(messagestring: "Please enter a phone number with ten digits in the relavent Text Fied.")
            return false}
       guard let a=Int(phoneText) else
       {
        createAlert(messagestring: "Please enter a phone number with ten digits in the relavent Text Fied.")
        return false
        }
        return true
    }
    
    func checkIfImageSelected()->Bool
    {
        guard let  image = PhotoImageView.image else{
            createAlert(messagestring: "Please select a image")
                     return false
                   }
        return true
    }
    func createAlert(messagestring:String)
    {
        let alertController = UIAlertController(title: "ERROR!!!", message:messagestring, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
    }
    func initiationCode()
    {
        let todaysDate = Date()
        
        DatePicker.minimumDate = todaysDate;
    }
    
    func checkIfTimesAreCorrect()->Bool
    {
        let date=Date()
        let dateFormatter = DateFormatter()
     dateFormatter.dateFormat = "dd MMMM yyyy"
    let selectedDate = dateFormatter.string(from: DatePicker.date)
    let selectedDate2=dateFormatter.string(from: date)
       
            let date1 = StartTimePicker.date
            let components = Calendar.current.dateComponents([.hour, .minute], from: date1)
            guard let hour1 = components.hour else
            {return  false}
            guard let minute1 = components.minute else
            {return  false}
            
            let date2 = EndTimePicker.date
            let components2 = Calendar.current.dateComponents([.hour, .minute], from: date2)
            guard let hour2 = components2.hour else
            {return  false}
            guard let minute2 = components2.minute else
            {return  false}
            
            
            if(hour2<hour1)
            {
                createAlert(messagestring: "Ending time is less than the begining time. Please check the two time pickers")
                return false
            }
            if(hour2==hour1)
            {
                if(minute2<=minute1)
                {
                    createAlert(messagestring: "Ending time is less than the begining time. Please check the two time pickers")
                    return false
                }
            }
        
        
        
        return true
        
    }
    func writeEventToDatabase()
    {
        //textfield values
        guard let titletext=TitleTextView.text else
        {return}
        guard let descriptionText=DescriptionTextView.text else
        {return }
        guard let telephoneNumber=ContactnoTextField.text else
        {return}
        
        //date and time values
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat="HH:mm"
        
        let Date=dateFormatter.string(from: DatePicker.date)
        let begintime=timeFormatter.string(from: StartTimePicker.date)
        let endtime=timeFormatter.string(from: EndTimePicker.date)
        
        
        let imageString:NSString=getImageString()
        guard let  image = PhotoImageView.image else{
            return
        }
         var jpeg  = NSData()
        jpeg = image.jpegData(compressionQuality:1.0) as! NSData
        
        let user1 = Auth.auth().currentUser
        if let user1=user1 {
           
            let uid = user1.uid
            print(uid)
            var ref = Database.database().reference()
//            ref.child("Events").child(uid).setValue(["Title":titletext,"Description":descriptionText,"phone_number":telephoneNumber,"Date":Date,"BeginTime":begintime,"EndTime":endtime,"ImageString":jpeg,"People_Attending":0])
            
          
            ref.child("Events").childByAutoId().setValue(["Title":titletext,"Description":descriptionText,"phone_number":telephoneNumber,"Date":Date,"BeginTime":begintime,"EndTime":endtime,"ImageString":"","People_Attending":0,"EventCreator":uid])
                 clearTexTFields()
            createAlert1(messagestring: "Your Event has been successfully posted")
            
            
           
            // ...
        }
        
    }
    
    
    
    func  createAlert1(messagestring:String)
    {
        let alertController = UIAlertController(title: "SUCCESS!!!", message:messagestring, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func getImageString()->NSString{
        guard let  image = PhotoImageView.image else{
                     return ""
                   }
        guard  let jpegData = image.jpegData(compressionQuality: 1.0) else //converted to base 64
             {return ""
         
            }
        let strBase64 = jpegData.base64EncodedString(options: .lineLength64Characters)
        let datastring:NSString = NSString(data: jpegData, encoding: String.Encoding.utf8.rawValue) ?? ""
        return datastring
        
        
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
