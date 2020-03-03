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
import FirebaseStorage

class CommentsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
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
    var imagePath:String?
    var imageVariabel:UIImage?
    
    
    var animal=["dog","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt"]
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextView()
        tableView.dataSource=self
        tableView.delegate=self
        tableView.rowHeight=130
        clearArray()
        getEventsFromFireBase()
        setlabels()
       // setImage()
       
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
    func setImage()
    { print("1.1 ]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]")

        guard let imagepath=imagePath else
    {return}
        let storage = Storage.storage()
                let storageRef = storage.reference()
                let imagesRef = storageRef.child(imagepath)
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
                        print("]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]")

                 self.imageView.image=image2
        
                    }
                }
        
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
    
    func setlabels()
    {
        var ref: DatabaseReference!
        guard let Event_ID=Event_ID else
    {return }
        ref = Database.database().reference()
        ref.child("Events").child(Event_ID).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let title = value?["Title"] as? String ?? ""
            self.titleLabel.text=title
            let description=value?["Description"] as? String ?? ""
            self.descriptionLabel.text=description
            let btime=value?["BeginTime"] as? String ?? ""
            let etime=value?["EndTime"] as? String ?? ""
            self.timerangelabel.text="From"+" "+btime+" To"+" "+etime
            self.locationLabel.text="Location"
            let imageString1=value?["ImageString"] as? String ?? ""
            self.display(imageString: imageString1)
           
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        
        
    }
    func clearArray()
    {
        commentList.removeAll()
        uidList.removeAll()
        nameList.removeAll()
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
            textView.text=""
            getEventsFromFireBase()
            
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
