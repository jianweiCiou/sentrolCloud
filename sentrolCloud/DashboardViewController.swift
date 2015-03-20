//
//  DashboardViewController.swift
//  sentrolCloud
//
//  Created by jianwei on 2015/3/2.
//  Copyright (c) 2015年 Nietzsche. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {

    //top
    @IBOutlet var topNaviBar: UINavigationBar!
    
    var setMenuStaus : Bool = true
    
    //表格cell
    let cellIdentifier = "DashTableViewCell"
    let headerCellIdentifier = "DashSectionTableViewCell"
    let cameraCellIdentifier = "DashCamersTableViewCell"
    
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var naviHeight: NSLayoutConstraint!
    
    @IBOutlet var tableViewBotMargin: NSLayoutConstraint!
    
    
    //狀態副選單
    @IBOutlet var setMenuView: UIView!
    @IBOutlet var metalIN: UIImageView!
    
    
    
    @IBOutlet var setMenuBottom: NSLayoutConstraint!
    
    
    
    @IBOutlet weak var setMenuViewBG: UIView!
    
    //取得資料內容
    var tableData = [AnyObject]()
    var resultsArray: NSArray!
    
    //狀態字串
    var statusString :String = "HOME"
    
    //漸層光澤
    let gradientLayer = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        var leftSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        var rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        
        leftSwipe.direction = .Left
        rightSwipe.direction = .Right
        
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        
        
        
        // Do any additional setup after loading the view.
        
        //副選單創造
        MakeUpSetMenuView()
        
        setMenuView.alpha = 0
        
        
        //偵測旋轉
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "rotated", name: UIDeviceOrientationDidChangeNotification, object: nil)
        
        //讀取列表資料
        //讀資料
        let bundle = NSBundle.mainBundle()
        let path = bundle.pathForResource("DashBoardList", ofType: "json")
        let data: NSData? = NSData(contentsOfFile: path!)
        if data != nil {
            let content = NSString(data: data!, encoding:NSUTF8StringEncoding) as String
              //println("\(content)")
            
            let jsonResult: Dictionary = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers, error: nil) as Dictionary<String, AnyObject>
            
             // println("\(jsonResult)")
            
            
            let results: NSArray = jsonResult["DachBoardListArray"] as NSArray
            resultsArray = results
            
            for item in resultsArray {
               // println("解析\(item)")
               // self.tableData.append(item)
            }
        }
    }
    
    func handleSwipes(sender:UISwipeGestureRecognizer) {
        
        //有開啟才有手
        if !setMenuStaus{
            if (sender.direction == .Left) {
                
                if(statusString == "HOME"){
                    statusString = "NIGHT"
                    UIView.animateWithDuration(0.5, animations: {
                        self.metalIN.transform = CGAffineTransformMakeRotation((56.0 * CGFloat(M_PI)) / 180.0)
                    })
                }
                
                if(statusString == "AWAY"){
                    statusString = "HOME"
                    UIView.animateWithDuration(0.5, animations: {
                        self.metalIN.transform = CGAffineTransformMakeRotation((0 * CGFloat(M_PI)) / 180.0)
                    })
                }
                
            }
            
            if (sender.direction == .Right) {
                
                if(statusString == "NIGHT"){
                    statusString = "HOME"
                    UIView.animateWithDuration(0.5, animations: {
                        self.metalIN.transform = CGAffineTransformMakeRotation((0 * CGFloat(M_PI)) / 180.0)
                    })
                }
                
                if(statusString == "HOME"){
                    statusString = "AWAY"
                    UIView.animateWithDuration(0.5, animations: {
                        self.metalIN.transform = CGAffineTransformMakeRotation((-56.0 * CGFloat(M_PI)) / 180.0)
                    })
                }
            }
        
        
        }
        
        
    }
    
    
    //旋轉相關
    func rotated()
    {
        if(UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation))
        {//寬
            tableView.reloadData()
//             naviHeight.constant = 20
//             topNaviBar.alpha = 0
        }
        
        if(UIDeviceOrientationIsPortrait(UIDevice.currentDevice().orientation))
        {//長
            tableView.reloadData()
            
//            naviHeight.constant = 64
//            topNaviBar.alpha = 1
            
        }
        
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // 1
        // Return the number of sections.
        return resultsArray.count
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 2
        var listCount = 0
        
        for var index = 0; index < resultsArray.count; ++index {
            if(section == index){
                var listArray:NSArray = resultsArray.objectAtIndex(index).valueForKey("gatewayList") as NSArray
                listCount = listArray.count
            }
        }
        
        
        return listCount
    }
    
    
    //分類標題
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var nib = UINib(nibName: self.headerCellIdentifier, bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: self.headerCellIdentifier)
        
        var headerCell:DashSectionTableViewCell = tableView.dequeueReusableCellWithIdentifier(self.headerCellIdentifier) as DashSectionTableViewCell
        
        
        for var index = 0; index < resultsArray.count; ++index {
            var className: String = resultsArray.objectAtIndex(index).valueForKey("className") as String
            
            var classImage: String = resultsArray.objectAtIndex(index).valueForKey("classImage") as String
            
            if(section == index){
                headerCell.headerLabel.text = className
                headerCell.icon.image = UIImage(named: "\(classImage).png")
            }
        }
        
        
        return headerCell
    }
    //高
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    //分類內容
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var nib = UINib(nibName: self.cellIdentifier, bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: self.cellIdentifier)
        
        var cell:DashTableViewCell = tableView.dequeueReusableCellWithIdentifier(self.cellIdentifier) as DashTableViewCell
        
        
        
        
        //section
        for var index = 0; index < resultsArray.count; ++index {
            if(indexPath.section == index){
                var listArray:NSArray = resultsArray.objectAtIndex(index).valueForKey("gatewayList") as NSArray
                
                
                //gatewayListlist
                for var indexCell = 0; indexCell < listArray.count; ++indexCell {
                    
                    if(indexPath.section == index){
                        if(indexPath.row == indexCell){
                            
                            var typeName:String
                            var status:String
                            typeName = listArray.objectAtIndex(indexCell).valueForKey("type") as String
                            status = listArray.objectAtIndex(indexCell).valueForKey("status") as String
                            cell.type.text = typeName
                            cell.name.text = listArray.objectAtIndex(indexCell).valueForKey("name") as? String
                            cell.icon.image = UIImage(named: "icon_\(typeName).png")
                            
                            
                            if(status == "on"){
                                cell.statusImage.image = UIImage(named: "dashBoardStatus_yes.png")
                            }else{
                                cell.statusImage.image = UIImage(named: "dashBoardStatus_no.png")
                            }
                            
                            
                            
                            //攝影機
                            if(typeName == "Camera"){
                                tableView.rowHeight = 212
                                cell.icon.alpha = 0
                                cell.cameraView.alpha = 1
                            }else{
                                tableView.rowHeight = 66
                                cell.icon.alpha = 1
                                cell.cameraView.alpha = 0
                            }
                            
                            //顯示溫度
                            if(typeName == "Temperature"){
                                cell.dumidityView.alpha = 0
                                cell.numberView.alpha = 1
                                cell.statusImage.alpha = 0
                                cell.numberTemp.text = status
                            }else if(typeName == "Humidity"){
                                cell.numberView.alpha = 0
                                cell.dumidityView.alpha = 1
                                cell.dumidityNumber.text = status
                            }else{
                                cell.dumidityView.alpha = 0
                                cell.numberView.alpha = 0
                                cell.statusImage.alpha = 1
                                cell.numberTemp.text = status
                            }
                        }
                    }
                }
            }
        }
        
        return cell
    }
        //高
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return 66
//    }
//    
    
    //漸層顏色
    func cgColorForRed(red: CGFloat, green: CGFloat, blue: CGFloat) -> AnyObject {
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0).CGColor as AnyObject
    }
    
    
    func MakeUpSetMenuView(){
        //陰影
        setMenuView.layer.shadowColor = UIColor.blackColor().CGColor
        setMenuView.layer.shadowOffset = CGSize(width: 0, height: -3)
        setMenuView.layer.shadowOpacity = 0.2
        setMenuView.layer.shadowRadius = 3
        
       
    
    }
    
    @IBAction func showSetMenuView(sender: AnyObject) {
        
        self.setMenuView.layer.masksToBounds = true
        if setMenuStaus{
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                
                self.setMenuView.alpha = 1
                self.tableView.alpha = 0.2
                self.tableView.scrollEnabled = false
            })
        }else{
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.setMenuView.alpha = 0
                self.tableView.alpha = 1
                self.tableView.scrollEnabled = true
            })
        
        }
        
        
        setMenuStaus = !setMenuStaus
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
