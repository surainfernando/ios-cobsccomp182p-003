//
//  CommentsViewController.swift
//  NIBM-Event-App
//
//  Created by user161121 on 2/28/20.
//  Copyright © 2020 surainfdo. All rights reserved.
//

import UIKit
import QuartzCore
import FirebaseAuth
import FirebaseDatabase

class CommentsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var timerangelabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    var commentList=[String]()
    var uidList=[String]()
    var nameList=[String]()
    
    var Event_ID:String?
    var titleString:String?
    var descriptionString:String?
    var dateString:String?
    var hourString:String?
    
    var animal=["dog","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt"]
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextView()
        tableView.dataSource=self
        tableView.delegate=self
        tableView.rowHeight=130
        getEventsFromFireBase()
        //  label2.text=Event_ID
        
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell=tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
        cell.labelComment!.text=nameList[indexPath.row]
        cell.commentBodyLabel!.text=commentList[indexPath.row]
        cell.commentBodyLabel.sizeToFit()
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
   
    @IBAction func buttontemp(_ sender: Any) {
        titleLabel.text="kell"
    }
    
    
    //@IBOutlet weak var label2: UILabel!
    
    
    
    
    
    @IBAction func postCommentAction(_ sender: Any) {
        if(textView.text=="")
        {
            createAlert(messagestring: "Please Enter A Comment In THe Comment Text Field")
            return
        }
        guard let text=textView.text else
        {return}
        guard let  Event_ID=Event_ID else
        {return}
        
        let user=Auth.auth().currentUser
        if let user=user{
            
            let uid = user.uid
            let dname=user.displayName
            print(uid)
            var ref = Database.database().reference()
            ref.child("Comments/\(Event_ID)").childByAutoId().setValue(["UID":uid,"DisplayName":dname,"Comment":text])
            
        }
        
        
        
    }
    
    func  createAlert(messagestring:String)
    {
        let alertController = UIAlertController(title: "ERROR!!!", message:messagestring, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
    }
    func getEventsFromFireBase()
    {
        guard let  Event_ID=Event_ID else
        {return}
        
        var ref1: DatabaseReference!
        
        ref1 = Database.database().reference()
        //let myTopPostsQuery = ref.child("user-posts").queryOrdered(byChild: "starCount")
        let allPlaces=ref1.child("Comments/\(Event_ID)")
        allPlaces.observeSingleEvent(of: .value, with: { snapshot in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let placeDict = snap.value as! [String: Any]
                let comment = placeDict["Comment"] as! String
                self.commentList.append(comment)
                let name = placeDict["DisplayName"] as! String
                self.nameList.append(name)
                let userid=placeDict["UID"] as! String
                self.uidList.append(userid)
                
           
                
                
            }
           // print("---------------------------------------------------------------------")
            //print("---------------------------------------------------------------------")
          
            self.tableView.reloadData()
        })
        
      
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    
  
    func setupTextView()
    {
        textView.layer.borderColor = UIColor.darkGray.withAlphaComponent(0.5).cgColor
        textView.layer.borderWidth = 0.5
        textView.clipsToBounds = true
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
