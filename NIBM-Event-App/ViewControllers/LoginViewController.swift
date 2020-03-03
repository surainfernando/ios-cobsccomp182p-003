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
import LocalAuthentication
struct KeychainConfiguration {
    static let serviceName = "TouchMeIn"
    static let accessGroup: String? = nil
}



class LoginViewController: UIViewController {
    
    @IBOutlet weak var testlabel: UILabel!
    @IBOutlet weak var EmailTextField: UITextField!
    
    
    @IBOutlet weak var PassWordTextField: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var passwordBtn: UIButton!
    
    @IBOutlet weak var signBtn: UIButton!
    var passwordItems: [KeychainPasswordItem] = []
    let createLoginButtonTag = 0
    let loginButtonTag = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        let hasLogin = UserDefaults.standard.bool(forKey: "hasLoginKey")
        //
        //        // 2
        //        if hasLogin {
        //            loginButton.setTitle("Login", for: .normal)
        //            loginButton.tag = loginButtonTag
        //            createInfoLabel.isHidden = true
        //        } else {
        //            loginButton.setTitle("Create", for: .normal)
        //            loginButton.tag = createLoginButtonTag
        //            createInfoLabel.isHidden = false
        //        }
        //
        //        // 3
        //        if let storedUsername = UserDefaults.standard.value(forKey: "username") as? String {
        //            usernameTextField.text = storedUsername
        //        }
        signOUT()
        setAppearance()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func LoginButtonAction(_ sender: Any) {
        //segeueToHomeVIew()
        let emailtxt=EmailTextField.text ?? "<no_name>"
        let passwordtxt=PassWordTextField.text ?? "<no_name>"
        checkIfEmailPresent(emailadress: emailtxt, password: passwordtxt)
        /*/ first this function checks if email exists .Then tne login function is called*/
    }
    
    @IBAction func ForgotPasswordAction(_ sender: Any) {
        performSegue(withIdentifier: "forgotPasswordPath", sender: nil)
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
    
    
    func checkLogin(username: String, password: String) -> Bool {
        guard username == UserDefaults.standard.value(forKey: "username") as? String else {
            return false
        }
        
        do {
            let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName,
                                                    account: username,
                                                    accessGroup: KeychainConfiguration.accessGroup)
            let keychainPassword = try passwordItem.readPassword()
            return password == keychainPassword
        } catch {
            fatalError("Error reading password from keychain - \(error)")
        }
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
    func signOUT()
    {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    func setAppearance()
    {
        
        setButtonStyle(fieldname: EmailTextField)
        setButtonStyle(fieldname: PassWordTextField)
        setButtonStyle2(button: loginBtn)
        setButtonStyle2(button: passwordBtn)
        setButtonStyle2(button: signBtn)
        
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
