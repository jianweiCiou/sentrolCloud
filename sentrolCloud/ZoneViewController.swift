//
//  ZoneViewController.swift
//  sentrolCloud
//
//  Created by mac mini 4 nhr on 2015/3/10.
//  Copyright (c) 2015年 Nietzsche. All rights reserved.
//

import UIKit

class ZoneViewController: UIViewController,ZoneAddTableViewCellProtocol, ZoneEditDeleteTableViewCellProtocol, SelectCategoryProtocol ,UIPageViewControllerDelegate{
    
    
    
    @IBOutlet weak var btnClickMe: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    var picker:UIImagePickerController?=UIImagePickerController()
    var popover:UIPopoverController?=nil
    
    
    //選內容內容區
    var SeleCateVC: SelectCategoryController!
    

    @IBOutlet weak var tableViewTopSpace: NSLayoutConstraint!
    
    //表格cell
    let AddCellIdentifier = "ZoneAddTableViewCell"//新增section
    let EditCellIdentifier = "ZoneEditDeleteTableViewCell" //編輯與刪除section
    let cellIdentifier = "ZoneTableViewCell"
    let headerCellIdentifier = "ZoneSectionTableViewCell" //一般section
    
    //
    @IBOutlet weak var mainTableView: UITableView!
    
    
    
    //取得資料內容
    var tableData = [AnyObject]()
    var resultsArray: NSMutableArray!//本
    
    var selectArray: NSMutableArray!//類別
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         
        self.view.backgroundColor = UIColor.clearColor()
        mainTableView.backgroundColor = UIColor.clearColor()
        
        //println("表格頂距\(tableViewTopSpace.constant)")
        
        //長壓cell
        let longpress = UILongPressGestureRecognizer(target: self, action: "longPressGestureRecognized:")
        mainTableView.addGestureRecognizer(longpress)
        
        //讀取列表資料
        //讀資料
        let bundle = NSBundle.mainBundle()
        let path = bundle.pathForResource("SettingList", ofType: "json")
        let data: NSData? = NSData(contentsOfFile: path!)
        if data != nil {
            let content = NSString(data: data!, encoding:NSUTF8StringEncoding) as String
            //println("\(content)")
            
            let jsonResult: Dictionary = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers, error: nil) as Dictionary<String, AnyObject>
            
            // println("\(jsonResult)")
            
            
            let results: NSMutableArray = jsonResult["SettingListArray"] as NSMutableArray
            resultsArray = results
            
