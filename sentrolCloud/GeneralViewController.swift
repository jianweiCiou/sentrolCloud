//
//  GeneralViewController.swift
//  sentrolCloud
//
//  Created by jianwei on 2015/3/3.
//  Copyright (c) 2015年 Nietzsche. All rights reserved.
//

import UIKit

class GeneralViewController: UIViewController {

    @IBOutlet var dismissBtn: UIButton!
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var scrollView: UIScrollView!
    
    
    //取得資料內容
    var tableData = [AnyObject]()
    var resultsArray: NSArray!
    
    
    //cell
    let cellIdentifier = "GeneralTableViewCell"
    
    //詳細資料
    var generalView = GeneralView.instanceFromNib()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //新增內容scroll區
        scrollView.backgroundColor = UIColor.whiteColor()
        scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 904);
        generalView.frame = CGRectMake(0, 0, self.view.frame.size.width, 904)
        scrollView.addSubview(generalView)
        self.scrollView.alpha = 0
        
        
        //內容區方法
        generalView.dismissBtn.addTarget(self, action: "hideGeneralView", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        
        
        //列表cell
        var nib = UINib(nibName: self.cellIdentifier, bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: self.cellIdentifier)
        
        
        //讀資料
        let bundle = NSBundle.mainBundle()
        let path = bundle.pathForResource("GeneralList", ofType: "json")
        let data: NSData? = NSData(contentsOfFile: path!)
        if data != nil {
            let content = NSString(data: data!, encoding:NSUTF8StringEncoding) as String
           // println("\(content)")
            
            let jsonResult: Dictionary = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers, error: nil) as Dictionary<String, AnyObject>
            
           // println("\(jsonResult)")
            
            
            let results: NSArray = jsonResult["GeneralListArray"] as NSArray
            resultsArray = results
            
            for item in resultsArray {
                //println("\(item)")
                self.tableData.append(item)
            }
            
        }
        
        
    

        // Do any additional setup after loading the view.
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44.0
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:GeneralTableViewCell = tableView.dequeueReusableCellWithIdentifier(self.cellIdentifier) as GeneralTableViewCell
        
        
        
        var typeTxt : NSString = resultsArray.objectAtIndex(indexPath.row).valueForKey("type") as String
        
        
        var firstName : NSString = resultsArray.objectAtIndex(indexPath.row).valueForKey("firstName") as String
        var middleName : NSString = resultsArray.objectAtIndex(indexPath.row).valueForKey("middleName") as String
        var LastName : NSString = resultsArray.objectAtIndex(indexPath.row).valueForKey("LastName") as String
        
        let nameText = "\(firstName) \(middleName) \(LastName) "
        
        
        
        cell.type.text = typeTxt
        cell.name.text = nameText
        
        return cell
    }

    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        generalView.frame = CGRectMake(0, 0, self.view.frame.size.width, 904)
        generalView.initGeneral()
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.scrollView.alpha = 1
        })
        
    }
    
    
    //藏
    func hideGeneralView(){
        //self.dismissViewControllerAnimated(true, completion: nil)
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.scrollView.alpha = 0
        })
        
    }
    
          
    @IBAction func dismissSelfViewcontroller(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
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
