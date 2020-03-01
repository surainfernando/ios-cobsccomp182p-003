//
//  ResetPasswordContrller.swift
//  NIBM-Event-App
//
//  Created by user161121 on 2/29/20.
//  Copyright © 2020 surainfdo. All rights reserved.
//

import UIKit
import FirebaseAuth

class ResetPasswordContrller: UIViewController {

    @IBOutlet weak var emailTextView: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func ResetPasswordAction(_ sender: Any) {
        guard let email=emailTextView.text else
        {return}
        if (email=="")
        {createAlert(messagestring: "Please fill the email text field")
            return}
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            
            if(error==nil)
            {
                self.emailTextView.text=""
                //self.createSuccessMessage()
                //self.gotoPreviousPage()
                self.createSuccessMessage()
            }
            else{
                self.createAlert(messagestring: "Please enter a valid email address")
                return
            }
            
          
        }
        
        
    }
    func  createAlert(messagestring:String)
    {
        let alertController = UIAlertController(title: "ERROR!!!", message:messagestring, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func createSuccessMessage()
    {
        let alertController = UIAlertController(title: "SUCCESS!!!", message:"An email has been sent to your account. Please follow the instructions to complete the password reset process", preferredStyle: .alert)
        //alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
          self.gotoPreviousPage() }))
            self.present(alertController, animated: true, completion: nil)
    }
    func gotoPreviousPage()
    {
        performSegue(withIdentifier: "loginPath", sender: nil)
    }
    
    
    @IBAction func backButtonAction(_ sender: Any) {
        gotoPreviousPage()
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
