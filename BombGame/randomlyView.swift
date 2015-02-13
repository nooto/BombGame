//
//  randomlyView.swift
//  BombGame
//
//  Created by GaoAng on 15/2/11.
//  Copyright (c) 2015年 SH. All rights reserved.
//

import UIKit
import QuartzCore

class RangeSlider: UIControl {
    var mininumValue : Double = 60.0{
        didSet{
            updateLayerFrames()
        }
    }
    
    var maxnumValue : Double =  300.0{
        didSet{
            updateLayerFrames()
        }
    }
    
    var lowerValue : Double =  60.0{
        didSet{
            updateLayerFrames()
        }
    }
    
    var upperValue : Double =  300.0{
        didSet{
            updateLayerFrames()
        }
    }
    
    var previousLocation = CGPoint()
    
    let trackLayer = RangeSliderTrackLayer()
    var lowerThumbLayer = RangeSliderThumbLayer()
    var upperThumbLayer = RangeSliderThumbLayer()
    
    var trackTintColor : UIColor = UIColor(white:0.9, alpha:1.0){
        didSet{
            trackLayer.setNeedsDisplay()
        }
    }
    
    var trackHighlightTintColor : UIColor = UIColor(red: 0.0, green: 0.45, blue: 0.94, alpha: 1.0) {
        didSet{
            trackLayer.setNeedsDisplay()
        }
    }
    
    var thumbTintColor : UIColor = UIColor.whiteColor(){
        didSet{
            lowerThumbLayer.setNeedsDisplay()
            upperThumbLayer.setNeedsDisplay()
        }
    }
    
    var curvaceousness : CGFloat = 10.0{
        didSet{
            trackLayer.setNeedsDisplay()
            lowerThumbLayer.setNeedsDisplay()
            upperThumbLayer.setNeedsDisplay()
        }
    }
    
    var thumbWidth: CGFloat{
        return CGFloat(bounds.height)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        trackLayer.contentsScale = UIScreen.mainScreen().scale
        trackLayer.rangSlider = self
        layer.addSublayer(trackLayer)
        
        lowerThumbLayer.rangeSlider = self;
        lowerThumbLayer.contentsScale = UIScreen.mainScreen().scale
        layer.addSublayer(lowerThumbLayer)
        
        upperThumbLayer.rangeSlider = self;
        upperThumbLayer.contentsScale = UIScreen.mainScreen().scale
        layer.addSublayer(upperThumbLayer)
        
        updateLayerFrames()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func updateLayerFrames() {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        trackLayer.frame = bounds.rectByInsetting(dx: 0.0, dy: bounds.height / 3)
        trackLayer.setNeedsDisplay()
        
        let lowerThumbCenter = CGFloat(positionForValue(lowerValue))
        lowerThumbLayer.frame = CGRect(x: lowerThumbCenter - thumbWidth / 2.0, y: 0.0, width: thumbWidth, height: thumbWidth)
        lowerThumbLayer.setNeedsDisplay()
        
        
        let upperThumbCenter = CGFloat(positionForValue(upperValue))
        upperThumbLayer.frame = CGRect(x: upperThumbCenter - thumbWidth / 2.0, y: 0.0, width: thumbWidth, height: thumbWidth)
        upperThumbLayer.setNeedsDisplay()
        
        CATransaction.commit()
    }
    
    func positionForValue(value: Double) -> Double {
        
        let widthDouble = Double(thumbWidth)
        return Double(bounds.width - thumbWidth) * (value - mininumValue) / (maxnumValue - mininumValue) + Double(thumbWidth / 2.0)
    }
    
    override var frame : CGRect{
        didSet{
            updateLayerFrames()
        }
    }
    
    func boundValue(value: Double, toLowerValue lowerValue:Double, puuerVlaue: Double) -> Double{
        return min(max(value, lowerValue), puuerVlaue)
    }
    
    override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent) -> Bool {
        
        previousLocation = touch.locationInView(self)
        
        if lowerThumbLayer.frame.contains(previousLocation){
            lowerThumbLayer.highlighted = true
            layer.insertSublayer(lowerThumbLayer, above: upperThumbLayer)
        }
        else if upperThumbLayer.frame.contains(previousLocation) {
            upperThumbLayer.highlighted = true
            layer.insertSublayer(upperThumbLayer, above: lowerThumbLayer)
        }
        
        return lowerThumbLayer.highlighted || upperThumbLayer.highlighted
    }
    
    override func continueTrackingWithTouch(touch: UITouch, withEvent event: UIEvent) -> Bool {
        
        let location = touch.locationInView(self)
        
        let deltalocation = Double(location.x  - previousLocation.x)
        let deltaValue = (maxnumValue - mininumValue) * deltalocation / Double(bounds.width - bounds.height)
        
        previousLocation = location;
        
        
        //updata values
        if lowerThumbLayer.highlighted{
            lowerValue += deltaValue
            lowerValue = boundValue(lowerValue, toLowerValue: mininumValue, puuerVlaue: upperValue)
        }
        else if upperThumbLayer.highlighted{
            upperValue += deltaValue
            upperValue = boundValue(upperValue, toLowerValue: lowerValue, puuerVlaue: maxnumValue)
        }
        
//        //update ui
//        CATransaction.begin()
//        CATransaction.setDisableActions(true)
//        updateLayerFrames()
//        CATransaction.commit()
        
        sendActionsForControlEvents(.ValueChanged)
        return true
    }
    
    override func endTrackingWithTouch(touch: UITouch, withEvent event: UIEvent) {
        upperThumbLayer.highlighted = false
        lowerThumbLayer.highlighted = false
    }

}