//
//  ViewController.swift
//  NIBM-Event-App
//
//  Created by user161121 on 2/24/20.
//  Copyright © 2020 surainfdo. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func functemp(_ sender: Any) {
        readData()
    }
    func readData()
    {
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("UP").child("roxyhj").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            if let snapDict = snapshot.value as? [String:AnyObject] {
                if let name=snapDict["tel"] as? [String:Any]{
                    if let name2=name["wifi"] as? [String:Any]{
                        if let name3=name2["idad"] as? [String:Any]{
                            if let name4=name3["name"] as? String{
                               print(name4)
                            }
                        }
                    }
                }
            }
            
            
            //                for child in snapDict{
            //
            //                    let shotKey = snapshot.children.nextObject() as! DataSnapshot
            //
            //                    if let name = child.value as? [String:AnyObject]{
            //
            //                        var _name = name["locationName"]
            //
            //                    }
            //
            //                }
            
            
            
            
            
            
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
}

