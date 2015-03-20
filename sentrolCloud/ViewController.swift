//
//  ViewController.swift
//  sentrolCloud
//
//  Created by jianwei on 2015/3/2.
//  Copyright (c) 2015年 Nietzsche. All rights reserved.
//

import UIKit


class ViewController: UIViewController,LoginViewControllerProtocol,AccountViewControllerProtocol,LogoutViewControllerProtocol {

    //註冊判斷
    var checkIfLogin :Bool = false
    var checkIfDashVC :Bool = true
    
    
    //內容區
    var DashVC :DashboardViewController!
    var SetVC :SettingViewController!
    var EventVC :EventViewController!
    var AccountVC :AccountViewController!
    
    var LogininVC :LoginViewController!
    
    
    
    
    //主容器
    @IBOutlet var contanterView: UIView!
    //容器屬性
    @IBOutlet var contanterTrail: NSLayoutConstraint!//右間距
    @IBOutlet var contanterBottom: NSLayoutConstraint!//下間距
    
    
    
    //主要-底選單
    @IBOutlet var bottomNavi: UIView!
    @IBOutlet var botNav_dashBtn: UIButton!
    @IBOutlet var botNav_setBtn: UIButton!
    @IBOutlet var botNav_eventBtn: UIButton!
    @IBOutlet var botNav_accBtn: UIButton!
    @IBOutlet var bottomNaviHeight: NSLayoutConstraint!
    
    
    
    //主要-右選單
    @IBOutlet var rightNavi: UIView!
    @IBOutlet var rightNav_dashBtn: UIButton!
    @IBOutlet var rightNav_setBtn: UIButton!
    @IBOutlet var rightNav_eventBtn: UIButton!
    @IBOutlet var rightNav_accBtn: UIButton!
    
    
    //Dash相關
    @IBOutlet var dashboardBottomNavi: UIView!
    @IBOutlet weak var dashboardBottomNaviHeight: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //檢查登入
       // goCheckLogInStatus()
        
        
        //底選 陰影
        bottomNavi.layer.shadowColor = UIColor.blackColor().CGColor
        bottomNavi.layer.shadowOffset = CGSize(width: 0, height: -3)
        bottomNavi.layer.shadowOpacity = 0.2
        bottomNavi.layer.shadowRadius = 3
        
        
        
        contanterView.layer.masksToBounds = true
        
        //預備內容區
        var storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        DashVC = storyboard.instantiateViewControllerWithIdentifier("DashboardViewController") as DashboardViewController
        SetVC = storyboard.instantiateViewControllerWithIdentifier("SettingViewController") as SettingViewController
        EventVC = storyboard.instantiateViewControllerWithIdentifier("EventViewController") as EventViewController
        AccountVC = storyboard.instantiateViewControllerWithIdentifier("AccountViewController") as AccountViewController
        
        
        
        //託管
        AccountVC.delegate = self
        
        
        LogininVC = storyboard.instantiateViewControllerWithIdentifier("LoginViewController") as LoginViewController
        
        
        LogininVC.delegate = self
        
        addChildViewController(DashVC)
        addChildViewController(SetVC)
        addChildViewController(EventVC)
        addChildViewController(AccountVC)
        addChildViewController(LogininVC)
        DashVC.view.frame = contanterView.frame
        SetVC.view.frame = contanterView.frame
        EventVC.view.frame = contanterView.frame
        AccountVC.view.frame = contanterView.frame
        LogininVC.view.frame = contanterView.frame
        contanterView.addSubview(DashVC.view)
        contanterView.addSubview(SetVC.view)
        contanterView.addSubview(EventVC.view)
        contanterView.addSubview(AccountVC.view)
        contanterView.addSubview(LogininVC.view)
        
        DashVC.didMoveToParentViewController(self)
        SetVC.didMoveToParentViewController(self)
        EventVC.didMoveToParentViewController(self)
        AccountVC.didMoveToParentViewController(self)
        LogininVC.didMoveToParentViewController(self)
         
