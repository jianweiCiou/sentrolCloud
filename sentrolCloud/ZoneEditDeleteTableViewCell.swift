//
//  ZoneEditDeleteTableViewCell.swift
//  sentrolCloud
//
//  Created by mac mini 4 nhr on 2015/3/11.
//  Copyright (c) 2015年 Nietzsche. All rights reserved.
//

import UIKit

protocol ZoneEditDeleteTableViewCellProtocol{

    func checkIfDeeleteClassification(name:String)
    
    func editNewClassName(name:String, oldName:String)

}


class ZoneEditDeleteTableViewCell: UITableViewCell {

    @IBOutlet var headerLabel: UILabel!
    
    
    @IBOutlet var icon: UIImageView!
    
    
    
    
    var delegate:ZoneEditDeleteTableViewCellProtocol?
    var dataSource:ZoneEditDeleteTableViewCellProtocol?
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    //刪除
    @IBAction func deleteSectionName(sender: AnyObject) {
        
        delegate?.checkIfDeeleteClassification(headerLabel.text!)
    }
    
    //編輯名稱
    @IBAction func editSectionName(sender: AnyObject) {
        
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
    
    
    func alertView(View: UIAlertView!, clickedButtonAtIndex buttonIndex: Int){
        
        let textField = View.textFieldAtIndex(0)
        var newName = textField?.text
        
        if(newName == ""){
         return
        }
        
        switch buttonIndex{
        case 0:
            delegate?.editNewClassName(newName!, oldName: headerLabel.text!)
            break;
        default:
            break;
        }
    }
    
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
