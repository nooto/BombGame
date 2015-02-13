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
    var timePickView : UIPickerView = UIPickerView()
    var descriptionLabel : UILabel = UILabel(){
        didSet{
            self.showAnimat = !self.showAnimat
            self .startAnimate()
        }
    }
    
    var timeButton : UISegmentedControl = UISegmentedControl()
    var showAnimat : Bool = false
    var randomView : RangeSlider =  RangeSlider(frame: (CGRectMake(20, 100, ScreenWIdht - 40, 40)))

    
    var  minLabel : UILabel = UILabel()
    var  maxLabel : UILabel = UILabel()
    var  lowerLabel : UILabel = UILabel()
    var  upperLabel : UILabel = UILabel()
    
    var  posY : CGFloat = 0.0;
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var timeLeabel:UILabel?
        var startButton:UIButton?
        
        self.posY = 20.0;
//        self.hiddeTitleView(false)
        self.navigationController!.navigationBar.hidden = true
        adjustTitleViewStatue(true, titleLabelHiddeer: false, rightBtnHidde: true)
        setTitleViewTitle("设置炸弹爆炸时间")
        
        if self.titleView!.hidden == false {
            posY += self.titleView!.frame.size.height;
        }
        
        setupModleLabel()

        
        //时间选择。
        setupTimePoroscee()
        setupRandomlView()
        
        //时间提示
        setupDescription()
        
        //游戏提示。
        setupHowToPlayLabel()
        
        segmentAction()
        rangeSliderValueChanged(randomView)
        //开始按钮。
        setupStartButton()
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_SEC))
        
        dispatch_after(time, dispatch_get_main_queue()) {
            self.randomView.trackHighlightTintColor = UIColor.redColor()
            self.randomView.curvaceousness = 0.0
        }
    }
    
    func setupModleLabel(){
        var labeleWidht:CGFloat = 200
        timeButton = UISegmentedControl(items: ["随机", "定时"])
        timeButton.frame = CGRectMake(ScreenWIdht/2 - labeleWidht/2, posY , labeleWidht, 40)
        timeButton.backgroundColor = UIColor.clearColor()
        self.view.addSubview(timeButton)
        timeButton.addTarget(self, action:"segmentAction", forControlEvents: UIControlEvents.ValueChanged)
        timeButton.selectedSegmentIndex = 0
        timeButton.sendActionsForControlEvents(UIControlEvents.ValueChanged)
        posY += timeButton.frame.size.height + 10
    }
    
    func segmentAction(){
        self.view.viewWithTag(100000)?.hidden = !( timeButton.selectedSegmentIndex == 1)
        self.view.viewWithTag(100001)?.hidden = !( timeButton.selectedSegmentIndex == 1)
        timePickView.hidden = !( timeButton.selectedSegmentIndex == 1)
        
        randomView.hidden = timeButton.selectedSegmentIndex == 1
        lowerLabel.hidden = randomView.hidden
        upperLabel.hidden = lowerLabel.hidden
        
        
        if timeButton.selectedSegmentIndex == 0{
            rangeSliderValueChanged(randomView)
        }
        else{
            var minutRow : Int = timePickView.selectedRowInComponent(0)
            var secondRow : Int = timePickView.selectedRowInComponent(1)
            updataOrderSecondTime(minutRow, second: secondRow)
        }
    }

    func setupTimePoroscee(){
        timePickView.frame = CGRectMake(20, posY, ScreenWIdht - 40, 200)
        timePickView.delegate = self;
        timePickView.dataSource = self
        timePickView.selectRow(1, inComponent: 0, animated: true)
        timePickView.selectRow(0, inComponent: 1, animated: false)
        timePickView.layer.borderColor = backColor.CGColor
        timePickView.layer.borderWidth = 1
        timePickView.layer.cornerRadius = 20
        self.view.addSubview(timePickView)
        
        
        var minuteLabel : UILabel = UILabel()
        minuteLabel.text = "分"
        minuteLabel.tag = 100000
        minuteLabel.font = UIFont.systemFontOfSize(20)
        minuteLabel.frame = CGRectMake(ScreenWIdht/2, self.timePickView.frame.size.height / 2 , 40, 30)
        minuteLabel.textAlignment = NSTextAlignment.Center
        minuteLabel.center = CGPointMake(ScreenWIdht/2 - 20, self.timePickView.center.y)
        minuteLabel.backgroundColor = UIColor.clearColor()
        self.view.addSubview(minuteLabel)
        
        
        var secondLabel : UILabel = UILabel()
        secondLabel.text = "秒"
        secondLabel.tag = 100001
        secondLabel.font = UIFont.systemFontOfSize(20)
        secondLabel.frame = CGRectMake(ScreenWIdht/2, 100, 40, 30)
        secondLabel.center = CGPointMake(ScreenWIdht/2  + 100, self.timePickView.center.y)
        secondLabel.textAlignment = NSTextAlignment.Left
        secondLabel.backgroundColor = UIColor.clearColor()
        self.view.addSubview(secondLabel)
    }
    
    func setupRandomlView(){
        randomView.center = CGPointMake(ScreenWIdht/2, timePickView.center.y)
        randomView.backgroundColor = UIColor.clearColor()
        randomView.addTarget(self, action: "rangeSliderValueChanged:", forControlEvents: .ValueChanged)
        self.view.addSubview(randomView)
        self.randomView.hidden = true
    
        lowerLabel.frame = CGRectMake(CGRectGetMaxX(randomView.frame), CGRectGetMinY(randomView.frame) - CGRectGetHeight(randomView.frame) + 20, 60, CGRectGetHeight(randomView.frame) - 20)
        lowerLabel.backgroundColor = UIColor.clearColor()
        lowerLabel.textAlignment = NSTextAlignment.Center
        self.view.addSubview(lowerLabel)
        
        upperLabel.frame = CGRectMake(CGRectGetMaxX(randomView.frame), CGRectGetMinY(randomView.frame) - CGRectGetHeight(randomView.frame) + 20, 60, CGRectGetHeight(randomView.frame) - 20)
        upperLabel.backgroundColor = UIColor.clearColor()
        upperLabel.textAlignment = NSTextAlignment.Center
        self.view.addSubview(upperLabel)
    }
    
    
    func setupDescription(){
        descriptionLabel.text = "炸弹将于1分钟后爆炸"
        descriptionLabel.font = UIFont.systemFontOfSize(20)
        descriptionLabel.frame = CGRectMake(0, CGRectGetMaxY(timePickView.frame) + 10, ScreenWIdht, 40)
        descriptionLabel.textAlignment = NSTextAlignment.Center
        descriptionLabel.textColor = UIColor.redColor()
        self.view.addSubview(descriptionLabel)
    }
    
    func startAnimate(){
        var k : CAKeyframeAnimation? = CAKeyframeAnimation(keyPath: "transform.scale")
        k!.values = [0.9, 1.0, 1.1]
        k!.keyTimes = [0.0, 0.3, 0.6, 1.0]
        k!.calculationMode = kCAAnimationLinear
        self.descriptionLabel.layer.addAnimation(k, forKey: "SHOW")
    }
    
    func setupHowToPlayLabel(){
      var   tempLalbel = UILabel()
        tempLalbel.text = "唱K，聚餐，聚会时，几个朋友一起来bomb一下吧！\n个人先定好时间，不要让其他人知道呦.然后点击开始游戏并提一个问题，再传给下一个朋友，下一个朋友回答完再提一个问题，然后再传给下一个朋哟，依次这样下去，炸弹最终在谁的手中响了，谁就输了。这时候就可以开始惩罚他了，唱歌，跳舞，说笑话，真心话大冒险种种都可以招呼他了，惩罚完由上一局输的朋友设定新的时间继续开始。。。。"
        tempLalbel.font = UIFont.systemFontOfSize(10)
        tempLalbel.numberOfLines = 20
        tempLalbel.frame = CGRectMake(20, CGRectGetMaxY(self.descriptionLabel.frame)-10, ScreenWIdht-40, 100)
        tempLalbel.textAlignment = NSTextAlignment.Left
        self.view.addSubview(tempLalbel)
    }
    
    func setupStartButton(){
        var startButton : UIButton? = UIButton()
        startButton!.frame = CGRectMake(20, ScreenHight - 60, ScreenWIdht - 40, 40)
        startButton!.setTitle("开始游戏", forState: UIControlState.Normal)
        startButton!.setTitle("开始游戏", forState: UIControlState.Highlighted)
        startButton!.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
        startButton!.backgroundColor = backColor
        startButton!.layer.cornerRadius = 4.0
        startButton!.addTarget(self, action:"buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(startButton!)
    }
    
    func buttonAction(sender: UIButton){
        var bombView : BombViewController? = BombViewController()
        bombView?.orderSecond = orderSecondTime!
        self.navigationController?.pushViewController(bombView!, animated: true)
    }
    
    func updataOrderSecondTimeRandow(min: Int , max: Int){
        descriptionLabel.text = "炸弹将于\(min)秒到\(max)秒 间随机爆炸）"
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
        
        descriptionLabel.text = descrptin
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
        
        var minutRow : Int = timePickView.selectedRowInComponent(0)
        var secondRow : Int = timePickView.selectedRowInComponent(1)
        

        if component == 0{
            if secondRow == 0 && minutRow == 0 {
                timePickView.selectRow(6, inComponent: 1, animated: true)
            }
        }
        else{
            if secondRow == 0 && minutRow == 0 {
                timePickView.selectRow(6, inComponent: 1, animated: true)
            }
        }
        updataOrderSecondTime(minutRow, second: secondRow)
        
    }
    
    func rangeSliderValueChanged(rangeslider: RangeSlider){
        var pos  : CGFloat =   CGFloat(rangeslider.positionForValue(rangeslider.lowerValue))
        pos += CGRectGetMinX(randomView.frame)
        lowerLabel.center = CGPointMake(pos, lowerLabel.center.y)
        
        pos =   CGFloat(rangeslider.positionForValue(rangeslider.upperValue))
        pos += CGRectGetMinX(randomView.frame)
        upperLabel.center = CGPointMake(pos, upperLabel.center.y)
        
        lowerLabel.text = "\(Int(rangeslider.lowerValue))秒"
        upperLabel.text = "\(Int(rangeslider.upperValue))秒"
        
        orderSecondTime = NSTimeInterval( arc4random_uniform( UInt32(rangeslider.upperValue - rangeslider.lowerValue)) +  UInt32(rangeslider.lowerValue))
        updataOrderSecondTimeRandow(Int(rangeslider.lowerValue), max: Int(rangeslider.upperValue))
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

