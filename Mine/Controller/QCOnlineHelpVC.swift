//
//  QCOnlineHelpVC.swift
//  WXT_Parents
//
//  Created by 沈晓龙 on 16/7/14.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

class QCOnlineHelpVC: UIViewController {

    let contentTextView = BRPlaceholderTextView()
    let btn = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGrayColor()
        initUI()
        //  进行环信的集成（聊天）
//        self.view.backgroundColor = RGBA(242.0, g: 242.0, b: 242.0, a: 1)
        createTextView()
    }
    func initUI(){
        self.title = "在线留言"
        self.tabBarController?.tabBar.hidden = true
    }
    
    func createTextView(){
        self.contentTextView.frame = CGRectMake(8, 5, self.view.bounds.width - 16, 250)
        self.contentTextView.font = UIFont.systemFontOfSize(15)
        self.contentTextView.placeholder = "请添加留言"
        self.view.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(contentTextView)
        
        btn.frame = CGRectMake(20, 310, WIDTH - 40, 40)
        btn.setTitle("提交", forState: .Normal)
        btn.backgroundColor = UIColor(red: 155/255, green: 229/255, blue: 180/255, alpha: 1)
        btn.layer.cornerRadius = 10
        btn.addTarget(self, action: #selector(self.click), forControlEvents: .TouchUpInside)
        self.view.addSubview(btn)
        
    }
    
    func click(){
        let chid = NSUserDefaults.standardUserDefaults()
        let userid = chid.stringForKey("userid")
        
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=index&a=LeaveMessage"
        let param = [
            "userid":userid!,
            "message":self.contentTextView.text!,
            ]
        Alamofire.request(.POST, url, parameters: param).response { request, response, json, error in
            if(error != nil){
            }
            else{
                print("request是")
                print(request!)
                print("====================")
                let result = Httpresult(JSONDecoder(json!))
                print("状态是")
                print(result.status)
                if(result.status == "error"){
                    let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                    hud.mode = MBProgressHUDMode.Text
                    hud.labelText = "提交失败"
                    hud.margin = 10.0
                    hud.removeFromSuperViewOnHide = true
                    hud.hide(true, afterDelay: 1)
                }
                if(result.status == "success"){
                    let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                    hud.mode = MBProgressHUDMode.Text
                    hud.labelText = "提交成功"
                    hud.margin = 10.0
                    hud.removeFromSuperViewOnHide = true
                    hud.hide(true, afterDelay: 1)
                    
//                    self.navigationController?.popViewControllerAnimated(true)
                }
                
            }
            
        }

    }
    
//    //点击return收回键盘
//    func textFieldShouldReturn(textField: UITextField) -> Bool
//    {
//        //  键盘收起的方法
//        contentTextView.resignFirstResponder()
//        
//        return true
//    }
//    
    //点击空白处回收键盘
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }



}
