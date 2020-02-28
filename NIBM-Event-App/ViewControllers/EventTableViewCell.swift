//
//  EventTableViewCell.swift
//  NIBM-Event-App
//
//  Created by user161121 on 2/28/20.
//  Copyright © 2020 surainfdo. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var ImageView1: UIImageView!
    @IBOutlet weak var title_label: UILabel!
    
    @IBOutlet weak var description_label: UILabel!
    
    @IBOutlet weak var date_label: UILabel!
    @IBOutlet weak var timerange_label: UILabel!
    
    @IBOutlet weak var attendance_number_label: UILabel!
    var name1:String?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    @IBAction func changeAttendanceAction(_ sender: Any) {
    }
    
    @IBAction func contactOrganizerAction(_ sender: Any) {
    }
    
    @IBAction func viewCommentsAction(_ sender: Any) {
    }
}
