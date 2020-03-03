//
//  EventTableViewCell.swift
//  NIBM-Event-App
//
//  Created by user161121 on 2/28/20.
//  Copyright © 2020 surainfdo. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase


class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var ImageView1: UIImageView!
    @IBOutlet weak var title_label: UILabel!
    
    @IBOutlet weak var description_label: UILabel!
    
    @IBOutlet weak var date_label: UILabel!
    @IBOutlet weak var timerange_label: UILabel!
    
    @IBOutlet weak var attendance_number_label: UILabel!
    @IBOutlet weak var ccontactCreatorButton: UIButton!
    
    @IBOutlet weak var goButton: UIButton!
    var name1:String?
    var idOfEvent:Int?
    var attendingEvent:Bool?
    var organizerId:String?
    var rowNo:Int?
    var buttonAction: ((Any) -> Void)?
    
    @objc func viewCreatorInfo(sender: Any) {
        self.buttonAction?(sender)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    @IBAction func changeAttendanceAction(_ sender: Any) {
        guard let attendingEvent=attendingEvent else
        {return}
        let user1 = Auth.auth().currentUser
        guard let EventId=name1 else
        {return }
        
        if(attendingEvent)
        {
            if let user1=user1 {
                let userId=user1.uid
                let ref = Database.database().reference()
                
                let usersattendacelistreference=ref.child("Users/\(userId)").child(EventId)
                usersattendacelistreference.removeValue()
                
                let Eventattendacelist=ref.child("AttedndanceList/\(EventId)").child(userId)
               Eventattendacelist.removeValue()
                
                ref.child("Events/\(EventId)").observeSingleEvent(of: .value, with: { (snapshot) in
                    // Get user value
                    
                    if let snapDict = snapshot.value as? [String:AnyObject] {
                        
                        let attendancecount=snapDict["People_Attending"] as! Int
                        print("Attendance count@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
                        print(String(attendancecount))
                        var attendancecount1=attendancecount-1
                        ref.child("Events/\(EventId)/People_Attending").setValue(attendancecount1)
                        self.attendance_number_label.text="ATTENDANCE:"+String(attendancecount1)
                        self.goButton.setTitle("CONFIRM ATTENDANCE", for: .normal)
                    self.goButton.backgroundColor = UIColor.green
                        self.attendingEvent=false
                        
                    }
                    
                    // ...
                }) { (error) in
                    print(error.localizedDescription)
                }
                
              

                
            }
        }
            
        else{
            if let user1=user1 {
                
                let userId=user1.uid
                let ref = Database.database().reference()
                ref.child("AttedndanceList/\(EventId)/\(userId)").setValue("")
                ref.child("Users/\(userId)/\(EventId)").setValue("")
                ref.child("Events/\(EventId)").observeSingleEvent(of: .value, with: { (snapshot) in
                    // Get user value
                    
                    if let snapDict = snapshot.value as? [String:AnyObject] {
                        
                        let attendancecount=snapDict["People_Attending"] as! Int
                        print("Attendance count@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
                        print(String(attendancecount))
                        var attendancecount1=attendancecount+1
                        ref.child("Events/\(EventId)/People_Attending").setValue(attendancecount1)
                        self.attendance_number_label.text="ATTENDANCE:"+String(attendancecount1)
                         self.goButton.setTitle("CANCEL ATTENDANCE", for: .normal)
                         self.goButton.backgroundColor = UIColor.red
                        self.attendingEvent=true
                        
                    }
                    
                    // ...
                }) { (error) in
                    print(error.localizedDescription)
                }
                
                
                
                
                
                
            }
            
        }
        
        
        
        
        
        
    }
    
    @IBAction func contactOrganizerAction(_ sender: Any) {
        
    }
    
    @IBAction func viewCommentsAction(_ sender: Any) {
        guard let name1=name1 else
        {return }
        print(name1)
        print("-----------------------------------------------------")
        print("-----------------------------------------------------")
    }
    
}
