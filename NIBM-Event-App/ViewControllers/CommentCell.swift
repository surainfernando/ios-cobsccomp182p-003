//
//  CommentCell.swift
//  NIBM-Event-App
//
//  Created by user161121 on 2/29/20.
//  Copyright © 2020 surainfdo. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {

    @IBOutlet weak var labelComment: UILabel!
    @IBOutlet weak var commentBodyLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        uiReconfiguration()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func uiReconfiguration()
    {
        commentBodyLabel.sizeToFit()
    }
    

}
