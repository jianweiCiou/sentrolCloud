//
//  SettimgSectionTableViewCell.swift
//  sentrolCloud
//
//  Created by mac mini 4 nhr on 2015/3/9.
//  Copyright (c) 2015年 Nietzsche. All rights reserved.
//

import UIKit

class SettimgSectionTableViewCell: UITableViewCell {

    
    @IBOutlet var headerLabel: UILabel!
    
    //@IBOutlet var bgView: UIView!
    
    @IBOutlet var icon: UIImageView!
    
    
    //漸層光澤
    let gradientLayer = CAGradientLayer()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
//        gradientLayer.frame = self.bgView.bounds
//        gradientLayer.colors = [cgColorForRed(255, green: 255, blue: 255),
//            cgColorForRed(133, green: 195, blue: 190),
//            cgColorForRed(76, green: 136, blue: 136)]
//        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
//        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
//        self.bgView.layer.addSublayer(gradientLayer)
//        self.bgView.alpha = 0.9
        // Initialization code
    }
    
    
    
    func cgColorForRed(red: CGFloat, green: CGFloat, blue: CGFloat) -> AnyObject {
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0).CGColor as AnyObject
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
