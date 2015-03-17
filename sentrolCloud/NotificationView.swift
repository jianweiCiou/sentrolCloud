//
//  NotificationScrollView.swift
//  sentrolCloud
//
//  Created by jianwei on 2015/3/3.
//  Copyright (c) 2015年 Nietzsche. All rights reserved.
//

import UIKit

class NotificationView: UIView {

    
    @IBOutlet weak var pushTitle: UIButton!
    @IBOutlet weak var emailTitle: UIButton!
    @IBOutlet weak var smsTitle: UIButton!
    
    
    
    // 漸層
    let gradientLayer = CAGradientLayer()
    let gradientLayer2 = CAGradientLayer()
    let gradientLayer3 = CAGradientLayer()
    
    class func instanceFromNib() -> NotificationView {
        
        return UINib(nibName: "NotificationView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as NotificationView
    }
    
    func initNotificationView(){
        
        //取消
        gradientLayer.frame = self.pushTitle.bounds
        gradientLayer.colors = [cgColorForRed(255, green: 255, blue: 255),
            cgColorForRed(133, green: 195, blue: 190),
            cgColorForRed(76, green: 136, blue: 136)]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        
        
        gradientLayer2.frame = self.emailTitle.bounds
        gradientLayer2.colors = [cgColorForRed(255, green: 255, blue: 255),
            cgColorForRed(133, green: 195, blue: 190),
            cgColorForRed(76, green: 136, blue: 136)]
        gradientLayer2.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer2.endPoint = CGPoint(x: 0, y: 1)
        
        
        gradientLayer3.frame = self.smsTitle.bounds
        gradientLayer3.colors = [cgColorForRed(255, green: 255, blue: 255),
            cgColorForRed(133, green: 195, blue: 190),
            cgColorForRed(76, green: 136, blue: 136)]
        gradientLayer3.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer3.endPoint = CGPoint(x: 0, y: 1)
        
        
//        pushTitle.layer.insertSublayer(gradientLayer, atIndex: 0)
//        emailTitle.layer.insertSublayer(gradientLayer2, atIndex: 0)
//        smsTitle.layer.insertSublayer(gradientLayer3, atIndex: 0)
//        
        
    
        
        
        //偵測旋轉
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "rotated", name: UIDeviceOrientationDidChangeNotification, object: nil)
        
    }
    
    
    
    //旋轉相關
    func rotated()
    {
        if(UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation))
        {//寬 s
//            gradientLayer.frame.size.width = self.frame.width
//            gradientLayer2.frame.size.width = self.frame.width
//            gradientLayer3.frame.size.width = self.frame.width
            
        }
        
        if(UIDeviceOrientationIsPortrait(UIDevice.currentDevice().orientation))
        {//長
//            gradientLayer.frame.size.width = self.frame.width
//            gradientLayer2.frame.size.width = self.frame.width
//            gradientLayer3.frame.size.width = self.frame.width
        }
        
        //檢查登入
        //goCheckLogInStatus()
        
    }
    
    
    
    func cgColorForRed(red: CGFloat, green: CGFloat, blue: CGFloat) -> AnyObject {
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0).CGColor as AnyObject
    }
    
    
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
