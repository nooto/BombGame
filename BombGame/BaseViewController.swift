//
//  BaseViewController.swift
//  SwiftProject
//
//  Created by GaoAng on 15/1/23.
//  Copyright (c) 2015年 SH. All rights reserved.
//

import UIKit

let backColor : UIColor =   UIColor(red: 22/255, green: 203/255, blue: 152/255, alpha: 1.0)
let viewBGColor : UIColor = UIColor(red: 237/250, green:241/255 , blue: 248/55, alpha: 1)
class BaseViewController: UIViewController , TitleViewlProtocol{
    var showNav :Bool = true
    var titleView :TitleView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTitleView()
//        self.view.backgroundColor = viewBGColor
        self.view.backgroundColor = UIColor.whiteColor()
    }
    
    //标题栏
    func setupTitleView(){
        self.titleView = TitleView()
        self.titleView?.initTitleView(CGRectMake(0, 0, ScreenWIdht, TitleViewHeighMax))
        titleView?.backgroundColor = UIColor.grayColor()
        titleView?.backgroundColor = backColor
        titleView?.titleProtocol = self
        self.view.addSubview(titleView!)
    }
    
    //左右按钮响应时间阿牛。
    func leftButtonAction() {
        
    }
    
    func rightButtonAction() {
        
    }

    func hiddeTitleView(hidder :Bool){
        self.titleView?.hidden = hidder
    }
    
    func adjustTitleViewStatue(leftBtnHidde : Bool, titleLabelHiddeer:Bool, rightBtnHidde: Bool){
    }

    func setTitleViewTitle(title : NSString){
        self.titleView?.setTitle(title)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
