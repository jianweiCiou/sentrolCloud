//
//  MessageTableViewCell.swift
//  sentrolCloud
//
//  Created by mac mini 4 nhr on 2015/3/16.
//  Copyright (c) 2015年 Nietzsche. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    //        {"MessageListArray": [
    //            {
    //            "title":"Sentrolcloud",
    //            "time":"23:10 01/01 2015",
    //            "message":"SentrolcloudMessageSentrolcloudMessageSentrolcloudMessage",
    //            "status":"r"
    //            }
    
    @IBOutlet var title: UILabel!
    @IBOutlet var time: UILabel!
    @IBOutlet var message: UITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
