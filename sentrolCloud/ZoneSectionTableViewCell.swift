//
//  ZoneSectionTableViewCell.swift
//  sentrolCloud
//
//  Created by mac mini 4 nhr on 2015/3/10.
//  Copyright (c) 2015年 Nietzsche. All rights reserved.
//

import UIKit

class ZoneSectionTableViewCell: UITableViewCell {

    @IBOutlet var headerLabel: UILabel!
    
    
    @IBOutlet var icon: UIImageView!
    @IBOutlet var sectionBg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
