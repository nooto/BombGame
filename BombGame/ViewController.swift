//
//  ViewController.swift
//  SwiftProject
//
//  Created by GaoAng on 15/1/14.
//  Copyright (c) 2015年 SH. All rights reserved.
//

import UIKit


class ViewController: BaseViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var orderSecondTime : NSTimeInterval? = 60
    var timePickView : UIPickerView?
    var descriptionLabel : UILabel?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var timeLeabel:UILabel?
        var startButton:UIButton?
        
        self.setupTitleLabel()
//        self.adjustTitleViewStatue, titleLabelHiddeer: <#Bool#>, rightBtnHidde: <#Bool#>
        self.hiddeTitleView(true)
        setupTimePoroscee()
        
        setupDescription()
        setupStartButton()
        self.navigationController!.navigationBar.hidden = true
    }
    
    func setupTitleLabel(){
        var labeleWidht:CGFloat = 200
        var titleLabel:UILabel? = UILabel()
        titleLabel!.frame = CGRectMake(ScreenWIdht/2 - labeleWidht/2, 40, labeleWidht, 30)
        titleLabel!.text = "请选择爆炸时间"
        titleLabel!.textAlignment = NSTextAlignment.Center
        titleLabel!.font = UIFont.systemFontOfSize(20)
        self.view.addSubview(titleLabel!)
    }

    func setupTimePoroscee(){
        timePickView = UIPickerView()
        timePickView!.frame = CGRectMake(20, 100, ScreenWIdht - 40, 200)
        timePickView!.delegate = self;
        timePickView!.dataSource = self
        timePickView!.selectRow(1, inComponent: 0, animated: true)
        timePickView!.selectRow(0, inComponent: 1, animated: false)
//        timePickView!.backgroundColor = UIColor.grayColor()
        timePickView!.layer.borderColor = UIColor.grayColor().CGColor
        timePickView!.layer.borderWidth = 0.5
        timePickView!.layer.cornerRadius = 20
        self.view.addSubview(timePickView!)
        
        
        var minuteLabel : UILabel = UILabel()
        minuteLabel.text = "分"
        minuteLabel.font = UIFont.systemFontOfSize(20)
        minuteLabel.frame = CGRectMake(ScreenWIdht/2, self.timePickView!.frame.size.height / 2 , 40, 30)
        minuteLabel.textAlignment = NSTextAlignment.Center
        minuteLabel.center = CGPointMake(ScreenWIdht/2 - 20, self.timePickView!.center.y)
        minuteLabel.backgroundColor = UIColor.clearColor()
        self.view.addSubview(minuteLabel)
        
        
        var secondLabel : UILabel = UILabel()
        secondLabel.text = "秒"
        secondLabel.font = UIFont.systemFontOfSize(20)
        secondLabel.frame = CGRectMake(ScreenWIdht/2, 100, 40, 30)
        secondLabel.center = CGPointMake(ScreenWIdht/2  + 100, self.timePickView!.center.y)
        secondLabel.textAlignment = NSTextAlignment.Left
        secondLabel.backgroundColor = UIColor.clearColor()
        self.view.addSubview(secondLabel)
        
    }
    
    func setupDescription(){
        descriptionLabel = UILabel()
        descriptionLabel?.text = "炸弹将于1分钟后爆炸"
        descriptionLabel?.font = UIFont.systemFontOfSize(20)
        descriptionLabel!.frame = CGRectMake(0, CGRectGetMaxY(timePickView!.frame) + 30, ScreenWIdht, 40)
        descriptionLabel?.textAlignment = NSTextAlignment.Center
//        descriptionLabel?.backgroundColor = UIColor.grayColor()
        self.view.addSubview(descriptionLabel!)
    }
    
    func setupStartButton(){
        var startButton : UIButton? = UIButton()
        startButton!.frame = CGRectMake(ScreenWIdht/2-60, CGRectGetMaxY(descriptionLabel!.frame) + 30, 120, 40)
        startButton!.setTitle("开始游戏", forState: UIControlState.Normal)
        startButton!.setTitle("开始游戏", forState: UIControlState.Highlighted)
        startButton!.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
        startButton!.backgroundColor = UIColor.redColor()
        startButton!.layer.cornerRadius = 4.0
        startButton!.addTarget(self, action:"buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(startButton!)
    }
    
    func buttonAction(sender: UIButton){
        var bombView : BombViewController? = BombViewController()
        bombView?.orderSecond = orderSecondTime
        self.navigationController?.pushViewController(bombView!, animated: true)
    }
    
    func updataOrderSecondTime(minuter : Int , second : Int){
        orderSecondTime = NSTimeInterval(minuter * 60) + NSTimeInterval(second * 5)
        var  descrptin : NSString?
        if minuter != 0 && second != 0 {
            descrptin = "炸弹将于\(minuter)分\(second * 5)秒后爆炸"
        }
        else if minuter == 0  && second != 0{
            descrptin = "炸弹将于\(second  * 5 )秒后爆炸"
        }
        
        else if minuter != 0  && second == 0{
            descrptin = "炸弹将于\(minuter)分后爆炸"
        }
        
        descriptionLabel?.text = descrptin
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        if component == 0 {
            return 6
        }
        else{
            return 13
        }
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 44.0
    }
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 100.0
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if component == 0 {
            return String(row)
        }
        else{
            return String(row * 5)
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        var minutRow : Int = timePickView!.selectedRowInComponent(0)
        var secondRow : Int = timePickView!.selectedRowInComponent(1)
        

        if component == 0{
            if secondRow == 0 && minutRow == 0 {
                timePickView!.selectRow(6, inComponent: 1, animated: true)
            }
        }
        else{
            if secondRow == 0 && minutRow == 0 {
                timePickView!.selectRow(6, inComponent: 1, animated: true)
            }
        }
        updataOrderSecondTime(minutRow, second: secondRow)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