            for item in resultsArray {
                // println("解析\(item)")
                // self.tableData.append(item)
            }
            
        }
        
        
        //預備內容區
        var storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        SeleCateVC = storyboard.instantiateViewControllerWithIdentifier("SelectCategoryController") as SelectCategoryController
        addChildViewController(SeleCateVC)
        SeleCateVC.view.frame = self.view.frame
        self.view.addSubview(SeleCateVC.view)
        SeleCateVC.didMoveToParentViewController(self)
        SeleCateVC.resultsArray = resultsArray
        SeleCateVC.view.alpha = 0
        SeleCateVC.delegate = self

        // Do any additional setup after loading the view.
    }
    
    func longPressGestureRecognized(gestureRecognizer: UIGestureRecognizer) {
        
        let longPress = gestureRecognizer as UILongPressGestureRecognizer
        
        let state = longPress.state
        
        var locationInView = longPress.locationInView(mainTableView)
        
        var indexPath = mainTableView.indexPathForRowAtPoint(locationInView)
        
        println("長按row\(indexPath?.row)")
        println("長按section\(indexPath?.section)")
        
        
        
        struct My {
            static var cellSnapshot : UIView? = nil
        }
        struct Path {
            static var initialIndexPath : NSIndexPath? = nil
        }
        
        
        
        switch state {
        case UIGestureRecognizerState.Began:
            if indexPath != nil {
                Path.initialIndexPath = indexPath
                let cell = mainTableView.cellForRowAtIndexPath(indexPath!) as UITableViewCell!
                My.cellSnapshot = snapshopOfCell(cell)
                var center = cell.center
                My.cellSnapshot!.center = center
                My.cellSnapshot!.alpha = 0.0
                mainTableView.addSubview(My.cellSnapshot!)
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    center.y = locationInView.y
                    My.cellSnapshot!.center = center
                    My.cellSnapshot!.transform = CGAffineTransformMakeScale(1.05, 1.05)
                    My.cellSnapshot!.alpha = 0.98
                    cell.alpha = 0.0
                }, completion: { (finished) -> Void in
                    if finished {
                        cell.hidden = true
                    }
                })
            }
            
        case UIGestureRecognizerState.Changed:
            
            
            var center = My.cellSnapshot!.center
            center.y = locationInView.y
            My.cellSnapshot!.center = center
            
            
            if ((indexPath != nil) && (indexPath != Path.initialIndexPath)) {
                
                var distRow: NSDictionary = resultsArray[indexPath!.section].valueForKey("gatewayList")?.objectAtIndex(indexPath!.row) as NSDictionary
                
                var orgRow: NSDictionary = resultsArray[Path.initialIndexPath!.section].valueForKey("gatewayList")?.objectAtIndex(Path.initialIndexPath!.row) as NSDictionary
                
                println("indexPath \(indexPath?.section) Path.initialIndexPath \(Path.initialIndexPath?.section)")
                
               // println("\(indexPath!.section) 來交換 \(Path.initialIndexPath!.section)")
                
                //swap(&resultsArray[indexPath!.row], &resultsArray[Path.initialIndexPath!.row])
                
                //mainTableView.reloadData()
                
                
                //判斷有沒有移動到其他section
                if(indexPath?.section == Path.initialIndexPath?.section){
                    
                    swap(&distRow, &orgRow)
                    mainTableView.moveRowAtIndexPath(Path.initialIndexPath!, toIndexPath: indexPath!)
                    Path.initialIndexPath = indexPath
                    
                }else{
                    
                }
                
            }
            
        default:
            println(" 換")
            if(indexPath?.section == 0){
                Path.initialIndexPath = nil
                My.cellSnapshot!.removeFromSuperview()
                My.cellSnapshot = nil
                return
            }
            let cell = mainTableView.cellForRowAtIndexPath(Path.initialIndexPath!) as UITableViewCell!
            cell.hidden = false
            cell.alpha = 0.0
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                My.cellSnapshot!.center = cell.center
                My.cellSnapshot!.transform = CGAffineTransformIdentity
                My.cellSnapshot!.alpha = 0.0
                cell.alpha = 1.0
                }, completion: { (finished) -> Void in
                    if finished {
                        Path.initialIndexPath = nil
                        My.cellSnapshot!.removeFromSuperview()
                        My.cellSnapshot = nil
                        
                    }
            })
            
        }
    }
    
    //點選
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        
         var listArray:NSArray = resultsArray.objectAtIndex(indexPath.section).valueForKey("gatewayList") as NSArray
        
        SeleCateVC.view.alpha = 1
        SeleCateVC.orgSectionNumber = indexPath.section
        SeleCateVC.orgCellNumber = indexPath.row
        SeleCateVC.resultsArray = resultsArray
        SeleCateVC.mainTableViewReload()
        
    }
    
    
    func snapshopOfCell(inputView: UIView) -> UIView {
        UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, false, 0.0)
        inputView.layer.renderInContext(UIGraphicsGetCurrentContext())
        let image = UIGraphicsGetImageFromCurrentImageContext() as UIImage
        UIGraphicsEndImageContext()
        let cellSnapshot : UIView = UIImageView(image: image)
        cellSnapshot.layer.masksToBounds = false
        cellSnapshot.layer.cornerRadius = 0.0
        cellSnapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0)
        cellSnapshot.layer.shadowRadius = 5.0
        cellSnapshot.layer.shadowOpacity = 0.4
        return cellSnapshot
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // 1
        return resultsArray.count
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 2
        var listCount = 0
        
        for var index = 0; index < resultsArray.count; ++index {
            //add區
            if(section == 0){
                listCount = 1
            }
            if(section == index && section != 0){
                var listArray:NSArray = resultsArray.objectAtIndex(index).valueForKey("gatewayList") as NSArray
                listCount = listArray.count
            }
        }
        return listCount
    }
    
    
    //分類標題
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        //一般用
        var nib = UINib(nibName: self.headerCellIdentifier, bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: self.headerCellIdentifier)
        
        var headerCell:ZoneSectionTableViewCell = tableView.dequeueReusableCellWithIdentifier(self.headerCellIdentifier) as ZoneSectionTableViewCell
        
        //編輯用
        var editNib = UINib(nibName: self.EditCellIdentifier, bundle: nil)
        tableView.registerNib(editNib, forCellReuseIdentifier: self.EditCellIdentifier)
        
        var EditCell:ZoneEditDeleteTableViewCell = tableView.dequeueReusableCellWithIdentifier(self.EditCellIdentifier) as ZoneEditDeleteTableViewCell
        EditCell.delegate = self
        
    
        
        for var index = 0; index < resultsArray.count; ++index {
            var className: String = resultsArray.objectAtIndex(index).valueForKey("className") as String
            
            var classImage: String = resultsArray.objectAtIndex(index).valueForKey("classImage") as String
            
            if(section == index){
                //一般
                headerCell.headerLabel.text = className
                headerCell.icon.image = UIImage(named: "\(classImage).png")
                
                //編輯用
                EditCell.headerLabel.text = className
                EditCell.icon.image = UIImage(named: "\(classImage).png")
            }
        }
        
        
        if(section != 0 && section != (resultsArray.count - 1 )){
            return EditCell
        }else{
            return headerCell
        
        }
        
        
    }
    //高
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    //分類內容
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //add
        var addNib = UINib(nibName: self.AddCellIdentifier, bundle: nil)
        tableView.registerNib(addNib, forCellReuseIdentifier: self.AddCellIdentifier)
        var AddCell:ZoneAddTableViewCell = tableView.dequeueReusableCellWithIdentifier(self.AddCellIdentifier) as ZoneAddTableViewCell
        AddCell.delegate = self
        
        //一般
        var nib = UINib(nibName: self.cellIdentifier, bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: self.cellIdentifier)
        var cell:ZoneTableViewCell = tableView.dequeueReusableCellWithIdentifier(self.cellIdentifier) as ZoneTableViewCell
        
        cell.backgroundColor = UIColor.clearColor()
        //section
        for var index = 0; index < resultsArray.count; ++index {
            
            if(indexPath.section == index && indexPath.section != 0){
                var listArray:NSArray = resultsArray.objectAtIndex(index).valueForKey("gatewayList") as NSArray
                
                //Listlist
                for var indexCell = 0; indexCell < listArray.count; ++indexCell {
                    
                    if(indexPath.section == index){
                        if(indexPath.row == indexCell){
                            
                            var typeName:String
                            typeName = listArray.objectAtIndex(indexCell).valueForKey("type") as String
                            cell.type.text = typeName
                            cell.name.text = listArray.objectAtIndex(indexCell).valueForKey("name") as? String
                            
                            cell.icon.image = UIImage(named: "icon_\(typeName).png")
                            
                        }
                        
                    }
                    
                }
            }
        }
        
        if(indexPath.section == 0){
            return AddCell
            
        }else{
            return cell
        }
    }
    //高
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 58
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //新增功能
    func saveClassification(name:String){
        
        var getValue: NSMutableArray = []
        
        var airports: [String: AnyObject] = ["className": name,"classImage": "","gatewayList":getValue]
        
        resultsArray.insertObject(airports, atIndex:1)
       
       self.mainTableView.reloadData()
     
    }
    
    var wantDeleteClassName:String!
    
    //確認刪除
    func checkIfDeeleteClassification(name:String){
    
        self.wantDeleteClassName = name
        
        let alert = UIAlertView()
        alert.delegate = self
        alert.title = ""
        alert.message = "Delete \(name) ?"
        alert.addButtonWithTitle("Ok")
        alert.addButtonWithTitle("Cancelled")
        alert.show()
        
    }
    
    
    func alertView(View: UIAlertView!, clickedButtonAtIndex buttonIndex: Int){
        
        switch buttonIndex{
            case 0:
            DeeleteClassification(wantDeleteClassName)
            break;
        default:
            break;
        }
    }
    
    //進行 物件類別
    func DeeleteClassification(name:String){
        
        var deleteIndex:Int
        
        for var indexCell = 0; indexCell < resultsArray.count; ++indexCell {
            
            var resName :String = resultsArray.objectAtIndex(indexCell).valueForKey("className") as String
            
            if (resName == name){
                
                //要被移除的類別 內部有沒有資料
                var listArray:NSArray = resultsArray.objectAtIndex(indexCell).valueForKey("gatewayList") as NSArray
                
                if(listArray.count != 0){
                    
                    //1.產生新
                    var NewGatewayList: NSMutableArray = []
                    
                    //2.把undefind data裝入新NewGatewayList
                    var oldUndefinedlIST:NSArray = resultsArray.objectAtIndex(resultsArray.count-1).valueForKey("gatewayList") as NSArray
                    for var indexCell = 0; indexCell < oldUndefinedlIST.count; ++indexCell {
                        var cellObg:NSDictionary = oldUndefinedlIST.objectAtIndex(indexCell) as NSDictionary
                        NewGatewayList.addObject(cellObg)
                    }
                    
                    //3.把data裝進NewGatewayList
                    for var indexCell = 0; indexCell < listArray.count; ++indexCell {
                        var cellObg:NSDictionary = listArray.objectAtIndex(indexCell) as NSDictionary
                        NewGatewayList.addObject(cellObg)
                    }
                    
                    var airports: [String: AnyObject] = ["className": "Undefined","classImage": "","gatewayList":NewGatewayList]
                    resultsArray.removeLastObject()
                    resultsArray.insertObject(airports, atIndex:(resultsArray.count))
                    self.mainTableView.reloadData()
                }
            
                resultsArray.removeObjectAtIndex(indexCell)
                
                self.mainTableView.reloadData()
            }
        }
    }
    
    //alert
    func makeAlert(message: String){
        let alert = UIAlertView()
        alert.message = message
        alert.addButtonWithTitle("Ok")
        alert.addButtonWithTitle("Cancelled")
        alert.show()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let indexPath = tableView.indexPathForSelectedRow();
    }
    //
    func reloadSelectArray(){
        self.resultsArray = SeleCateVC.resultsArray
        mainTableView.reloadData()
    }
    
    
    
    //編輯section 新new name
    func editNewClassName(name:String, oldName:String){
        println("\(oldName) 要重新編輯 \(name)")
        //1.先取得 index
        var sectionNumber:Int!
        
        for var indexCell = 0; indexCell < resultsArray.count; ++indexCell {
            var targetName: String = resultsArray.objectAtIndex(indexCell).valueForKey("className") as String
            
            if(targetName == oldName){
                println(" 找到了 \(targetName) 要重新編輯 ")
                resultsArray.objectAtIndex(indexCell).setValue(name, forKey: "className")
                mainTableView.reloadData()
            }
        }
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]!)
    {
        picker .dismissViewControllerAnimated(true, completion: nil)
        imageView.image=info[UIImagePickerControllerOriginalImage] as? UIImage
        println("選到圖片")
        //sets the selected image to image view
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController!)
    {
        println("picker cancel.")
    }
    
    
    func openGallary()
    {
        picker!.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone
        {
            self.presentViewController(picker!, animated: true, completion: nil)
        }
        else
        {
            popover=UIPopoverController(contentViewController: picker!)
            popover!.presentPopoverFromRect(btnClickMe.frame, inView: self.view, permittedArrowDirections: UIPopoverArrowDirection.Any, animated: true)
        }
    }
    
    //選擇相簿
    func openImagePicker(){
        println("選擇相簿")
    
       
         self.openGallary()
    
    }
    
    
    
}
