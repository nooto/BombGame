//
//  AppDelegate.swift
//  SwiftProject
//
//  Created by GaoAng on 15/1/14.
//  Copyright (c) 2015年 SH. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var rootControl : ViewController = ViewController()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window!.backgroundColor = UIColor.whiteColor()
        self.window!.makeKeyAndVisible()
//        self.window!.rootViewController = ViewController()
        
        var navCtrl=UINavigationController(rootViewController:self.rootControl)
        self.window!.rootViewController=navCtrl

        
        application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: UIUserNotificationType.Sound | UIUserNotificationType.Badge | UIUserNotificationType.Alert, categories: nil))
        // Override point for customization after application launch.
        return true
    }
    
   func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
    var lastVC: (AnyObject?) = (self.rootControl.navigationController?.viewControllers.last)
    if lastVC is BombViewController{
        
    }
    else{
        var bombView : BombViewController = BombViewController()
        bombView.orderSecond = NSTimeInterval(arc4random_uniform(UInt32(240)) + UInt32(60))
        rootControl.navigationController?.pushViewController(bombView, animated: true)
    }
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        
//        for item in library {
//            if let movie = item as? Movie {
//                println("Movie: '\(movie.name)', dir. \(movie.director)")
//            } else if let song = item as? Song {
//                println("Song: '\(song.name)', by \(song.artist)")
//            }
//        }
//        
        var lastVC: (AnyObject?) = (self.rootControl.navigationController?.viewControllers.last)
        if let vc = lastVC as? BombViewController{
            vc.updateViewAnimtatImage()
        }
        
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

