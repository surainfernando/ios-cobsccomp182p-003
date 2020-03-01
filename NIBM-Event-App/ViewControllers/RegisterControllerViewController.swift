//
//  RegisterControllerViewController.swift
//  NIBM-Event-App
//
//  Created by user161121 on 2/29/20.
//  Copyright © 2020 surainfdo. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class RegisterControllerViewController: UIViewController {

    
    
    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passordTF: UITextField!
    
    @IBOutlet weak var repeatpasswordTF: UITextField!
    
    
    @IBOutlet weak var fnameTF: UITextField!
    
    @IBOutlet weak var lnameTF: UITextField!
    
    
    @IBOutlet weak var profilePIC: UIImageView!
     var imagePicker: ImagePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        signOUT()

        // Do any additional setup after loading the view.
    }
    
    
    
    
    @IBAction func signUpAction(_ sender: Any) {
        let check=validateInputs()
        if(check)
        {
            handleSignUp()
        }
        
    }
    
    
    
    @IBAction func chooseprofilePicAction(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    
    
    @IBAction func cancelRegistration(_ sender: Any) {
        
        performSegue(withIdentifier: "registolog", sender: nil)
        
    }
    func validateInputs()->Bool
    {
        var check=true
        check=validateTextFields()
        check=checkIfImageSelected()
        check=checkIfPasswordsMatch()
        return check
    }
    func validateTextFields()->Bool
    {
        var check=true
        if(emailTF.text=="")
        {check=false}
        if(passordTF.text=="")
        {check=false}
        if(repeatpasswordTF.text=="")
        {check=false}
        if(fnameTF.text=="")
        {check=false}
        if(lnameTF.text=="")
        {check=false}
        if(check==false)
        {
            createAlert(messagestring: "Please Fill All The Text Fields")
        }
        return check
        
        
    }
    func checkIfImageSelected()->Bool
    {
        guard let  image = profilePIC.image else{
            createAlert(messagestring: "Please select a image")
            return false
        }
        return true
    }
    func signOUT()
    {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    func checkIfPasswordsMatch()->Bool
    {
        if(passordTF.text != repeatpasswordTF.text)
        {
            createAlert(messagestring: "The passwords do not match. Please try again")
            return false
        }
        return true
        
    }
    
    
    
    func handleSignUp() {
        
        guard let email=emailTF.text else{return}
        guard let password=passordTF.text else{return}
          guard let fname=fnameTF.text else{return}
         guard let lname=lnameTF.text else{return}
        let fullname=fname+" "+lname

        
        
        
        Auth.auth().createUser(withEmail:email, password: password) { user, error12 in
            if error12 == nil && user != nil {
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = fullname
                
                
                changeRequest?.commitChanges { error in
                    if error == nil {
//                        Auth.auth().currentUser?.sendEmailVerification { (error) in
//                            // ...
//                            if error==nil{
//                                print("Email Sent")
//
//
//                            }else{
//
//                            }
//                        }
                       self.clearFields()
                        self.performSegue(withIdentifier: "seg2", sender: nil)
                        
                    }else{
                        print("COuldnt input name")
                    }
                }
                
                
                
                
            }else{
               self.createAlert(messagestring: "The Email which you enterd does not exist. Please try again.")
                print(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;")
                print(error12)
            }
            
            
        }
       
    
 
    
    
}
    func clearFields()
    { emailTF.text=""
        passordTF.text=""
        repeatpasswordTF.text=""
        fnameTF.text=""
        lnameTF.text=""
    }

    func createAlert(messagestring:String)
    {
        let alertController = UIAlertController(title: "ERROR!!!", message:messagestring, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
    }
    

    

}
extension RegisterControllerViewController: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        self.profilePIC.image = image
    }
}

