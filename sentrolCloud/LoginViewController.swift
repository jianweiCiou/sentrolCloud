//
//  LoginViewController.swift
//  sentrolCloud
//
//  Created by jianwei on 2015/3/2.
//  Copyright (c) 2015年 Nietzsche. All rights reserved.
//

import UIKit
import CoreData

protocol LoginViewControllerProtocol{

    
func dimissLogininVC()
}


class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var delegate:LoginViewControllerProtocol?
    var dataSource:LoginViewControllerProtocol?
    
    var mainVC : UIViewController!
    
    var people = [NSManagedObject]()
    
    
    
    //logo頂間距
    @IBOutlet weak var logoTopSpace: NSLayoutConstraint!
    
    //登入按鈕 加入按鈕
    @IBOutlet weak var singInBtn: UIButton!
    @IBOutlet weak var joinUsBtn: UIButton!
    
    
    
    //帳號
    @IBOutlet weak var acctEmailTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //對話筐
        self.acctEmailTF.delegate = self
        self.passTF.delegate = self
        
        //圓角
        singInBtn.layer.cornerRadius = 21
        joinUsBtn.layer.cornerRadius = 10.5
        
        
        //偵測旋轉
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "rotated", name: UIDeviceOrientationDidChangeNotification, object: nil)
        
        fetched_Person_Results()
        // Do any additional setup after loading the view.
    }

    
    
    
    
    //loginBtnAction
    @IBAction func singInClick(sender: AnyObject) {
        acctEmailTF.resignFirstResponder()
        passTF.resignFirstResponder()
        
        //取的帳密
        var acctEmailTFtext : String = acctEmailTF.text
        var passTFtext : String = passTF.text
        
        //輸入判斷
        if(acctEmailTF.text == "" && passTF.text == ""){
            makeAlert("email & password !")
            return
        }
        if(acctEmailTF.text == ""){
            makeAlert("email !")
            return
        }
        if(passTF.text == ""){
            makeAlert("password !")
            return
        }
        
        //儲存帳戶與密碼
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        let entity =  NSEntityDescription.entityForName("Person",inManagedObjectContext:managedContext)
        let person = NSManagedObject(entity: entity!,insertIntoManagedObjectContext:managedContext)
    
        person.setValue(self.acctEmailTF.text, forKey: "account")
        person.setValue(self.passTF.text, forKey: "password")
        
        
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
        fetched_Person_Results()
        
        
        
        
        
        //開始進入雲端
        connectSentrolCloud()
    }
    
    //開始進入雲端
    func connectSentrolCloud(){
        println("開始進入雲端")
        //開啟loading遮罩
        var overlay : UIView? // This should be a class variable
        overlay = UIView(frame: view.frame)
        overlay!.backgroundColor = UIColor.blackColor()
        overlay!.alpha = 0.8
        view.addSubview(overlay!)
        
        
        //post出去 & 本機紀錄
        let manager = AFHTTPRequestOperationManager()
        manager.responseSerializer.acceptableContentTypes = NSSet(object: "text/html")
        var parameters = ["account":self.acctEmailTF.text,"password":passTF.text,"command":"login"]
        manager.POST( "http://www.sentrolcloud.com/app/getinformation.php",
            parameters: parameters,
            success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                
                let responseDict = responseObject as Dictionary<String, AnyObject>
                
                if (responseDict["account"] != nil){
                    println("成功登入")
                    var account = responseDict["account"] as String!
                    var country = responseDict["country"] as String!
                    var first_name = responseDict["first_name"] as String!
                    var language = responseDict["language"] as String!
                    var last_name = responseDict["last_name"] as String!
                    
                    //存本機資料
                    let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
                    let managedContext = appDelegate.managedObjectContext!
                    let entity =  NSEntityDescription.entityForName("Person",inManagedObjectContext:managedContext)
                    let person = NSManagedObject(entity: entity!,insertIntoManagedObjectContext:managedContext)
                    
                    
                    person.setValue(account, forKey: "account")
                    person.setValue(self.passTF.text, forKey: "password")
                    person.setValue(country, forKey: "country")
                    person.setValue(first_name, forKey: "first_name")
                    person.setValue(language, forKey: "language")
                    person.setValue(last_name, forKey: "last_name")
                    
                    var error: NSError?
                    if !managedContext.save(&error) {
                        println("Could not save \(error), \(error?.userInfo)")
                    }
                    self.fetched_Person_Results()
                    
                    
                    
                    
                    self.delegate?.dimissLogininVC()
                    overlay?.removeFromSuperview()
                    
                    
                    
                }else{
                    
                    overlay?.removeFromSuperview()
                    self.makeAlert("Login failed !")
                
                }
                
                
                
                
                
            },
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                println("Error: " + error.localizedDescription)
        })
    
    
    }
    
    //alert
    func makeAlert(message: String){
        let alert = UIAlertView()
        alert.delegate = self
        alert.title = ""
        alert.message = message
        alert.addButtonWithTitle("Ok")
        alert.show() 
    }
    
    
    
    func saveCoreData_Person(key: String, value: String) {
        println("key & value: \(key), \(value)")
        let appDelegate =
        UIApplication.sharedApplication().delegate as AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        let entity =  NSEntityDescription.entityForName("Person",
            inManagedObjectContext:
            managedContext)
        
        let person = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext:managedContext)
        
        person.setValue(value, forKey: key)
        
        
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
        //people.append(person)
        
        fetched_Person_Results()
    }
    
    
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        return true;
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //旋轉相關
    func rotated()
    {
        if(UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation))
        {//寬 s
            self.logoTopSpace.constant = 5
        }
        
        if(UIDeviceOrientationIsPortrait(UIDevice.currentDevice().orientation))
        {//長
            self.logoTopSpace.constant = 35
        }
    }
    
    //取得資料
    func fetched_Person_Results(){
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        let fetchRequest = NSFetchRequest(entityName:"Person")//個人資料
        
        var error: NSError?
        
        let fetchedResults =
        managedContext.executeFetchRequest(fetchRequest,
            error: &error) as [NSManagedObject]?
        
        
        
        if let results = fetchedResults {
            people = results
            //有資料時
            if (people.count > 0 ){
                
                
                
                var number = (people.count - 1)
                let person = people[number]
                //var accountString:String
                println("local data \(person)")
                //帳號
                
                
                if ((person.valueForKey("account")) != nil){
                    self.acctEmailTF.text = person.valueForKey("account") as String?
                }
                //密碼
                if ((person.valueForKey("password")) != nil){
                    self.passTF.text = person.valueForKey("password") as String?
                }
            }
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
    }

    
    @IBAction func openRegistr(sender: AnyObject) {
        
        //開啟註冊
        let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("RegistViewController") as RegistViewController
        presentViewController(viewController, animated: true, completion: nil)
        
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
