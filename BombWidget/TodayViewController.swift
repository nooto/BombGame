//
//  TodayViewController.swift
//  BombWidget
//
//  Created by GaoAng on 15/2/26.
//  Copyright (c) 2015年 SH. All rights reserved.
//

import UIKit

import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view from its nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }
    
    @IBAction func startButtonAction(){
//        NSURL *url = [NSURL URLWithString:@"martinapp://com.martin.app"];
//        [[UIApplication sharedApplication] openURL:url];
        
//        UIApplication.sharedApplication().openURL(url!)
        self.extensionContext?.openURL(NSURL(string: "bombGameScheme://")!, completionHandler: nil)
    }
    
}
