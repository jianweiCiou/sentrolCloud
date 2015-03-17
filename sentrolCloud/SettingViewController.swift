//
//  SettingViewController.swift
//  sentrolCloud
//
//  Created by jianwei on 2015/3/2.
//  Copyright (c) 2015年 Nietzsche. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var modeTableView: UITableView!
    
    
    
    //mode 3 圖
    @IBOutlet weak var modle_away: UIImageView!
    @IBOutlet weak var modle_home: UIImageView!
    @IBOutlet weak var modle_night: UIImageView!
    
    
    
    
    //表格cell
    let cellIdentifier = "SettimgTableViewCell"
    let headerCellIdentifier = "SettimgSectionTableViewCell"
    
    //zone容器
    @IBOutlet weak var zoneContanter: UIView!
    @IBOutlet weak var zoneContanterTopSpace: NSLayoutConstraint!
    
    
    
    
    var ZoneVC :ZoneViewController!
    
    
    
    //取得資料內容
    var tableData = [AnyObject]()
    var resultsArray: NSArray!
    
    //缺換圖片
    let image1 = UIImage(named: "settintTypeIcon1.png") as UIImage?
    let image2 = UIImage(named: "settintTypeIcon2.png") as UIImage?
    
    
    //切換相關
    @IBOutlet weak var show_switch_btn: UIButton!
    @IBOutlet weak var switchView: UIView!
    @IBOutlet weak var modeView: UIView!
    @IBOutlet weak var zoneView: UIView!
    
    @IBAction func switch_mode(sender: AnyObject) {
        self.show_switch_btn.setImage(image1, forState: .Normal)
        self.zoneView.backgroundColor = UIColorFromRGB(0x5b5f5e)
        self.modeView.backgroundColor = UIColorFromRGB(0xeb5f5e)
        switchView.alpha = 0
        modeTableView.alpha = 1
        self.zoneContanter.alpha = 0
        
        self.modle_away.alpha = 1
        self.modle_home.alpha = 1
        self.modle_night.alpha = 1
        
    }
    @IBAction func switch_zone(sender: AnyObject) {
        self.show_switch_btn.setImage(image2, forState: .Normal)
        self.zoneView.backgroundColor = UIColorFromRGB(0xeb5f5e)
        self.modeView.backgroundColor = UIColorFromRGB(0x5b5f5e)
        switchView.alpha = 0
        modeTableView.alpha = 0
        self.zoneContanter.alpha = 1
        
        self.modle_away.alpha = 0
        self.modle_home.alpha = 0
        self.modle_night.alpha = 0
        
    }
    
    
    
    
    
    
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    
    
    
    @IBAction func show_switchView(sender: AnyObject) {
        switchView.alpha = 1
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switchView.alpha = 0
        
        //zone區產生
        var storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        ZoneVC = storyboard.instantiateViewControllerWithIdentifier("ZoneViewController") as ZoneViewController
        addChildViewController(ZoneVC)
        ZoneVC.view.frame = self.zoneContanter.frame
        self.zoneContanter.addSubview(ZoneVC.view)
        ZoneVC.didMoveToParentViewController(self)
        self.zoneContanter.alpha = 0
        self.zoneContanter.backgroundColor = UIColor.clearColor()

        
        
        self.modeTableView.backgroundColor = UIColor.clearColor()
        
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
        
        // Do any additional setup after loading the view.
    }

    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // 1
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
        
        var headerCell:SettimgSectionTableViewCell = tableView.dequeueReusableCellWithIdentifier(self.headerCellIdentifier) as SettimgSectionTableViewCell
        
    
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
        
        var cell:SettimgTableViewCell = tableView.dequeueReusableCellWithIdentifier(self.cellIdentifier) as SettimgTableViewCell
        
        cell.backgroundColor = UIColor.clearColor()
        //section
        for var index = 0; index < resultsArray.count; ++index {
            if(indexPath.section == index){
                var listArray:NSArray = resultsArray.objectAtIndex(index).valueForKey("gatewayList") as NSArray
                
                //gatewayListlist
                for var indexCell = 0; indexCell < listArray.count; ++indexCell {
                    
                    if(indexPath.section == index){
                        if(indexPath.row == indexCell){
                            
                            
                            cell.cellMessage(listArray.objectAtIndex(indexCell) as NSDictionary)
                            //導入資料
                            //cell.cellDataArray = listArray.objectAtIndex(indexCell) as NSDictionary

                        }
                    }
                }
            }
        }
        return cell
    }
    //高
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 58
    }
    
    
    //漸層顏色
    func cgColorForRed(red: CGFloat, green: CGFloat, blue: CGFloat) -> AnyObject {
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0).CGColor as AnyObject
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
