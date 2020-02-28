//
//  temptestViewController.swift
//  NIBM-Event-App
//
//  Created by user161121 on 2/27/20.
//  Copyright © 2020 surainfdo. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase


class temptestViewController: UIViewController {

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var imageView1: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func tempbutton(_ sender: Any) {
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("UP").child("roxyhj").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            if let snapDict = snapshot.value as? [String:AnyObject] {
                if let name=snapDict["tel"] as? [String:Any]{
                    var k=name
                  
                }
            }
            
            
            
        }) { (error) in
            print(error.localizedDescription)
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
