//
//  BombViewController.swift
//  SwiftProject
//
//  Created by GaoAng on 15/1/23.
//  Copyright (c) 2015年 SH. All rights reserved.
//

import UIKit
import AVFoundation


class BombViewController: BaseViewController {
    
    //音频播放
    
    var audioSession : AVAudioSession = AVAudioSession.sharedInstance()
    
    var timer : NSTimer?
    var orderSecond : NSTimeInterval? = 60
    var curSecond : NSTimeInterval = 0
    var bombImage:UIImageView?
    
    var isCounting: Bool = false {
        willSet(newValue) {
            if newValue {
                timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector:
                    "updateTimer:", userInfo: nil, repeats: true)
            } else {
                timer?.invalidate()
                timer = nil
            }
        }
    }
    
    var isNeedCount: Bool = false{
        willSet(fsdfsf){
            
        }
    }
    
    func updateTimer(timer: NSTimer) {
        self.curSecond += 1
        if curSecond >= orderSecond {
            self.isCounting = false
            playBombMusic()
        }
        else{
            playBombBgMusic()
        }
    }
    
    
    override func leftButtonAction() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.audioSession .setCategory(AVAudioSessionCategoryPlayback, error: nil)
        
        setTitleViewTitle("游戏开始")
        adjustTitleViewStatue(false, titleLabelHiddeer: false, rightBtnHidde: true)
        setupImageView()
        initSuspendButton()
        initEndButton()
        
        playBombBgMusic()
        
        self.isCounting = true
    }

    
    
    func setupImageView(){
        bombImage = UIImageView()
        bombImage?.backgroundColor = UIColor.redColor()
        bombImage!.image = UIImage(named: "ic_about_logo")
        bombImage?.frame = CGRectMake(ScreenWIdht/2 - 150, 120, 200, 200)
        bombImage?.center = CGPointMake(ScreenWIdht/2, ScreenHight/2 - 60)
//        imageView?.center = CGPointMake(ScreenWIdht/2 - 100, 300)
        self.view.addSubview(bombImage!)
    }
    
    //MARK: - 按钮控制。。
    func initSuspendButton(){
        var suspendBtn : UIButton = UIButton()
        suspendBtn.layer.cornerRadius = 4.0
        suspendBtn.frame = CGRectMake(ScreenWIdht/2 - 200, ScreenHight - 100, 150, 50)
        suspendBtn.center = CGPointMake(ScreenWIdht/4 , suspendBtn.center.y)
        suspendBtn.setTitle("暂停", forState: UIControlState.Normal)
        suspendBtn.backgroundColor = UIColor.redColor()
        suspendBtn.addTarget(self, action: "SuspendButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(suspendBtn)
    }
    
    func SuspendButtonAction(sender :UIButton){
        self.isCounting = !self.isCounting
    }
    
    func initEndButton(){
        var endButton : UIButton = UIButton()
        endButton.layer.cornerRadius = 4.0
        endButton.frame = CGRectMake(ScreenWIdht/2 , ScreenHight - 100, 150, 50)
        endButton.center = CGPointMake(ScreenWIdht/4 * 3, endButton.center.y)
        endButton.setTitle("结束游戏", forState: UIControlState.Normal)
        endButton.backgroundColor = UIColor.redColor()
        endButton.addTarget(self, action: "EndButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(endButton)
    }
    
    func EndButtonAction(sender :UIButton){
        self.isCounting = false
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    //MARK: - 播放音频。。
    func playBombBgMusic(){
        if TARGET_IPHONE_SIMULATOR != 1 {
            var soundID: SystemSoundID = 0
            if let ref: CFURLRef = CFBundleCopyResourceURL(CFBundleGetMainBundle(), ("bomb"), ("aif"), nil) {
                AudioServicesCreateSystemSoundID(ref, &soundID)
                AudioServicesPlaySystemSound(soundID)
                //            func AudioServicesAddSystemSoundCompletion(inSystemSoundID: SystemSoundID, inRunLoop: CFRunLoop!, inRunLoopMode: CFString!, inCompletionRoutine: AudioServicesSystemSoundCompletionProc, inClientData: UnsafeMutablePointer<Void>) -> OSStatus
                
                AudioServicesAddSystemSoundCompletion(soundID, CFRunLoopGetMain(), nil, nil, nil)
            }
            else {
                
            }
        }
    }
    
    func playBombMusic(){
        if TARGET_IPHONE_SIMULATOR != 1 {
            var soundID: SystemSoundID = 0
            if let ref: CFURLRef = CFBundleCopyResourceURL(CFBundleGetMainBundle(), ("bomb_end"), ("mp3"), nil) {
                AudioServicesCreateSystemSoundID(ref, &soundID)
                AudioServicesPlaySystemSound(soundID)
                AudioServicesAddSystemSoundCompletion(soundID, CFRunLoopGetMain(), nil, nil, nil)
            }
            else {
                
            }
        }
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