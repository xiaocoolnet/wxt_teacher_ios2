//
//  AppDelegate.swift
//  WXT_Teacher
//
//  Created by 李春波 on 16/2/28.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
   
         UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        // Override point for customization after application launch.
        //  微信分享功能 (第一个参数不知道是什么意思)
        ShareSDK.registerApp("14395b7a1ae3c", activePlatforms: [SSDKPlatformType.TypeWechat.rawValue], onImport: {(platform : SSDKPlatformType) -> Void in
            
            switch platform{
                //  第三个参数为需要连接社交平台SDK时触发，在此事件中写入连接代码
                
            case SSDKPlatformType.TypeWechat:
                ShareSDKConnector.connectWeChat(WXApi.classForCoder())
                
            default:
                break
            }
            }, onConfiguration: {(platform : SSDKPlatformType,appInfo : NSMutableDictionary!) -> Void in
                switch platform {
    
                case SSDKPlatformType.TypeWechat:
                    //设置微信应用信息
                    appInfo.SSDKSetupWeChatByAppId("wxc8f7561ad972b1ae", appSecret: "a3b3411604fdeeeb773402f44f665cfc")
                    break
     
                default:
                    break
                    
                }
        })
        

        NSThread.sleepForTimeInterval(2.0)
        //            检测登录
//        if self.loginCheck() {
//            //        环信登录
//            let easeMob:EaseMob = EaseMob()
//            easeMob.registerSDKWithAppKey("xiaocool#zhixiaoyuan", apnsCertName: "wxtpush_dev")
//            easeMob.application(application, didFinishLaunchingWithOptions: launchOptions)
//            //        账号
//            let userid = NSUserDefaults.standardUserDefaults()
//            //        接口调用注册
//            easeMob.chatManager.asyncRegisterNewAccount(userid.valueForKey("userid")! as! String, password:userid.valueForKey("userid")! as! String)
//            //        //        设置自动登录
//            easeMob.chatManager.asyncLoginWithUsername(userid.valueForKey("userid")! as! String, password: userid.valueForKey("userid")! as! String)
//            //        检测是否设置了自动登录
//            let isAutoLogin:Bool = easeMob.chatManager.isAutoLoginEnabled!
//            if(!isAutoLogin){
//                easeMob.chatManager.asyncLoginWithUsername(userid.valueForKey("userid")! as! String,password:userid.valueForKey("userid")! as! String)
//            }
//            //                        182.92.20.117
//            easeMob.registerSDKWithAppKey("xiaocool#zhixiaoyuan", apnsCertName: "wxtpush_dev")
//            //iOS8 注册APNS
//            if(application.respondsToSelector(#selector(UIApplication.registerForRemoteNotifications))){
//                application.registerForRemoteNotifications()
//                let notificationTypes:UIUserNotificationType = UIUserNotificationType(arrayLiteral: .Alert,.Badge,.Sound)
//                let settings:UIUserNotificationSettings = UIUserNotificationSettings.init(forTypes: notificationTypes, categories: nil)
//                application.registerUserNotificationSettings(settings)
//            }else{
//                let notificationTypes:UIRemoteNotificationType = UIRemoteNotificationType(arrayLiteral: .Alert,.Badge,.Sound)
//                application.registerForRemoteNotificationTypes(notificationTypes)
//            }
//        }

        self.loginCheck()
        UITabBar.appearance().tintColor = UIColor(red: 54.0 / 255.0, green: 190.0 / 255.0, blue: 100.0 / 255.0, alpha: 1.0)
        UINavigationBar.appearance().barTintColor = UIColor(red: 155.0 / 255.0, green: 229.0 / 255.0, blue: 180.0 / 255.0, alpha: 1.0)
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().translucent = false
        if let barFont = UIFont(name: "ChalkboardSE-Bold", size: 18){
            UINavigationBar.appearance().titleTextAttributes = [
                NSForegroundColorAttributeName:UIColor.whiteColor(),
                NSFontAttributeName : barFont
            ]
        }
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(0, -60), forBarMetrics: UIBarMetrics.Default)
        //IQKeyboardManager.sharedManager().enable = true
        return true
    }
    func loginCheck()->Bool{
        let userid = NSUserDefaults.standardUserDefaults()
        var segueId = "MainView"
        if((userid.valueForKey("userid") == nil) || (userid.valueForKey("userid")?.length == 0 )){
            segueId = "LoginView"
            self.window?.rootViewController = self.window?.rootViewController?.storyboard?.instantiateViewControllerWithIdentifier(segueId)
            return false
        }
        else{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let tableBarController = storyboard.instantiateViewControllerWithIdentifier(segueId) as! UITabBarController
            let tableBarItem = tableBarController.tabBar.items![2]
            tableBarItem.badgeValue = nil
            self.window?.rootViewController = tableBarController
            return true
        }
    }

    func applicationWillResignActive(application: UIApplication) {
        
    }

    func applicationDidEnterBackground(application: UIApplication) {

    }

    func applicationWillEnterForeground(application: UIApplication) {

    }

    func applicationDidBecomeActive(application: UIApplication) {
 
    }

    func applicationWillTerminate(application: UIApplication) {

    }


}

