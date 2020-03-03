//
//  EventTableTableViewController.swift
//  NIBM-Event-App
//
//  Created by user161121 on 2/28/20.
//  Copyright © 2020 surainfdo. All rights reserved.
//

import UIKit
import Foundation
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class EventTableTableViewController: UITableViewController {
    var attractionImages=[String]()
    var attractionNames=[String]()
    var webAddresses=[String]()
    var tempTitle=[String]()
    var Descriptions=[String]()
    var Time=[String]()
    var Date=[String]()
    var Location=[String]()
    var  AttendanceCount=[String]()
    var IDOfEvent=[String]()
    var userId:String?
    var listOfEvents=[String]()
    var organizerID=[String]()
    var imageViewList=[UIImage]()
    var rowNumber:Int?
    
    
    var isLoadingViewController = false
    
    

    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isLoadingViewController = false
       // getEventsFromFireBase()
        //tableView.reloadData()
        self.title = "Events";
        setUserId()

        attractionNames=["Eifel","Dof","car","Dof","car","Dof","car","Dof","car","Dof","car","Dof","car23232323","Dof","car","Dof","car","Dof","car","Dof","car","Dof","car","Dof3444","car","Eifel"]
        webAddresses=["https://en.wikipedia.org/wiki/Eiffel_Tower","https://en.wikipedia.org/wiki/Dog","https://en.wikipedia.org/wiki/Cat","https://en.wikipedia.org/wiki/Dog","https://en.wikipedia.org/wiki/Cat","https://en.wikipedia.org/wiki/Dog","https://en.wikipedia.org/wiki/Cat","https://en.wikipedia.org/wiki/Dog","https://en.wikipedia.org/wiki/Cat","https://en.wikipedia.org/wiki/Dog","https://en.wikipedia.org/wiki/Cat","https://en.wikipedia.org/wiki/Dog","https://en.wikipedia.org/wiki/Cat","https://en.wikipedia.org/wiki/Eiffel_Tower"]
//        attractionImages=["360px-Tour_Eiffel_Wikimedia_Commons_(cropped).jpg","Collage_of_Nine_Dogs.jpg","1280px-Cat_poster_1.jpg","Collage_of_Nine_Dogs.jpg","1280px-Cat_poster_1.jpg","Collage_of_Nine_Dogs.jpg","1280px-Cat_poster_1.jpg","Collage_of_Nine_Dogs.jpg","1280px-Cat_poster_1.jpg","Collage_of_Nine_Dogs.jpg","1280px-Cat_poster_1.jpg","Collage_of_Nine_Dogs.jpg","1280px-Cat_poster_1.jpg","Collage_of_Nine_Dogs.jpg","1280px-Cat_poster_1.jpg","Collage_of_Nine_Dogs.jpg","1280px-Cat_poster_1.jpg","Collage_of_Nine_Dogs.jpg","1280px-Cat_poster_1.jpg","Collage_of_Nine_Dogs.jpg","1280px-Cat_poster_1.jpg","Collage_of_Nine_Dogs.jpg","1280px-Cat_poster_1.jpg","Collage_of_Nine_Dogs.jpg","1280px-Cat_poster_1.jpg","360px-Tour_Eiffel_Wikimedia_Commons_(cropped).jpg"]
    }
    
    

    // MARK: - Table view data source
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isLoadingViewController {
            isLoadingViewController = false
        } else {
            clearArray()
            getEventsFromFireBase()
        }
    }
    
    func clearArray()
    {
        attractionImages.removeAll()
        attractionNames.removeAll()
        webAddresses.removeAll()
        tempTitle.removeAll()
        Descriptions.removeAll()
        Time.removeAll()
        Date.removeAll()
        Location.removeAll()
        AttendanceCount.removeAll()
        IDOfEvent.removeAll()
        
        listOfEvents.removeAll()
        organizerID.removeAll()
        imageViewList.removeAll()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
      return tempTitle.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell", for: indexPath) as! EventTableViewCell
        let row=indexPath.row
        self.tableView.rowHeight = 128
        
        cell.title_label.text=tempTitle[row]
        cell.attendance_number_label.text="ATTENDANCE:"+AttendanceCount[row]
        cell.name1=IDOfEvent[row]
        cell.organizerId=organizerID[row]
        cell.ccontactCreatorButton.addTarget(self, action: #selector(viewCreatorInfo), for: .touchUpInside)
        cell.rowNo=row
     
        
        

        let storage = Storage.storage()
        let storageRef = storage.reference()
        let imagesRef = storageRef.child(attractionImages[row])
        imagesRef .getData(maxSize: 2 * 1024 * 1024) { data, error in
            if let error = error {
                print("Error BLOCK!--------------------------------------------")
                // Uh-oh, an error occurred!
            } else {
                // Data for "images/island.jpg" is returned
                let image = UIImage(data: data!)
                guard let image2=image else
                {print("]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]")
                    return}
                cell.ImageView1.image=image2
                self.imageViewList.append(image2)

            }
        }
        
        
        
        
        
        
        if listOfEvents.contains(IDOfEvent[row])
            
        {cell.goButton.setTitle("CANCEL ATENDANCE", for: .normal)
            cell.attendingEvent=true
        }
        else{
            cell.goButton.setTitle("CONFIRM ATTENDANCE", for: .normal)
            cell.attendingEvent=false
        }
        
        
     //   cell.name1=attractionNames[row]
     //   cell.ImageView1.image=UIImage(named:attractionImages[row])
        
        
        // Configure the cell...

        return cell
    }
    override func tableView(_ tableView:UITableView ,
                            trailingSwipeActionsConfigurationForRowAt indexPath:IndexPath)->
        UISwipeActionsConfiguration?{
            
            let configuration=UISwipeActionsConfiguration(actions:[
                UIContextualAction(style:
                    .destructive,title:"Delete",
                                 handler:{(action,
                                    view,completionHandler)in
                                    let row=indexPath.row
                                    self.attractionNames.remove(at:row)
                                    self.attractionImages.remove(at:row )
                                    //    self.webAddresses.remove(at:row)
                                    completionHandler(true)
                                    tableView.reloadData()
                } )
                ] )
            return configuration
    }
    override func prepare(for segue:UIStoryboardSegue,sender:Any?) {
        if(segue.identifier=="ShowCommentSegue")
        {let CommentsViewController=segue.destination as!
            CommentsViewController
            let myindexPath=self.tableView.indexPathForSelectedRow!
            let row=myindexPath.row
            print("row="+String(row))
            CommentsViewController.Event_ID=IDOfEvent[row]
        //    CommentsViewController.imageVariabel=imageViewList[row]
            
            
        }
        if(segue.identifier=="eventCreator")
        {let controller=segue.destination as!
            EventCreatorProfileController
            
           //let myindexPath=self.tableView.indexPathForSelectedRow!
           //let row=myindexPath.row
            print("block1.h2=oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooccc")
            print(rowNumber)
            guard let rowNumber=rowNumber else
            {return}
            controller.creatorId=organizerID[rowNumber]
            //
            
        }
        
        
    }
    @objc func viewCreatorInfo(_ sender: UIButton) {
        print("block1.1=ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo")
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: buttonPosition)
        let rowTemp=indexPath?.row
        guard let rowTemp1=rowTemp else
        {return }
        rowNumber=rowTemp1
       
    self.performSegue(withIdentifier: "eventCreator", sender: nil)
        
      
    }
    
    func getEventsFromFireBase()
    {
        var ref1: DatabaseReference!
        
        ref1 = Database.database().reference()
        //let myTopPostsQuery = ref.child("user-posts").queryOrdered(byChild: "starCount")
        let allPlaces=ref1.child("Events")
     allPlaces.observeSingleEvent(of: .value, with: { snapshot in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let placeDict = snap.value as! [String: Any]
                let title = placeDict["Title"] as! String
                self.tempTitle.append(title)
                let description=placeDict["Description"] as! String
                self.Descriptions.append(description)
                let date=placeDict["Date"] as! String
                self.Date.append(date)
                let starttime=placeDict["BeginTime"] as! String
                let endtime=placeDict["EndTime"] as! String
                let timestring="FROM \(starttime) TO \(endtime)"
                self.Time.append(timestring)
                let attendance=placeDict["People_Attending"] as!Int
                self.AttendanceCount.append(String(attendance))
                let id=snap.key as! String
                self.IDOfEvent.append(id)
                let organizerID1=placeDict["EventCreator"] as! String
                self.organizerID.append(organizerID1)
                let imagePath=placeDict["ImageString"] as! String
                self.attractionImages.append(imagePath)
                
                let storage = Storage.storage()
                let storageRef = storage.reference()
                let imagesRef = storageRef.child(imagePath)
                print("BLocck 1-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx")
//                imagesRef .getData(maxSize: 2 * 1024 * 1024) { data, error in
//                    if let error = error {
//                        print("Error BLOCK!--------------------------------------------")
//                        // Uh-oh, an error occurred!
//                    } else {
//                        // Data for "images/island.jpg" is returned
//                        let image = UIImage(data: data!)
//                        guard let image2=image else
//                        {print("]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]")
//                            return}
//                       self.imageViewList.append(image2)
//
//                    }
//                    ("BLocck 2-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx")
//                }
                ("BLocck 3-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx")

                
                
                
                
                
                
                
                
                
             
            }
        print("---------------------------------------------------------------------")
         print("---------------------------------------------------------------------")
        //print(self.tempTitle[0])
         self.tableView.reloadData()
        })
        
        let user1 = Auth.auth().currentUser
        if let user1=user1{
           let userId1=user1.uid
            let userListOfAttendingEvents=ref1.child("Users/\(userId1)")
                print("blocl1 @--------------------------------------------------------------------")
            userListOfAttendingEvents.observeSingleEvent(of: .value, with: { snapshot in
                print("block 22-@--------------------------------------------------------------------")
                for child in snapshot.children {
                    print("block 33-@--------------------------------------------------------------------")
                    let snap = child as! DataSnapshot
                    print("block 44-@--------------------------------------------------------------------")
                    
                    let key1 = snap.key
                    let value = snap.value
                    print("Eventtttttttttttttttttttttttttttttttttttt")
                    self.listOfEvents.append(key1)
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                }
                print("tyu---------------------------------------------------------------------")
                print("---------------------------------------------------------------------")
               // print(self.tempTitle[0])
                 self.tableView.reloadData()
            })
            
            
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    func setUserId()
    {
        let user1 = Auth.auth().currentUser
        if let user1=user1 {
            userId=user1.uid
            
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
