//
//  RangeSliderTrackLayer.swift
//  BombGame
//
//  Created by GaoAng on 15/2/13.
//  Copyright (c) 2015年 SH. All rights reserved.
//

import UIKit
import  QuartzCore

class RangeSliderTrackLayer: CATextLayer {
    weak var rangSlider: RangeSlider?
    
    
    override func drawInContext(ctx: CGContext!) {
        if let slider = rangSlider {
            //clip
            let cornerRadius = bounds.height / 2.0
            let path = UIBezierPath(roundedRect: bounds, cornerRadius: slider.curvaceousness)
            CGContextAddPath(ctx, path.CGPath)
            
            //fill tht track
            CGContextSetFillColorWithColor(ctx, slider.trackTintColor.CGColor)
            CGContextAddPath(ctx, path.CGPath)
            CGContextFillPath(ctx)
            
            //fill the highlighted range
            CGContextSetFillColorWithColor(ctx, slider.trackHighlightTintColor.CGColor)
            CGContextSetFillColorWithColor(ctx, backColor.CGColor)
            let lowerValuePostion = CGFloat(slider.positionForValue(slider.lowerValue))
            let upperValuePostion = CGFloat(slider.positionForValue(slider.upperValue))
            let  rect = CGRect(x: lowerValuePostion, y: 0.0, width: upperValuePostion - lowerValuePostion, height: bounds.height)
            CGContextFillRect(ctx, rect)
        }
    }
}
