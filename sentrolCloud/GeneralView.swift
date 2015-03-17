//
//  GeneralView.swift
//  sentrolCloud
//
//  Created by jianwei on 2015/3/3.
//  Copyright (c) 2015年 Nietzsche. All rights reserved.
//

import UIKit

class GeneralView: UIView {

    @IBOutlet var dismissBtn: UIButton!
    
    @IBOutlet weak var confirmBtn: UIButton!
    
    @IBOutlet weak var cancelBtn: UIButton!
    
    // 漸層
    let gradientConfirmBtnLayer = CAGradientLayer()
    let gradientCancelBtnBtnLayer = CAGradientLayer()
    
    class func instanceFromNib() -> GeneralView {
        
        return UINib(nibName: "GeneralView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as GeneralView
    }
    
    func initGeneral(){
        
        //確認
        gradientConfirmBtnLayer.frame = self.confirmBtn.bounds
        gradientConfirmBtnLayer.colors = [cgColorForRed(132, green: 217, blue: 26),
            cgColorForRed(14, green: 81, blue: 31)]
        gradientConfirmBtnLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientConfirmBtnLayer.endPoint = CGPoint(x: 0, y: 1)
        confirmBtn.layer.insertSublayer(gradientConfirmBtnLayer, atIndex: 0)
        confirmBtn.layer.cornerRadius = 5
        confirmBtn.layer.masksToBounds = true
        
        //取消
        gradientCancelBtnBtnLayer.frame = self.confirmBtn.bounds
        gradientCancelBtnBtnLayer.colors = [cgColorForRed(188, green: 188, blue: 188),cgColorForRed(144, green: 144, blue: 144)
            ]
        gradientCancelBtnBtnLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientCancelBtnBtnLayer.endPoint = CGPoint(x: 0, y: 1)
        cancelBtn.layer.insertSublayer(gradientCancelBtnBtnLayer, atIndex: 0)
        
        cancelBtn.layer.cornerRadius = 5
        cancelBtn.layer.masksToBounds = true
    }
    
    func cgColorForRed(red: CGFloat, green: CGFloat, blue: CGFloat) -> AnyObject {
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0).CGColor as AnyObject
    }

    

}
