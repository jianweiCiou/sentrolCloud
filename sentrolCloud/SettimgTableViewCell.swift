//
//  SettimgTableViewCell.swift
//  sentrolCloud
//
//  Created by mac mini 4 nhr on 2015/3/9.
//  Copyright (c) 2015年 Nietzsche. All rights reserved.
//

import UIKit

class SettimgTableViewCell: UITableViewCell {

//    required init(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

    @IBOutlet var type: UILabel!
    @IBOutlet var name: UILabel!
    
    @IBOutlet var icon: UIImageView!
    
    
    //資料
    var cellDataArray: NSDictionary = [String:AnyObject]()
    
    
    //3顆星星
    @IBOutlet weak var homeStar: UIButton!
    @IBOutlet weak var awayStar: UIButton!
    @IBOutlet weak var nightStar: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    func cellMessage(dict:NSDictionary){
        
        
        var typeName :String = dict.valueForKey("type") as String
        self.type.text = dict.valueForKey("type") as? String
        self.name.text = dict.valueForKey("name") as? String
        self.icon.image = UIImage(named: "icon_\(typeName).png")
        
        //遠離
        var awayStat:Int = dict.valueForKey("away") as Int
        if(awayStat == 0){
            awayStar.setImage((UIImage(named: "modleSelect-no.png")), forState: .Normal)
        }else{
            awayStar.setImage((UIImage(named: "modleSelect-yes.png")), forState: .Normal)
        }
       
        //居家
        var homeStat:Int = dict.valueForKey("home") as Int
        if(homeStat == 0){
            homeStar.setImage((UIImage(named: "modleSelect-no.png")), forState: .Normal)
        }else{
            homeStar.setImage((UIImage(named: "modleSelect-yes.png")), forState: .Normal)
        }
        
        //晚間
        var nightStat:Int = dict.valueForKey("night") as Int
        if(nightStat == 0){
            nightStar.setImage((UIImage(named: "modleSelect-no.png")), forState: .Normal)
        }else{
            nightStar.setImage((UIImage(named: "modleSelect-yes.png")), forState: .Normal)
        }
        
        
//        
//        "away":0,
//        "night":1,
//        "home":1
        
    
    }
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
