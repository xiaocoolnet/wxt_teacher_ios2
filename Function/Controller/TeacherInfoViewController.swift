//
//  TeacherInfoViewController.swift
//  WXT_Teacher
//
//  Created by 李春波 on 16/3/24.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import Alamofire
class TeacherInfoViewController: UIViewController {
    let webView = UIWebView()
    let shareBT = UIButton()
    
    var a = String()

    var id = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "教师风采"
     
        webView.frame = CGRectMake(0, 0, frame.width, frame.height-104)
        shareBT.frame=CGRectMake(0, frame.height-104, frame.width, 40)
        shareBT.setTitle("分享", forState: .Normal)
        shareBT.backgroundColor=UIColor(red: 155.0 / 255.0, green: 229.0 / 255.0, blue: 180.0 / 255.0, alpha: 1.0)
         self.view.addSubview(shareBT)
        shareBT.addTarget(self, action: #selector(share), forControlEvents: .TouchUpInside)
        let url = h5Url+a
        let param = [
            "id":id
            
            ]
        
        Alamofire.request(.GET, url, parameters: param).response { request, response, json, error in
            if(error != nil){
            }
            
        self.webView.loadRequest(request!)
        }
        self.view.addSubview(webView)
       
        
    }
    func share(){
        print("分享")
        //  进行分享的操作
        print("分享")
        //
        // 1.创建分享参数
        let shareParames = NSMutableDictionary()
        //
        let url = "http://wxt.xiaocool.net/index.php?g=portal&m=article&a=teacher&id=" + id
        shareParames.SSDKSetupShareParamsByText(url,
                                                images : UIImage(named: "1.png"),
                                                url : NSURL(string:url),
                                                title : "教师风采",
                                                type : SSDKContentType.Auto)
        
        //  判断微信是否安装了
        if WXApi.isWXAppInstalled() {
            
            //微信朋友圈分享
            ShareSDK.share(SSDKPlatformType.SubTypeWechatSession, parameters: shareParames) { (state : SSDKResponseState, userData : [NSObject : AnyObject]!, contentEntity :SSDKContentEntity!, error : NSError!) -> Void in
                
                switch state{
                    
                case SSDKResponseState.Success:
                    print("分享成功")
                    
                    let alert = UIAlertView(title: "分享成功", message: "分享成功", delegate: self, cancelButtonTitle: "确定")
                    alert.show()
                    
                case SSDKResponseState.Fail:    print("分享失败,错误描述:\(error)")
                case SSDKResponseState.Cancel:  print("分享取消")
                    
                default:
                    break
                }
            }
        }else{
            let alertView = UIAlertView.init(title:"提示" , message: "没有安装微信", delegate: self, cancelButtonTitle: "确定")
            alertView.show()
        }

    }
    
      override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
