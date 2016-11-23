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
    let arr = NSMutableArray()
    let trustArr = NSMutableArray()
    let noticeArr = NSMutableArray()
    let deliArr = NSMutableArray()
    let homeworkArr = NSMutableArray()
    let leaveArr = NSMutableArray()
    let activityArr = NSMutableArray()
    let commentArr = NSMutableArray()
    let scheduleArr = NSMutableArray()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
   Bugtags.startWithAppKey("310f38447ac2ad3501e27e614523508d", invocationEvent: BTGInvocationEventBubble)
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
        
        
        
        //MARK: - 极光推送
        //通知类型（这里将声音、消息、提醒角标都给加上）
        let userSettings = UIUserNotificationSettings(forTypes: [.Badge, .Sound, .Alert],
                                                      categories: nil)
        if ((UIDevice.currentDevice().systemVersion as NSString).floatValue >= 8.0) {
            //可以添加自定义categories
            JPUSHService.registerForRemoteNotificationTypes(userSettings.types.rawValue,
                                                            categories: nil)
        }
        else {
            //categories 必须为nil
            JPUSHService.registerForRemoteNotificationTypes(userSettings.types.rawValue,
                                                            categories: nil)
        }
        
        // 启动JPushSDK
        JPUSHService.setupWithOption(nil, appKey: "65ebc0b00c2635f68ec2ec52",
                                     channel: "Publish Channel", apsForProduction: true)
        
        JPUSHService.setDebugMode()
        JPUSHService.init()
        let defau = NSNotificationCenter.defaultCenter()
        defau.addObserver(self, selector: #selector(network(_:)), name: kJPFNetworkDidLoginNotification, object: nil)
        
        return true
    }
    func loginCheck()->Bool{
        let userid = NSUserDefaults.standardUserDefaults()
        var segueId = "MainView"
        if((userid.valueForKey("userid") == nil) || (userid.valueForKey("userid")?.length == 0 )){
            //增加标识，用于判断是否是第一次启动应用...
            if (!(NSUserDefaults.standardUserDefaults().boolForKey("everLaunched"))) {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                NSUserDefaults.standardUserDefaults().setBool(true, forKey:"everLaunched")
                let  guideViewController = storyboard.instantiateViewControllerWithIdentifier("ScrollViewController") as! ScrollViewController
                self.window?.rootViewController=guideViewController
            }else{
            segueId = "LoginView"
            self.window?.rootViewController = self.window?.rootViewController?.storyboard?.instantiateViewControllerWithIdentifier(segueId)
            }
            return false
        }
        else{
            let defalutid = NSUserDefaults.standardUserDefaults()
            let studentid = defalutid.stringForKey("userid")
            JPUSHService.setTags(nil, aliasInbackground: studentid)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let tableBarController = storyboard.instantiateViewControllerWithIdentifier(segueId) as! UITabBarController
            let tableBarItem = tableBarController.tabBar.items![2]
            tableBarItem.badgeValue = nil
            self.window?.rootViewController = tableBarController
            
           
            return true
        }
    }
    func application(application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        //注册 DeviceToken
        JPUSHService.registerDeviceToken(deviceToken)
       
        let pushToken = deviceToken.description.stringByReplacingOccurrencesOfString("<", withString: "").stringByReplacingOccurrencesOfString(">", withString: "").stringByReplacingOccurrencesOfString(" ", withString: "")
        print(pushToken)
       
    }

    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        JPUSHService.handleRemoteNotification(userInfo)
       goToMssageViewControllerWith(userInfo)
    }
    func application(application: UIApplication,
                     didReceiveRemoteNotification userInfo: [NSObject : AnyObject],
                                                  fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        //增加IOS 7的支持
        JPUSHService.handleRemoteNotification(userInfo)
        completionHandler(UIBackgroundFetchResult.NewData)
        print(userInfo)
        
        
        if application.applicationState == .Active {
           NSNotificationCenter.defaultCenter().postNotificationName("tongzhi", object: userInfo)
         
        }else if application.applicationState == .Inactive{
            goToMssageViewControllerWith(userInfo)
            
        }else if application.applicationState == .Background{
            goToMssageViewControllerWith(userInfo)
      
        }
        goToMssageViewController(userInfo)
        
    }
    
    func goToMssageViewController(userInfo:NSDictionary){
        let type = userInfo["type"] as? String
        if type == "message"{
            let userDefaults = NSUserDefaults.standardUserDefaults()
            if userDefaults.valueForKey("count") != nil {
                let str = userDefaults.valueForKey("count") as! NSArray
                if str.count == 0 {
                    arr.removeAllObjects()
                }
            }else{
                arr.removeAllObjects()
                
            }
            arr.addObject(userInfo)
            userDefaults.setValue(arr, forKey: "count")
            let str = userDefaults.valueForKey("count")
            NSNotificationCenter.defaultCenter().postNotificationName("count", object: str)
            
        }else if type == "trust"{
            let userDefaults = NSUserDefaults.standardUserDefaults()
            if userDefaults.valueForKey("trustArr") != nil {
                let str = userDefaults.valueForKey("trustArr") as! NSArray
                if str.count == 0 {
                    trustArr.removeAllObjects()
                }
            }else{
                trustArr.removeAllObjects()
                
            }
            trustArr.addObject(userInfo)
            userDefaults.setValue(trustArr, forKey: "trustArr")
            let str = userDefaults.valueForKey("trustArr")
            NSNotificationCenter.defaultCenter().postNotificationName("trustArr", object: str)
            
        }else if type == "notice"{
            let userDefaults = NSUserDefaults.standardUserDefaults()
            if userDefaults.valueForKey("noticeArr") != nil {
                let str = userDefaults.valueForKey("noticeArr") as! NSArray
                if str.count == 0 {
                    noticeArr.removeAllObjects()
                }
            }else{
                noticeArr.removeAllObjects()
                
            }
            noticeArr.addObject(userInfo)
            userDefaults.setValue(noticeArr, forKey: "noticeArr")
            let str = userDefaults.valueForKey("noticeArr")
            NSNotificationCenter.defaultCenter().postNotificationName("noticeArr", object: str)
            
        }else if type == "delivery"{
            let userDefaults = NSUserDefaults.standardUserDefaults()
            if userDefaults.valueForKey("deliArr") != nil {
                let str = userDefaults.valueForKey("deliArr") as! NSArray
                if str.count == 0 {
                    deliArr.removeAllObjects()
                }
            }else{
                deliArr.removeAllObjects()
                
            }
            deliArr.addObject(userInfo)
            userDefaults.setValue(deliArr, forKey: "deliArr")
            let str = userDefaults.valueForKey("deliArr")
            NSNotificationCenter.defaultCenter().postNotificationName("deliArr", object: str)
            
        }else if type == "homework"{
            let userDefaults = NSUserDefaults.standardUserDefaults()
            if userDefaults.valueForKey("homeworkArr") != nil {
                let str = userDefaults.valueForKey("homeworkArr") as! NSArray
                if str.count == 0 {
                    homeworkArr.removeAllObjects()
                }
            }else{
                homeworkArr.removeAllObjects()
                
            }
            homeworkArr.addObject(userInfo)
            userDefaults.setValue(homeworkArr, forKey: "homeworkArr")
            let str = userDefaults.valueForKey("homeworkArr")
            NSNotificationCenter.defaultCenter().postNotificationName("homeworkArr", object: str)
            
        }else if type == "leave"{
            let userDefaults = NSUserDefaults.standardUserDefaults()
            if userDefaults.valueForKey("leaveArr") != nil {
                let str = userDefaults.valueForKey("leaveArr") as! NSArray
                if str.count == 0 {
                    leaveArr.removeAllObjects()
                }
            }else{
                leaveArr.removeAllObjects()
                
            }
            leaveArr.addObject(userInfo)
            userDefaults.setValue(leaveArr, forKey: "leaveArr")
            let str = userDefaults.valueForKey("leaveArr")
            NSNotificationCenter.defaultCenter().postNotificationName("leaveArr", object: str)
            
        }else if type == "activity"{
            let userDefaults = NSUserDefaults.standardUserDefaults()
            if userDefaults.valueForKey("activityArr") != nil {
                let str = userDefaults.valueForKey("activityArr") as! NSArray
                if str.count == 0 {
                    activityArr.removeAllObjects()
                }
            }else{
                activityArr.removeAllObjects()
                
            }
            activityArr.addObject(userInfo)
            userDefaults.setValue(leaveArr, forKey: "activityArr")
            let str = userDefaults.valueForKey("activityArr")
            NSNotificationCenter.defaultCenter().postNotificationName("activityArr", object: str)
            
        }else if type == "comment"{
            let userDefaults = NSUserDefaults.standardUserDefaults()
            if userDefaults.valueForKey("commentArr") != nil {
                let str = userDefaults.valueForKey("commentArr") as! NSArray
                if str.count == 0 {
                    commentArr.removeAllObjects()
                }
            }else{
                commentArr.removeAllObjects()
                
            }
            commentArr.addObject(userInfo)
            userDefaults.setValue(commentArr, forKey: "commentArr")
            let str = userDefaults.valueForKey("commentArr")
            NSNotificationCenter.defaultCenter().postNotificationName("commentArr", object: str)
            
        }else if type == "schedule"{
            let userDefaults = NSUserDefaults.standardUserDefaults()
            if userDefaults.valueForKey("scheduleArr") != nil {
                let str = userDefaults.valueForKey("scheduleArr") as! NSArray
                if str.count == 0 {
                    scheduleArr.removeAllObjects()
                }
            }else{
                scheduleArr.removeAllObjects()
                
            }
            scheduleArr.addObject(userInfo)
            userDefaults.setValue(scheduleArr, forKey: "scheduleArr")
            let str = userDefaults.valueForKey("scheduleArr")
            NSNotificationCenter.defaultCenter().postNotificationName("scheduleArr", object: str)
            
        }

    }
    
    func goToMssageViewControllerWith(userInfo:NSDictionary){
        let type = userInfo["type"] as? String
       
        NSNotificationCenter.defaultCenter().postNotificationName("push", object: userInfo)
        
    }
    
    func network(not:NSNotification){
        if (JPUSHService.registrationID() != nil) {
            print(JPUSHService.registrationID())
            let userid = NSUserDefaults.standardUserDefaults()
            userid.setValue(JPUSHService.registrationID(), forKey: "deviceToken")
        }
        
    }
    
    
    func application(application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        //可选
        NSLog("did Fail To Register For Remote Notifications With Error: \(error)")
    }
    func applicationWillResignActive(application: UIApplication) {
        
    }

    func applicationDidEnterBackground(application: UIApplication) {

    }

    func applicationWillEnterForeground(application: UIApplication) {

        application.applicationIconBadgeNumber = 0
        application.cancelAllLocalNotifications()
    }

    func applicationDidBecomeActive(application: UIApplication) {
 
    }

    func applicationWillTerminate(application: UIApplication) {

    }
   
}

