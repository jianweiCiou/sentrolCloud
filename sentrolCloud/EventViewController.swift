//
//  EventViewController.swift
//  sentrolCloud
//
//  Created by jianwei on 2015/3/2.
//  Copyright (c) 2015年 Nietzsche. All rights reserved.
//

import UIKit

class EventViewController: UIViewController {

    //表格cell
    let cellIdentifier = "EventTableViewCell"
    
    
    
    
    @IBOutlet var mainTableView: UITableView!
    
    
    //取得資料內容
    var tableData = [AnyObject]()
    var resultsArray: NSArray!
    
    
    //選取
    @IBOutlet weak var filterView: UIView!
    var filterViewStatus:Bool!
    
    
    //資料array
    var colors = ["Door","Glass","Motion","LPG Gas","Smoke","Motion","Siren"]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        filterView.alpha = 0
        filterViewStatus = false
        
        //讀取列表資料
        //讀資料
        let bundle = NSBundle.mainBundle()
        let path = bundle.pathForResource("EventList", ofType: "json")
        let data: NSData? = NSData(contentsOfFile: path!)
        if data != nil {
            let content = NSString(data: data!, encoding:NSUTF8StringEncoding) as String
            //println("\(content)")
            
            let jsonResult: Dictionary = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers, error: nil) as Dictionary<String, AnyObject>
            
            // println("\(jsonResult)")
            
            
            let results: NSArray = jsonResult["EventListArray"] as NSArray
            resultsArray = results
            
            for item in resultsArray {
                // println("解析\(item)")
                // self.tableData.append(item)
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func filterShow(sender: AnyObject) {
        
        if(filterViewStatus == false){
            println("false")
            filterView.alpha = 1
            mainTableView.alpha = 0.5
        }else{
            println("true")
            filterView.alpha = 0
            mainTableView.alpha = 1
        }
        
        filterViewStatus = !filterViewStatus
        
    }

    @IBAction func confirm(sender: AnyObject) {
        
        if(filterViewStatus == false){
            println("false")
            filterView.alpha = 1
            mainTableView.alpha = 0.5
            
        }else{
            println("true")
            filterView.alpha = 0
            mainTableView.alpha = 1
        }
        
        filterViewStatus = !filterViewStatus
        
        
    }
    
    
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return colors.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return colors[row]
    }
    
    
    
    
    //分類內容
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var nib = UINib(nibName: self.cellIdentifier, bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: self.cellIdentifier)
        
        var cell:EventTableViewCell = tableView.dequeueReusableCellWithIdentifier(self.cellIdentifier) as EventTableViewCell
        
        cell.device.text = resultsArray.objectAtIndex(indexPath.row).valueForKey("device") as? String
        cell.event.text = resultsArray.objectAtIndex(indexPath.row).valueForKey("event") as? String
        cell.room.text = resultsArray.objectAtIndex(indexPath.row).valueForKey("room") as? String
        cell.date.text = resultsArray.objectAtIndex(indexPath.row).valueForKey("date") as? String
        
        
        
        
        return cell
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
                return 102
            }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         
        
        return resultsArray.count
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
