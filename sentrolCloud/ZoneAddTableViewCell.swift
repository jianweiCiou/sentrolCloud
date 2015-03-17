//
//  ZoneAddTableViewCell.swift
//  sentrolCloud
//
//  Created by mac mini 4 nhr on 2015/3/10.
//  Copyright (c) 2015年 Nietzsche. All rights reserved.
//

import UIKit

protocol ZoneAddTableViewCellProtocol{

    func saveClassification(name:String)
    func makeAlert(message: String)
    
    func openImagePicker()
    
}


class ZoneAddTableViewCell: UITableViewCell {

    
    var delegate:ZoneAddTableViewCellProtocol?
    var dataSource:ZoneAddTableViewCellProtocol?
    
    @IBOutlet weak var newNameTF: UITextField!
    
    
    
    @IBAction func saveClassification(sender: AnyObject) {
        
        
        
        let str = newNameTF.text as String
        let count:Int = countElements(str)
        
//        println(count)
//        
//        if(count == 0 ){
//            return
//        }
        
        if(count == 0){
            
            self.delegate?.makeAlert("Add Name !")
            
        }else if(count > 12){
            
            self.delegate?.makeAlert("Limited by 12 letters !")
            
        }else{
            
            self.delegate?.saveClassification(str)
            newNameTF.text = ""
        }
        
        
    }
    
    
    @IBAction func openAlbum(sender: AnyObject) {
        
        self.delegate?.openImagePicker()
        
        
    }
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.clearColor()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
  

}
