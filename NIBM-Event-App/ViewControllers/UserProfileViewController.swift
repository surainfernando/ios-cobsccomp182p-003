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
import FirebaseStorage

class UserProfileViewController: UIViewController {

    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var emaillabel: UILabel!
    @IBOutlet weak var namelabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setLabels()
        setButtonStyle2(button: logoutButton)
        
     

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        
        signOUT()
    }
    
    func signOUT()
    {
        self.performSegue(withIdentifier: "backToLogin", sender: nil)
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
    
    func display(imageString:String) {
        
        let storage = Storage.storage()
       
        let storageRef = storage.reference()
        let mountainImagesRef = storageRef.child(imageString)
        mountainImagesRef .getData(maxSize: 2 * 1024 * 1024) { data, error in
            if let error = error {
                print("Error BLOCK!--------------------------------------------")
                // Uh-oh, an error occurred!
            } else {
                // Data for "images/island.jpg" is returned
                let image = UIImage(data: data!)
                guard let image2=image else
                {print("]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]")
                    return}
                self.imageView.image=image2
            }
        }
        
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
                let imageString=value?["ProfilePic"] as? String ?? ""
                self.display(imageString: imageString)
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
