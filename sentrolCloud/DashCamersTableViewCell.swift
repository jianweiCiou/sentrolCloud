//
//  DashCamersTableViewCell.swift
//  sentrolCloud
//
//  Created by mac mini 4 nhr on 2015/3/13.
//  Copyright (c) 2015年 Nietzsche. All rights reserved.
//

import UIKit

class DashCamersTableViewCell: UITableViewCell {

    @IBOutlet var type: UILabel!
    @IBOutlet var name: UILabel!
    
    @IBOutlet var icon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
