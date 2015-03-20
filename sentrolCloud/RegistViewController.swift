//
//  RegistViewController.swift
//  sentrolCloud
//
//  Created by mac mini 4 nhr on 2015/3/18.
//  Copyright (c) 2015年 Nietzsche. All rights reserved.
//

import UIKit

class RegistViewController: UIViewController, UITextFieldDelegate {

    //資料array
    var colors = ["English","繁體中文","简体中文","français","Deutsch","português","española","日本語"]
    
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var termView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        termView.alpha = 0

        // Do any additional setup after loading the view.
    }

    //展開條款
    @IBAction func openTermView(sender: AnyObject) {
        
        termView.alpha = 1
        mainView.alpha = 0
    }
    
    
    //隱藏條款
    @IBAction func closeTermView(sender: AnyObject) {
        termView.alpha = 0
        mainView.alpha = 1
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    @IBAction func dismissView(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    func textFieldShouldReturn(textField: UITextField!) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        return true;
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
