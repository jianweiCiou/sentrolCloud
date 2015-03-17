//
//  GeneralTableViewCell.swift
//  sentrolCloud
//
//  Created by jianwei on 2015/3/3.
//  Copyright (c) 2015年 Nietzsche. All rights reserved.
//

import UIKit

class GeneralTableViewCell: UITableViewCell {

    @IBOutlet var type: UILabel!
    
    @IBOutlet var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
     
    
}
