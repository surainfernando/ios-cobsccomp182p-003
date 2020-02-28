//
//  LoginViewController.swift
//  NIBM-Event-App
//
//  Created by user161121 on 2/24/20.
//  Copyright © 2020 surainfdo. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase


class LoginViewController: UIViewController {

    @IBOutlet weak var testlabel: UILabel!
    @IBOutlet weak var EmailTextField: UITextField!
    
    @IBOutlet weak var PassWordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func LoginButtonAction(_ sender: Any) {
         segeueToHomeVIew()
//        let emailtxt=EmailTextField.text ?? "<no_name>"
//        let passwordtxt=PassWordTextField.text ?? "<no_name>"
//        checkIfEmailPresent(emailadress: emailtxt, password: passwordtxt)
        /*/ first this function checks if email exists .Then tne login function is called*/
    }
    
    @IBAction func ForgotPasswordAction(_ sender: Any) {
        testfunc1()
    }
    
    @IBAction func SignUpAction(_ sender: Any) {
    }
    
    
    
    
    
    /////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////
    
    /*Other UI Functions*/
    func createAlert(messagestring:String)
    {
        let alertController = UIAlertController(title: "LOGIN ERROR!!!", message:messagestring, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func segeueToHomeVIew()
    {
        performSegue(withIdentifier: "seg1", sender: nil)
    
    }
    
    
    func testfunc1()
    {print("testfunc1")
     //  testlabel.text="Email True"
        tesfunc2()
        print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
    }
    func tesfunc2()
    { testlabel.text="Email True"}
    
    
    func login(email:String,password:String)
    {
        Auth.auth().signIn(withEmail: email, password: password) {
            (user, error) in
            
            if error==nil{
                let user1 = Auth.auth().currentUser
                print("block1/1-----------------------------------")
                if let user1=user1 {
                    print("block2/1-----------------------------------")
                    // The user's ID, unique to the Firebase project.
                    // Do NOT use this value to authenticate with your backend server,
                    // if you have one. Use getTokenWithCompletion:completion: instead.
                    //                        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    //                        changeRequest?.displayName = "Surain FFF"
                    //                        changeRequest?.commitChanges { (error) in
                    //                            // ...
                    //                        }
                    //
                    print(user1.uid)
                    guard let hh=user1.displayName else{
                        return
                    }
                    print("User name is -----------------------------------00")
                    print(hh)
                     self.segeueToHomeVIew()
                    
                }
                
                
                
            }
            else{
                print("Password incorrect")
                self.createAlert(messagestring: "The password which you enterd is incorrect. Please try again.")
            }
        }
        
        
    }
    
    func checkIfEmailPresent(emailadress:String,password:String)
    {
        Auth.auth().fetchSignInMethods(forEmail: emailadress) { signInMethods, error in
            var check=true
            
            if ((error) != nil) {
                
                return
                // Handle error case.
            }
            
            guard let val=signInMethods else
            { print("Wrong Adress---------------------------------")
                self.createAlert(messagestring: "The email which you enterd is incorrect. Please try again")
                return
            }
           
            print("True Adress----ddddddddddddddddddddddddddddddddddddddddddddddddddddddddd")
            self.login(email: emailadress, password: password)
            print("Block 2----ddddddddddddddddddddddddddddddddddddddddddddddddddddddddd")
            
            
        }
        
    }
}
