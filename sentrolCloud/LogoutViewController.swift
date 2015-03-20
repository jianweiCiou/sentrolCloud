//
//  LogoutViewController.swift
//  sentrolCloud
//
//  Created by jianwei on 2015/3/4.
//  Copyright (c) 2015年 Nietzsche. All rights reserved.
//

import UIKit

import CoreData

protocol  LogoutViewControllerProtocol{
    func CheckHadLogined()
}



class LogoutViewController: UIViewController {

    
    var delegate:LogoutViewControllerProtocol?
    var dataSource:LogoutViewControllerProtocol?
    
    
    @IBOutlet var dismissBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func dismissSelfViewcontroller(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func confirmLogOUT(sender: AnyObject) {
        
        makeAlert("Sign out")
        
    }
    
    //alert
    func makeAlert(message: String){
        let alert = UIAlertView()
        alert.delegate = self
        alert.title = ""
        alert.message = message
        alert.addButtonWithTitle("Ok")
        alert.addButtonWithTitle("Cancel")
        alert.show()
    }
    
    func alertView(View: UIAlertView!, clickedButtonAtIndex buttonIndex: Int){
        
        switch buttonIndex{
        case 0:
            goDeleteData()
            break;
        default:
            break;
        }
    }
    
    //確認刪除
    func goDeleteData(){
        
        var people = [NSManagedObject]()
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        let entity =  NSEntityDescription.entityForName("Person",inManagedObjectContext:managedContext)
        let person = NSManagedObject(entity: entity!,insertIntoManagedObjectContext:managedContext)
        
        let fetchRequest = NSFetchRequest(entityName:"Person")//個人資料
        var error: NSError?
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as [NSManagedObject]?
        
        
        if let results = fetchedResults {
            
            for var index = 0; index < results.count; ++index {
                managedContext.deleteObject(results[index])
            }
            self.delegate?.CheckHadLogined()
            
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
        
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
