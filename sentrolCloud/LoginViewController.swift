//
//  LoginViewController.swift
//  sentrolCloud
//
//  Created by jianwei on 2015/3/2.
//  Copyright (c) 2015年 Nietzsche. All rights reserved.
//

import UIKit
import CoreData

protocol  LoginViewControllerProtocol{

    
func dimissLogininVC()
}


class LoginViewController: UIViewController {
    
    var delegate:LoginViewControllerProtocol?
    var dataSource:LoginViewControllerProtocol?
    
    var mainVC : UIViewController!
    
    var people = [NSManagedObject]()
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //先撈本機資料庫
       // fetched_Person_Results()
        
        //圓角
        singInBtn.layer.cornerRadius = 21
        joinUsBtn.layer.cornerRadius = 10.5
         
        
        
        
        
        
    }
    
    
    
    
    
    
    
    //logo頂間距
    @IBOutlet weak var logoTopSpace: NSLayoutConstraint!
    
    //登入按鈕 加入按鈕
    @IBOutlet weak var singInBtn: UIButton!
    @IBOutlet weak var joinUsBtn: UIButton!
    
    
    
    //帳號
    @IBOutlet weak var acctEmailTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    
    //loginBtnAction
    @IBAction func singInClick(sender: AnyObject) {
        
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
        saveCoreData_Person("account", value: self.acctEmailTF.text)
        saveCoreData_Person("password", value: self.passTF.text)
        
        //開始進入雲端
        connectSentrolCloud()
    }
    
    //開始進入雲端
    func connectSentrolCloud(){
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
                    var country = responseDict["country"] as String!
                    var first_name = responseDict["first_name"] as String!
                    var language = responseDict["language"] as String!
                    var last_name = responseDict["last_name"] as String!
                    
                    self.saveCoreData_Person("country", value: country)
                    self.saveCoreData_Person("first_name", value: first_name)
                    self.saveCoreData_Person("language", value: language)
                    self.saveCoreData_Person("last_name", value: last_name)
                    
                    let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("ViewController") as UIViewController
                    self.navigationController?.setViewControllers([viewController], animated: false)

                    
//                    let ViewControllerVC = storyboard?.instantiateViewControllerWithIdentifier("ViewController") as ViewController
//                    presentViewController(ViewControllerVC, animated: true, completion:nil)
//                    
                }else{
                
                
                }
                
                
                
                overlay?.removeFromSuperview()
                
                //關掉登入
                self.delegate?.dimissLogininVC()
                
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
      //  println("key & value: \(key), \(value)")
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
        people.append(person)
        
        fetched_Person_Results()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        var vc = ViewController()
//        self.presentViewController(vc, animated: true, completion: nil)
//        
        
        
        //先進入
        let viewController = storyboard?.instantiateViewControllerWithIdentifier("ViewController") as UIViewController
        self.presentViewController(viewController, animated: true, completion:nil)
        
        
        
        //偵測旋轉
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "rotated", name: UIDeviceOrientationDidChangeNotification, object: nil)
        
        // Do any additional setup after loading the view.
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
                var accountString:String
                //accountString = results.valueForKey("account") as String
                
                //println("local data \(accountString)")
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
