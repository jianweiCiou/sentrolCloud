//
//  DashSectionTableViewCell.swift
//  sentrolCloud
//
//  Created by jianwei on 2015/3/5.
//  Copyright (c) 2015年 Nietzsche. All rights reserved.
//

import UIKit

class DashSectionTableViewCell: UITableViewCell {

    @IBOutlet var headerLabel: UILabel!
    
    //@IBOutlet var bgView: UIView!
    
    @IBOutlet var icon: UIImageView!
    
    
    //漸層光澤
    let gradientLayer = CAGradientLayer()
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //self.bgView.layer.addSublayer(gradientLayer)
    }
    
    func cgColorForRed(red: CGFloat, green: CGFloat, blue: CGFloat) -> AnyObject {
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0).CGColor as AnyObject
    }
    
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
