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
    
    @IBOutlet weak var telTF: UITextField!
    
    
    @IBOutlet weak var fbURLTF: UITextField!
    @IBOutlet weak var profilePIC: UIImageView!
    
    
    @IBOutlet weak var sbtn: UIButton!
    
    @IBOutlet weak var cbtn: UIButton!
    
     var imagePicker: ImagePicker!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        signOUT()
        setComponents()

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
        check=checkContactNo()
        check=checkIfImageSelected()
        check=checkIfPasswordsMatch()
        check=checkPasswordLength()
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
        if(fbURLTF.text=="")
        {check=false}
        
        if(check==false)
        {
            createAlert(messagestring: "Please Fill All The Text Fields")
        }
        return check
        
        
    }
    func checkPasswordLength()->Bool
    {
        
        guard let Text=passordTF.text else
        {return false}
        if(Text.count<6)
        {createAlert(messagestring: "Password should contain more than 6 characters")
            return false}
        return true
        
    }
    
    
    func checkContactNo()->Bool
    {
        
        
        guard let phoneText=telTF.text else
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
         guard let tel=telTF.text else{return}
         guard let fburl=fbURLTF.text else{return}
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
                        
                        let user = Auth.auth().currentUser
                        if let user=user{
                            var refe: DatabaseReference!
                            
                            refe = Database.database().reference()
                            refe.child("User_Profiles").child(user.uid).setValue(["FirstName":fname,"LastName":lname,"ContactNumber":tel,"FBURL":fburl])
                            
                            self.clearFields()
                            self.createSuccessMessage()
                            
                            
                        }
                     
                        
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
        fbURLTF.text=""
        telTF.text=""
    }
    func createSuccessMessage()
    {
        let alertController = UIAlertController(title: "SUCCESS!!!", message:"Your account has been successfully registerd!!", preferredStyle: .alert)
        //alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            self.performSegue(withIdentifier: "seg2", sender: nil) }))
        self.present(alertController, animated: true, completion: nil)
    }

    func createAlert(messagestring:String)
    {
        let alertController = UIAlertController(title: "ERROR!!!", message:messagestring, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func setComponents()
    {
setButtonStyle(fieldname: fnameTF)
        setButtonStyle(fieldname: passordTF)
        setButtonStyle(fieldname: repeatpasswordTF)
        setButtonStyle(fieldname: fnameTF)
        setButtonStyle(fieldname: lnameTF)
        setButtonStyle(fieldname: telTF)
        setButtonStyle(fieldname: fbURLTF)
        setButtonStyle2(button: sbtn)
        setButtonStyle2(button: cbtn)
        setButtonStyle(fieldname: emailTF)
    }
    func setButtonStyle(fieldname:UITextField)
    {
        fieldname.layer.cornerRadius = 8.0
        fieldname.layer.masksToBounds = true
        fieldname.layer.borderColor = UIColor.blue.cgColor
        fieldname.layer.borderWidth = 2.0
    }
    
    func setButtonStyle2(button:UIButton)
    {
        button.layer.cornerRadius=8.0
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor.blue.cgColor
        button.layer.borderWidth = 2.0
        button.backgroundColor = UIColor.blue
        button.setTitleColor(.white, for: .normal)
        
    }

    

}
extension RegisterControllerViewController: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        self.profilePIC.image = image
    }
}

