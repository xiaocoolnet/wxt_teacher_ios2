//
//  SetPassViewController.swift
//  WXT_Teacher
//
//  Created by 李春波 on 16/3/19.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import MBProgressHUD

class SetPassViewController: UIViewController {

    let passView = UIView()
    let passText = UITextField()
    let againPassView = UIView()
    let againText = UITextField()
    let finishBtn = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "修改密码"
        self.view.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        self.passView.frame = CGRectMake(0, 10, self.view.bounds.width, 44)
        self.passView.backgroundColor = UIColor.whiteColor()
        self.passText.frame = CGRectMake(10, 20, self.view.bounds.width - 10, 30)
        self.passText.borderStyle = .None
        self.passText.secureTextEntry = true
        self.passText.placeholder = "请输入新密码"
        self.againPassView.frame = CGRectMake(0, 56, self.view.bounds.width, 44)
        self.againPassView.backgroundColor = UIColor.whiteColor()
        self.againText.frame = CGRectMake(10, 66, self.view.bounds.width - 10, 30)
        self.againText.borderStyle = .None
        self.againText.secureTextEntry = true
        self.againText.placeholder = "请再次输入新密码"
        self.finishBtn.frame = CGRectMake(10, 116, self.view.bounds.width - 20, 40)
        self.finishBtn.layer.cornerRadius = 5
        self.finishBtn.layer.masksToBounds = true
        self.finishBtn.backgroundColor = UIColor(red: 54.0 / 255.0, green: 190.0 / 255.0, blue: 100.0 / 255.0, alpha: 1.0)
        self.finishBtn.setTitle("完成设置", forState: .Normal)
        self.finishBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.finishBtn.titleLabel?.font = UIFont.systemFontOfSize(17)
        self.finishBtn.addTarget(self, action: #selector(SetPassViewController.FinishView), forControlEvents: .TouchUpInside)
        self.view.addSubview(self.passView)
        self.view.addSubview(self.passText)
        self.view.addSubview(self.againPassView)
        self.view.addSubview(self.againText)
        self.view.addSubview(self.finishBtn)
        // Do any additional setup after loading the view.
    }
    
    func FinishView(){
        if PandKong(){
            self.navigationController?.popToRootViewControllerAnimated(true)
        }
    }
    
    func PandKong()->Bool{
        if(self.passText.text!.isEmpty){
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.mode = MBProgressHUDMode.Text
            hud.labelText = "请输入密码"
            hud.margin = 10.0
            hud.removeFromSuperViewOnHide = true
            hud.hide(true, afterDelay: 1)
            return false
        }
        if(self.againText.text!.isEmpty){
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.mode = MBProgressHUDMode.Text
            hud.labelText = "请输入密码"
            hud.margin = 10.0
            hud.removeFromSuperViewOnHide = true
            hud.hide(true, afterDelay: 1)
            return false
        }
        if(self.passText.text! != self.againText.text!){
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.mode = MBProgressHUDMode.Text
            hud.labelText = "两次密码不一致"
            hud.margin = 10.0
            hud.removeFromSuperViewOnHide = true
            hud.hide(true, afterDelay: 1)
            return false
        }

        return true
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }


}
