//
//  UserProfileViewController.swift
//  NIBM-Event-App
//
//  Created by user161121 on 3/1/20.
//  Copyright © 2020 surainfdo. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class UserProfileViewController: UIViewController {

    @IBOutlet weak var emaillabel: UILabel!
    @IBOutlet weak var namelabel: UILabel!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setLabels()
        self.title = "Name me!";

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        
        signOUT()
    }
    
    func signOUT()
    {
        self.performSegue(withIdentifier: "backToLogin", sender: nil)
    }
   
    func setLabels()
    {let user1 = Auth.auth().currentUser
        if let user1=user1 {
            // The user's ID, unique to the Firebase project.
            // Do NOT use this value to authenticate with your backend server,
            // if you have one. Use getTokenWithCompletion:completion: instead.
            let uid = user1.uid
           
            var ref = Database.database().reference()
            ref.child("User_Profiles").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                let value = snapshot.value as? NSDictionary
                let fname = value?["FirstName"] as? String ?? ""
                let lname=value?["LastName"] as? String ?? ""
                let name=fname+" "+lname
                let tel = value?["ContactNumber"] as? String ?? ""
              self.emaillabel.text=tel
             self.namelabel.text=name
                
                
                
                
                
                
                
            }) { (error) in
                print(error.localizedDescription)
            }
            
            
            
            // ...
        }
        
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