        //內容區隱藏
        DashVC.view.alpha = 1
        SetVC.view.alpha = 0
        EventVC.view.alpha = 0
        AccountVC.view.alpha = 0
        LogininVC.view.alpha = 0
        
        
        //偵測旋轉
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "rotated", name: UIDeviceOrientationDidChangeNotification, object: nil)
        
        
        
        //#dash相關
        self.botNav_dashBtn.setImage(UIImage(named: "b-n-1-click.jpg")!,forState: .Normal)
        self.rightNav_dashBtn.setImage(UIImage(named: "r-n-1-click.jpg")!,forState: .Normal)
        self.dashboardBottomNavi.backgroundColor = UIColor(patternImage: UIImage(named: "dashBoard.jpg")!)
        
        
        //建立功能 
        botNav_dashBtn.addTarget(self, action: "clickDashBtn", forControlEvents: UIControlEvents.TouchUpInside)
        botNav_setBtn.addTarget(self, action: "clickSetBtn", forControlEvents: UIControlEvents.TouchUpInside)
        botNav_eventBtn.addTarget(self, action: "clickEventBtn", forControlEvents: UIControlEvents.TouchUpInside)
        botNav_accBtn.addTarget(self, action: "clickAccBtn", forControlEvents: UIControlEvents.TouchUpInside)
        rightNav_dashBtn.addTarget(self, action: "clickDashBtn", forControlEvents: UIControlEvents.TouchUpInside)
        rightNav_setBtn.addTarget(self, action: "clickSetBtn", forControlEvents: UIControlEvents.TouchUpInside)
        rightNav_eventBtn.addTarget(self, action: "clickEventBtn", forControlEvents: UIControlEvents.TouchUpInside)
        rightNav_accBtn.addTarget(self, action: "clickAccBtn", forControlEvents: UIControlEvents.TouchUpInside)
        
        // Do any additional setup after loading the view, typically from a nib.
        
        
        //檢查是否有登入過
        CheckHadLogined()
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    //檢查是否有登入過
    func CheckHadLogined(){
        
        //登入失敗
        bottomNavi.alpha = 0
        bottomNaviHeight.constant = 0
        LogininVC.view.alpha = 1
        
        
    }
    
    //選單功能
    func clickDashBtn(){
        clickBtn_ToOrgImg ()
        UIView.animateWithDuration(0.3
            , animations: { () -> Void in
                self.DashVC.view.alpha = 1
                self.dashboardBottomNavi.alpha = 1
        })
        self.botNav_dashBtn.setImage(UIImage(named: "b-n-1-click.jpg")!,forState: .Normal)
        self.rightNav_dashBtn.setImage(UIImage(named: "r-n-1-click.jpg")!,forState: .Normal)
        checkIfDashVC = true
    }
    func clickSetBtn(){
        //contanterBottom.constant = 0
        clickBtn_ToOrgImg ()
        UIView.animateWithDuration(0.3
            , animations: { () -> Void in
                self.SetVC.view.alpha = 1
        })
        self.botNav_setBtn.setImage(UIImage(named: "b-n-2-click.jpg")!,forState: .Normal)
        self.rightNav_setBtn.setImage(UIImage(named: "r-n-2-click.jpg")!,forState: .Normal)
        
    }
    func clickEventBtn(){
        //contanterBottom.constant = 0
        clickBtn_ToOrgImg ()
        UIView.animateWithDuration(0.3
            , animations: { () -> Void in
                self.EventVC.view.alpha = 1

        })
        self.botNav_eventBtn.setImage(UIImage(named: "b-n-3-click.jpg")!,forState: .Normal)
        self.rightNav_eventBtn.setImage(UIImage(named: "r-n-3-click.jpg")!,forState: .Normal)
        
    }
    func clickAccBtn(){
       // contanterBottom.constant = 0
        clickBtn_ToOrgImg ()
        UIView.animateWithDuration(0.3
            , animations: { () -> Void in
                self.AccountVC.view.alpha = 1
        })
        self.botNav_accBtn.setImage(UIImage(named: "b-n-4-click.jpg")!,forState: .Normal)
        self.rightNav_accBtn.setImage(UIImage(named: "r-n-4-click.jpg")!,forState: .Normal)
        
    }
    
    //選單回原圖
    func clickBtn_ToOrgImg (){
        checkIfDashVC = false
        
        self.botNav_dashBtn.setImage(UIImage(named: "b-n-1.jpg")!,forState: .Normal)
        self.botNav_setBtn.setImage(UIImage(named: "b-n-2.jpg")!,forState: .Normal)
        self.botNav_eventBtn.setImage(UIImage(named: "b-n-3.jpg")!,forState: .Normal)
        self.botNav_accBtn.setImage(UIImage(named: "b-n-4.jpg")!,forState: .Normal)
        self.rightNav_dashBtn.setImage(UIImage(named: "r-n-1.jpg")!,forState: .Normal)
        self.rightNav_setBtn.setImage(UIImage(named: "r-n-2.jpg")!,forState: .Normal)
        self.rightNav_eventBtn.setImage(UIImage(named: "r-n-3.jpg")!,forState: .Normal)
        self.rightNav_accBtn.setImage(UIImage(named: "r-n-4.jpg")!,forState: .Normal)
         //28
        self.DashVC.view.alpha = 0
        self.SetVC.view.alpha = 0
        self.EventVC.view.alpha = 0
        self.AccountVC.view.alpha = 0
        self.dashboardBottomNavi.alpha = 0
    }
    
    //旋轉相關
    func rotated()
    {
        if(UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation))
        {//寬 s
           // contanterTrail.constant = 60
            //DashVC.view.frame = contanterView.frame
            
            
            //主頁判斷
//            if (checkIfDashVC){
//                //是
//                //DashBoar相關
//                
//                //contanterBottom.constant = 64
//                dashboardBottomNavi.alpha = 1
//                dashboardBottomNaviHeight.constant = 64
//            }else{
//                //不是
//               // contanterBottom.constant = 0
//                dashboardBottomNaviHeight.constant = 0
//                dashboardBottomNavi.alpha = 0
//                
//            }
            
//            if (checkIfLogin){
//                //已登入
//                println("已登入")
//                
//            }else{
//                //未登入
//                println("未登入")
//                self.rightNavi.alpha = 0
//                self.bottomNavi.alpha = 0
//            }
            dashboardBottomNavi.alpha = 0
            
        }
        
        if(UIDeviceOrientationIsPortrait(UIDevice.currentDevice().orientation))
        {//長
           
            
            
            dashboardBottomNavi.alpha = 0
            
            
        }
        //println(" 主容器底邊\(contanterBottom.constant)")
        
        //檢查登入
        //goCheckLogInStatus()
        
    }
    
    //檢查登入
    func goCheckLogInStatus(){
        
        if (checkIfLogin){
            //已登入
            println("已登入")
        
        }else{
            //未登入
            println("未登入")
            //self.rightNavi.alpha = 0
            //self.bottomNavi.alpha = 0
        }
    
    
    }
    
    
    func dimissLogininVC(){
        self.LogininVC.view.alpha = 0
        clickDashBtn()
        bottomNavi.alpha = 1
        bottomNaviHeight.constant = 48
    }
    
    //
    
     

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
    
    //管理ACCOUNT 列表區
    func showGeneralVC(){
        let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("GeneralViewController") as GeneralViewController
        presentViewController(viewController, animated: true, completion: nil)
    }
    func showNotifiVC(){
        let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("NotificationViewController") as NotificationViewController
        presentViewController(viewController, animated: true, completion: nil)
    }
    func showTermsVC(){
        let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("TermsViewController") as TermsViewController
        presentViewController(viewController, animated: true, completion: nil)
    }
    func showFeedVC(){
        let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("FeedbackViewController") as FeedbackViewController
        presentViewController(viewController, animated: true, completion: nil)
    }
    func showScannerVC(){
        let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("ScannerViewController") as ScannerViewController
        presentViewController(viewController, animated: true, completion: nil)
    }
    func showMessageVC(){
        let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("MessageViewController") as MessageViewController
        presentViewController(viewController, animated: true, completion: nil)
    }
    func showLogoutVC(){
        let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("LogoutViewController") as LogoutViewController
        viewController.delegate = self
        presentViewController(viewController, animated: true, completion: nil)
    }
    
    
    
    
    

}

