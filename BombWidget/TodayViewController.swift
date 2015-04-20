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
    var contentView:UIView = UIView()
    var btnTest:UIButton = UIButton()
    var tipLabel:UILabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.preferredContentSize = CGSizeMake(0, 100)
        contentView.frame = self.view.frame
        contentView.backgroundColor = UIColor.clearColor()
        self.view .addSubview(contentView);
        
        self.tipLabel.text = "一个人的状态总是最糟的~"
        self.tipLabel.frame = CGRectMake(0, 0, 200, 20)
        tipLabel.frame = CGRectMake(160, 20, 300, 30)
        tipLabel.textColor = UIColor.whiteColor()
        tipLabel.textAlignment = NSTextAlignment.Center
        tipLabel.backgroundColor = UIColor.clearColor()
        self.view .addSubview(tipLabel)
        
        self.btnTest.setTitle("随机开始", forState: UIControlState.Normal)
        btnTest.backgroundColor = UIColor.clearColor()
        btnTest.addTarget(self, action: "startButtonAction", forControlEvents: UIControlEvents.TouchUpInside)
        self.view .addSubview(btnTest)
        btnTest.layer.borderWidth = 0.5
        btnTest.layer.borderColor = UIColor.whiteColor().CGColor
        btnTest.frame = CGRectMake(160, 60 - 15, 80, 30)
        btnTest.layer.cornerRadius = 4.0
        
        tipLabel.center = CGPointMake(btnTest.center.x, btnTest.frame.origin.y - tipLabel.frame.size.height)
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
    
    func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsetsZero;
    }
    
    @IBAction func startButtonAction(){
//        NSURL *url = [NSURL URLWithString:@"martinapp://com.martin.app"];
//        [[UIApplication sharedApplication] openURL:url];
        
//        UIApplication.sharedApplication().openURL(url!)
        self.extensionContext?.openURL(NSURL(string: "bombGameScheme://")!, completionHandler: nil)
    }
    
}
