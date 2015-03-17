//
//  ZoneTableViewCell.swift
//  sentrolCloud
//
//  Created by mac mini 4 nhr on 2015/3/10.
//  Copyright (c) 2015年 Nietzsche. All rights reserved.
//

import UIKit

class ZoneTableViewCell: UITableViewCell {

    
    @IBOutlet var type: UILabel!
    @IBOutlet var name: UILabel!
    
    @IBOutlet var icon: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func editName(sender: AnyObject) {
        let alert = UIAlertView()
        //let textField = alert.textFieldAtIndex(0)
        // textField.placeholder = "Foo!"
        
        alert.delegate = self
        alert.title = "Edit"
        alert.alertViewStyle = UIAlertViewStyle.PlainTextInput
        
        
        //alert.textFieldAtIndex(0)?.
        
        alert.message = "Enter new name"
        alert.addButtonWithTitle("Ok")
        alert.addButtonWithTitle("Cancelled")
        alert.show()
        
        
    }
    
    
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
