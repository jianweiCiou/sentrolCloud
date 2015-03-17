//
//  FeedbackViewController.swift
//  sentrolCloud
//
//  Created by jianwei on 2015/3/4.
//  Copyright (c) 2015年 Nietzsche. All rights reserved.
//

import UIKit

class FeedbackViewController: UIViewController {

    @IBOutlet var dismissBtn: UIButton!
    
    //資料array
    var colors = ["機器1","機器2","機器3","機器4"]
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("1.滾範圍\(scrollView.frame.size.width)")
        
        scrollView.frame = self.view.frame
        scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 600)
        

        println("2.滾範圍\(scrollView.contentSize.width)")
        
        // Do any additional setup after loading the view.
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
