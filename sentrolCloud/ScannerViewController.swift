//
//  ScannerViewController.swift
//  sentrolCloud
//
//  Created by mac mini 4 nhr on 2015/3/20.
//  Copyright (c) 2015年 Nietzsche. All rights reserved.
//

import UIKit
import AVFoundation

class ScannerViewController: UIViewController,AVCaptureMetadataOutputObjectsDelegate {

    @IBAction func dismissSelf(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBOutlet var numberLable: UILabel!
    //掃描容器
    @IBOutlet var scannerView: UIView!
    
    //掃描
    @IBOutlet var scannerGreen: UIImageView!
    @IBOutlet var greenTopSpace: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.numberLable.alpha = 0
        self.copyNumberBtn.alpha = 0

        captureQRCode()
        
        self.scannerGreen.alpha = 0
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func captureQRCode() {
        let session = AVCaptureSession()
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        let input = AVCaptureDeviceInput.deviceInputWithDevice(device, error: nil) as AVCaptureDeviceInput
        session.addInput(input)
        
        let output = AVCaptureMetadataOutput()
        output.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        session.addOutput(output)
        output.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        let bounds = self.scannerView.layer.bounds
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        previewLayer.bounds = bounds
        previewLayer.position = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds))
        self.scannerView.layer.addSublayer(previewLayer)
        session.startRunning()
    }
    
    
    var gg : CGFloat = 0
    var getNumber: String = ""
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        for item in metadataObjects {
            if let metadataObject = item as? AVMetadataMachineReadableCodeObject {
                if metadataObject.type == AVMetadataObjectTypeQRCode {
                    
                    
                    
                    
                    
                    if(self.getNumber != metadataObject.stringValue){
                        self.scannerGreen.alpha = 1
                        
                        UIView.animateWithDuration(1.5, animations: {
                            
                            connection.enabled = false
                            
                            
                            
                            self.scannerGreen.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 66)
                           // self.greenTopSpace.constant = self.view.frame.size.height
                            
                            
                            
                            }, completion: {
                                (value: Bool) in
                                
                                self.getNumber = metadataObject.stringValue
                                println("QR Code:\(metadataObject.stringValue)")
                                
                                connection.enabled = true
                                
                                //self.greenTopSpace.constant = 64
                                self.copyNumberBtn.alpha = 1
                                self.numberLable.alpha = 1
                                self.scannerGreen.frame = CGRectMake(0, 64, self.view.frame.size.width, 66)
                                self.scannerGreen.alpha = 0
                                self.numberLable.text = self.getNumber
                                
                                
                                
                        })
                    
                    }
                    
                    
                    
                    
                    
                }
            }
        }
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
    
    @IBOutlet var copyNumberBtn: UIButton!
    @IBAction func copyNumber(sender: AnyObject) {
        
        UIPasteboard.generalPasteboard().string = self.getNumber
        
        self.makeAlert("Copy \(self.getNumber)")
        
        
        
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
