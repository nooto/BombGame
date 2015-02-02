//
//  LocationManager.swift
//  BombGame
//
//  Created by GaoAng on 15/1/29.
//  Copyright (c) 2015年 SH. All rights reserved.
//


//import UIKit
//

import UIKit

let BOMBSTRING : NSString? = "bombUniqiooen"
let locationManagerObj: LocationManager = LocationManager()

class LocationManager: NSObject {
    func shareInstace()->LocationManager{
        return locationManagerObj
    }

    
    func addLocationNotify(timeGap : NSTimeInterval){
        var firedate : NSDate = NSDate()
        firedate =  NSDate().dateByAddingTimeInterval(timeGap)

        
        var arrNotify : [UILocalNotification]
        var count = 0;
        
        for  notifyObj  in  UIApplication.sharedApplication().scheduledLocalNotifications {
            if notifyObj is UILocalNotification{
                if notifyObj.fireDate?.isEqualToDate(firedate) == true{
                    return
                }
            }
        }
        
        var addNotify : UILocalNotification = UILocalNotification()
        addNotify.fireDate =  firedate
        addNotify.soundName = "bomb_end.mp3"
        addNotify.timeZone = NSTimeZone()
        addNotify.alertBody = "炸了。炸了。炸了。炸了。炸了。"
        UIApplication.sharedApplication().scheduleLocalNotification(addNotify)
    }
    
    func cancelLocation(timeGap : NSTimeInterval){
//        var firedate : NSDate = NSDate()
//        firedate =  NSDate().dateByAddingTimeInterval(timeGap)
//        var arrNotify : [UILocalNotification]
//        for  notifyObj  in  UIApplication.sharedApplication().scheduledLocalNotifications {
//            if notifyObj is UILocalNotification{
//                if notifyObj.fireDate?.isEqualToDate(firedate) == true{
//                    //                    var destLoc:UILocalNotification = UILocalNotification(coder: notifyObj)
//                    UIApplication.sharedApplication().cancelLocalNotification(notifyObj as UILocalNotification)
//                    return
//                }
//            }
//        }
        
    }
}
