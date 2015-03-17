//
//  SelectCategoryController.swift
//  sentrolCloud
//
//  Created by mac mini 4 nhr on 2015/3/12.
//  Copyright (c) 2015年 Nietzsche. All rights reserved.
//

import UIKit


protocol SelectCategoryProtocol{

    func reloadSelectArray()
    

}

class SelectCategoryController: UIViewController {

    
    var delegate:SelectCategoryProtocol?
    var dataSource:SelectCategoryProtocol?
    
    
    
    
    @IBOutlet var mainTableView: UITableView!
    
    
    @IBOutlet var type: UILabel!
    @IBOutlet var name: UILabel!
    
    @IBOutlet var icon: UIImageView!
    
    
    
    
    @IBAction func dismissView(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    //取得資料內容
    var tableData = [AnyObject]()
    var resultsArray: NSMutableArray!
    
    
    let headerCellIdentifier = "ZoneSectionTableViewCell" //一般section
    
    
    //原始section & cell
    var orgSectionNumber: Int!
    var orgCellNumber: Int!
    
    
    //新section & cell
    var newSectionNumber: Int!
    var newCellNumber: Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let subRange:NSMutableArray = resultsArray[1...3]
        
        // Do any additional setup after loading the view.
    }

    
    func mainTableViewReload(){
    
        self.mainTableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 1
        return resultsArray.count
    }
    
    //分類內容
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //一般
        var nib = UINib(nibName: self.headerCellIdentifier, bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: self.headerCellIdentifier)
        var cell:ZoneSectionTableViewCell = tableView.dequeueReusableCellWithIdentifier(self.headerCellIdentifier) as ZoneSectionTableViewCell
        
        cell.backgroundColor = UIColor.clearColor()
        //section
        
        for var index = 0; index < resultsArray.count; ++index {
            var className: String = resultsArray.objectAtIndex(index).valueForKey("className") as String
            
            var classImage: String = resultsArray.objectAtIndex(index).valueForKey("classImage") as String
            
            if(indexPath.row == index){
                //一般
                
                if(indexPath.row == 0 ){
                    
                    cell.headerLabel.text = "Select Category"
                    cell.sectionBg.alpha = 0
                
                }else{
                    cell.headerLabel.text = className
                    cell.icon.image = UIImage(named: "\(classImage).png")
                }
            }
        }
        return cell
    }
    
    //高
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var number:CGFloat = 44
        
        return number
    }
    
    //選擇
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        println("You selected 類別 #\(indexPath.row)!")
        
        if(indexPath.row != 0 ){
            self.view.alpha = 0
            newSectionNumber = indexPath.row
            dataAdjustments()
        }
        //self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    //進行資料調整
    func dataAdjustments(){
        
        //移除org cell
        var listArray:NSArray = resultsArray.objectAtIndex(orgSectionNumber).valueForKey("gatewayList") as NSArray
        
        //要移動的
        var cellArray:NSDictionary = listArray.objectAtIndex(orgCellNumber) as NSDictionary
            
            
        
        resultsArray.objectAtIndex(orgSectionNumber).valueForKey("gatewayList")?.removeObjectAtIndex(orgCellNumber)
        
        println("移除org cell #\(newSectionNumber)!")
        
        
        
        //新增cell到新section
        resultsArray.objectAtIndex(newSectionNumber).valueForKey("gatewayList")?.addObject(cellArray)
        
        delegate?.reloadSelectArray()
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
