//
//  MessageViewController.swift
//  sentrolCloud
//
//  Created by jianwei on 2015/3/4.
//  Copyright (c) 2015年 Nietzsche. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController {

    
    
    //表格cell
    let cellIdentifier = "MessageTableViewCell"
    
    
    @IBOutlet var mainTableView: UITableView!
    
    
    //取得資料內容
    var tableData = [AnyObject]()
    var resultsArray: NSArray!
    
    
//        {"MessageListArray": [
//            {
//            "title":"Sentrolcloud",
//            "time":"23:10 01/01 2015",
//            "message":"SentrolcloudMessageSentrolcloudMessageSentrolcloudMessage",
//            "status":"r"
//            }
//    
    @IBOutlet var dismissBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //讀取列表資料
        //讀資料
        let bundle = NSBundle.mainBundle()
        let path = bundle.pathForResource("MessageList", ofType: "json")
        let data: NSData? = NSData(contentsOfFile: path!)
        if data != nil {
            let content = NSString(data: data!, encoding:NSUTF8StringEncoding) as String
            //println("\(content)")
            
            let jsonResult: Dictionary = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers, error: nil) as Dictionary<String, AnyObject>
            
            // println("\(jsonResult)")
            
            
            let results: NSArray = jsonResult["MessageListArray"] as NSArray
            resultsArray = results
            
            for item in resultsArray {
                // println("解析\(item)")
                // self.tableData.append(item)
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    //分類內容
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var nib = UINib(nibName: self.cellIdentifier, bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: self.cellIdentifier)
        
        var cell:MessageTableViewCell = tableView.dequeueReusableCellWithIdentifier(self.cellIdentifier) as MessageTableViewCell
        
        cell.title.text = resultsArray.objectAtIndex(indexPath.row).valueForKey("title") as? String
        cell.time.text = resultsArray.objectAtIndex(indexPath.row).valueForKey("time") as? String
        cell.message.text = resultsArray.objectAtIndex(indexPath.row).valueForKey("message") as? String
        
        
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 79
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return resultsArray.count
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
