//
//  AccountViewController.swift
//  sentrolCloud
//
//  Created by jianwei on 2015/3/2.
//  Copyright (c) 2015年 Nietzsche. All rights reserved.
//

import UIKit


protocol  AccountViewControllerProtocol{
    func showGeneralVC()
    func showNotifiVC()
    func showTermsVC()
    func showFeedVC()
    func showMessageVC()
    func showLogoutVC()
    func showScannerVC()//拗苗
    func CheckHadLogined()
}





class AccountViewController: UIViewController {

    
    var delegate:AccountViewControllerProtocol?
    var dataSource:AccountViewControllerProtocol?
    

    
    
    
    var tableData = [String]()
    @IBOutlet var tableView: UITableView!
    
    
    //表格
    let cellIdentifier = "AccountTableViewCell"
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        //讀資料
        self.tableData = [
            "General",
            "Notification",
            "Terms & Policy",
            "Feedback",
            "Subscription Plan",
            "Message",
            "Scanner",
            "Sentrol Shop",
            "Logout"
        ]
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        var nib = UINib(nibName: self.cellIdentifier, bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: self.cellIdentifier)
        
        
        var cell:AccountTableViewCell = tableView.dequeueReusableCellWithIdentifier(self.cellIdentifier) as AccountTableViewCell
        
        cell.titleText.text = tableData[indexPath.row]
        
        
        return cell
    }
    
    
    //分隔線
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell,
        forRowAtIndexPath indexPath: NSIndexPath)
    {
        // Remove separator inset
        if cell.respondsToSelector("setSeparatorInset:") {
            cell.separatorInset = UIEdgeInsetsZero
        }
        
        // Prevent the cell from inheriting the Table View's margin settings
        if cell.respondsToSelector("setPreservesSuperviewLayoutMargins:") {
            cell.preservesSuperviewLayoutMargins = false
        }
        
        // Explictly set your cell's layout margins
        if cell.respondsToSelector("setLayoutMargins:") {
            cell.layoutMargins = UIEdgeInsetsZero
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        switch indexPath.row {
        case 0 :
            self.delegate?.showGeneralVC()
        case 1 :
            self.delegate?.showNotifiVC()
        case 2 :
            self.delegate?.showTermsVC()
        case 3 :
            self.delegate?.showFeedVC()
        case 5 :
            self.delegate?.showMessageVC()
        case 6 ://掃描
            self.delegate?.showScannerVC()
        case 8 :
            self.delegate?.showLogoutVC()
            
        default:
            println("haha\(indexPath.row)")
            
        }
        
        
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
