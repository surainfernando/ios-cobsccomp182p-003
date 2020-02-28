//
//  EventTableTableViewController.swift
//  NIBM-Event-App
//
//  Created by user161121 on 2/28/20.
//  Copyright © 2020 surainfdo. All rights reserved.
//

import UIKit

class EventTableTableViewController: UITableViewController {
    var attractionImages=[String]()
    var attractionNames=[String]()
    var webAddresses=[String]()
    override func viewDidLoad() {
        super.viewDidLoad()

        attractionNames=["Eifel","Dof","car","Dof","car","Dof","car","Dof","car","Dof","car","Dof","car23232323","Dof","car","Dof","car","Dof","car","Dof","car","Dof","car","Dof3444","car","Eifel"]
        webAddresses=["https://en.wikipedia.org/wiki/Eiffel_Tower","https://en.wikipedia.org/wiki/Dog","https://en.wikipedia.org/wiki/Cat","https://en.wikipedia.org/wiki/Dog","https://en.wikipedia.org/wiki/Cat","https://en.wikipedia.org/wiki/Dog","https://en.wikipedia.org/wiki/Cat","https://en.wikipedia.org/wiki/Dog","https://en.wikipedia.org/wiki/Cat","https://en.wikipedia.org/wiki/Dog","https://en.wikipedia.org/wiki/Cat","https://en.wikipedia.org/wiki/Dog","https://en.wikipedia.org/wiki/Cat","https://en.wikipedia.org/wiki/Eiffel_Tower"]
        attractionImages=["360px-Tour_Eiffel_Wikimedia_Commons_(cropped).jpg","Collage_of_Nine_Dogs.jpg","1280px-Cat_poster_1.jpg","Collage_of_Nine_Dogs.jpg","1280px-Cat_poster_1.jpg","Collage_of_Nine_Dogs.jpg","1280px-Cat_poster_1.jpg","Collage_of_Nine_Dogs.jpg","1280px-Cat_poster_1.jpg","Collage_of_Nine_Dogs.jpg","1280px-Cat_poster_1.jpg","Collage_of_Nine_Dogs.jpg","1280px-Cat_poster_1.jpg","Collage_of_Nine_Dogs.jpg","1280px-Cat_poster_1.jpg","Collage_of_Nine_Dogs.jpg","1280px-Cat_poster_1.jpg","Collage_of_Nine_Dogs.jpg","1280px-Cat_poster_1.jpg","Collage_of_Nine_Dogs.jpg","1280px-Cat_poster_1.jpg","Collage_of_Nine_Dogs.jpg","1280px-Cat_poster_1.jpg","Collage_of_Nine_Dogs.jpg","1280px-Cat_poster_1.jpg","360px-Tour_Eiffel_Wikimedia_Commons_(cropped).jpg"]
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
      return attractionNames.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell", for: indexPath) as! EventTableViewCell
        let row=indexPath.row
        cell.Label1.text=attractionNames[row]
        cell.ImageView1.image=UIImage(named:attractionImages[row])
        
        
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
