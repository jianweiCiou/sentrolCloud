//
//  EventTableViewCell.swift
//  sentrolCloud
//
//  Created by mac mini 4 nhr on 2015/3/13.
//  Copyright (c) 2015年 Nietzsche. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    
    
    
    @IBOutlet var device: UILabel!
    
    @IBOutlet var event: UILabel!
    
    @IBOutlet var room: UILabel!
    
    @IBOutlet var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
