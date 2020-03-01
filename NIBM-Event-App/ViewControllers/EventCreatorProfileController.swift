//
//  EventCreatorProfileController.swift
//  NIBM-Event-App
//
//  Created by user161121 on 3/1/20.
//  Copyright © 2020 surainfdo. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage


class EventCreatorProfileController: UIViewController {
    var creatorId:String?
    
    @IBOutlet weak var fnameLabel: UILabel!
    
    @IBOutlet weak var lnameLabel: UILabel!
    @IBOutlet weak var telLabel: UILabel!
    
    @IBOutlet weak var fblLbel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
setLabelValues()
        // Do any additional setup after loading the view.
    }
    
    func tempPrint()
    {
    print("7777777777777777777777777777777777777777777777777777777777ppp")
        if  let creatorId1 = creatorId{
            print(creatorId1)
        }
    }
    
    func setLabelValues()
    {
        
        if  let creatorId1 = creatorId{
            var ref: DatabaseReference!
            
            ref = Database.database().reference()
            print(creatorId1)
            ref.child("User_Profiles").child(creatorId1).observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                let value = snapshot.value as? NSDictionary
                let fname = value?["FirstName"] as? String ?? ""
                self.fnameLabel.text=fname
                let lname = value?["LastName"] as? String ?? ""
                self.lnameLabel.text=lname
                let urls = value?["FBURL"] as? String ?? ""
                self.fblLbel.text=urls
                let tel = value?["ContactNumber"] as? String ?? ""
                self.telLabel.text=tel
                
                
                
                
                
                
                
                
            }) { (error) in
                print(error.localizedDescription)
            }
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
