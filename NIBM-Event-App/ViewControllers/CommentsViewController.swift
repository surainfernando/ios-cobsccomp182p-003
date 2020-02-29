//
//  CommentsViewController.swift
//  NIBM-Event-App
//
//  Created by user161121 on 2/28/20.
//  Copyright © 2020 surainfdo. All rights reserved.
//

import UIKit
import QuartzCore

class CommentsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textView: UITextView!
    var Event_ID:String?
   var animal=["dog","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt","cat","serpamt"]
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextView()
        tableView.dataSource=self
        tableView.delegate=self
        //  label2.text=Event_ID
        
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animal.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell=tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
        cell.labelComment!.text=animal[indexPath.row]
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
   
    @IBAction func buttontemp(_ sender: Any) {
        titleLabel.text="kell"
    }
    
    
    //@IBOutlet weak var label2: UILabel!
  
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
