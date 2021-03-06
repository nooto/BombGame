//
//  TitleView.swift
//  SwiftProject
//
//  Created by GaoAng on 15/1/23.
//  Copyright (c) 2015年 SH. All rights reserved.
//

import UIKit

protocol TitleViewlProtocol {
    mutating func leftButtonAction()
    mutating func rightButtonAction()
}

class TitleView: UIView {
    
    var titleLabel : UILabel? = UILabel()
    var leftButton : UIButton? = UIButton()
    var rightButton : UIButton? = UIButton()
    var titleProtocol : TitleViewlProtocol?
    
    func initTitleView(frame:CGRect) {
        self.frame = frame
        setupLeftButton()
        setupRightButton()
        setupViewTitleLabel()
    }
    
    //标题
    func setupViewTitleLabel(){
        titleLabel?.backgroundColor = UIColor.clearColor()
        titleLabel?.textAlignment = NSTextAlignment.Center
        titleLabel?.font = UIFont.systemFontOfSize(20)
        titleLabel?.frame = CGRectMake(GAP + TitleViewHeigh, 20, ScreenWIdht - GAP * 2 - TitleViewHeigh * 2 , TitleViewHeigh)
        self.addSubview(titleLabel!)
    }
    
    func setTitle(title : NSString){
        if title.length > 0 {
            titleLabel?.text = title as String
        }
    }
    
    //左侧按钮。
    func setupLeftButton(){
        leftButton?.frame = CGRectMake(GAP, 20, TitleViewHeigh, TitleViewHeigh)
        leftButton?.backgroundColor = UIColor.clearColor()
        leftButton?.setImage(UIImage(named: "ic_return_nor.png"), forState: UIControlState.Normal)
        leftButton?.showsTouchWhenHighlighted = true
        leftButton?.addTarget(self, action: "leftButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(leftButton!)
    }
    
    func leftButtonAction(sender: UIButton){
        self.titleProtocol?.leftButtonAction()
    }
    
    //右侧按钮。
    func setupRightButton(){
        var rightButton : UIButton = UIButton()
        rightButton.frame = CGRectMake(ScreenWIdht - GAP - TitleViewHeigh, 20, TitleViewHeigh, TitleViewHeigh)
        rightButton.backgroundColor = UIColor.clearColor()
        rightButton.addTarget(self, action: "rightButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        rightButton.showsTouchWhenHighlighted = true
        self.addSubview(rightButton)
    }
    
    func rightButtonAction(sender: UIButton){
        self.titleProtocol?.rightButtonAction()
    }
    
    //
    func adjustTitleViewStatue(leftBtnHidde : Bool, titleLabelHiddeer:Bool, rightBtnHidde: Bool){
        //        self.lef
    }


}
