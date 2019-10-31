//
//  PostsTableViewCell.swift
//  MiniFacebook
//
//  Created by DEVG-ODI-2552 on 29/10/2019.
//  Copyright © 2019 AWS, Inc. All rights reserved.
//

import UIKit

class PostsTableViewCell: UITableViewCell {
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
