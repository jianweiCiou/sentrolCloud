//
//  DashTableViewCell.swift
//  sentrolCloud
//
//  Created by jianwei on 2015/3/5.
//  Copyright (c) 2015年 Nietzsche. All rights reserved.
//

import UIKit

class DashTableViewCell: UITableViewCell {

    @IBOutlet var type: UILabel!
    @IBOutlet var name: UILabel!
    
    @IBOutlet var icon: UIImageView!
    
    @IBOutlet var cameraView: UIImageView!
    
    
    //溫度
    @IBOutlet var numberTemp: UILabel!
    @IBOutlet var numberView: UIView!
    
    //濕度
    @IBOutlet var dumidityView: UIView!
    @IBOutlet var dumidityNumber: UILabel!
    
    
    
    
    
    
    @IBOutlet var statusImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
