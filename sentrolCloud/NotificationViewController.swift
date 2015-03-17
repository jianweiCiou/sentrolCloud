//
//  NotificationViewController.swift
//  sentrolCloud
//
//  Created by jianwei on 2015/3/3.
//  Copyright (c) 2015年 Nietzsche. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController {

    @IBOutlet var scrollView: UIScrollView!
    
    
    //詳細資料
    var notifiView = NotificationView.instanceFromNib()
    
    
    //返回
    @IBOutlet var dismissBtn: UIButton!
    
    
    
    
    //漸層光澤
    let gradientLayer = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        
        //偵測旋轉
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "rotated", name: UIDeviceOrientationDidChangeNotification, object: nil)
        
        //新增內容scroll區
        scrollView.backgroundColor = UIColor.whiteColor()
        scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 1190);
        notifiView.frame = CGRectMake(0, 0, scrollView.frame.size.width, 1190)
        notifiView.initNotificationView()
        scrollView.addSubview(notifiView)
        
        // Do any additional setup after loading the view.
    }

    //旋轉相關
    func rotated()
    {
        if(UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation))
        {//寬 s
            scrollView.frame.size.width = self.view.frame.size.width
            
            notifiView.frame = CGRectMake(0, 0, scrollView.frame.size.width, 1190)
        }
        
        if(UIDeviceOrientationIsPortrait(UIDevice.currentDevice().orientation))
        {//長
            scrollView.frame.size.width = self.view.frame.size.width
            notifiView.frame = CGRectMake(0, 0, scrollView.frame.size.width, 1190)
        }
        
        //檢查登入
        //goCheckLogInStatus()
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    @IBAction func dismissSelfViewcontroller(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
