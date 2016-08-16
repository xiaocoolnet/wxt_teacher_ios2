//
//  ChangeInformationPageVC.swift
//  WXT_Parents
//
//  Created by 沈晓龙 on 16/7/11.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
//  闭包传值
typealias giveData = (String) -> Void
class ChangeInformationPageVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var section:Int!
    var headerImage:String!
    var headerImageView = UIImageView()
    var name:String!
    var sex:String!
    var phoneNumber:String!
    var passWord:String!
    
    var tableView = UITableView()
    var cell = UITableViewCell()
    //  名字
    let changeNameFiled = UITextField()
    let changePhoneField = UITextField()
    //  性别
    let boyLabel = UILabel()
    let girlLabel = UILabel()
    //  密码
    let oldPassWordField = UITextField()
    let newPassWordField = UITextField()
    let againPassWordField = UITextField()

    var changeName:giveData!
    var changeSex:giveData!
    var changeNumber:giveData!
    var changeImage:giveData!
    var changePassWord:giveData!
    
    var indexPath:NSIndexPath!
    
    
    //  时间倒计时
    var timeNamal:NSTimer!
    var timeNow:NSTimer!
    var count:Int = 60
    
    var codeButton = UIButton()
    var codeLabel = UILabel()
    let codeField = UITextField()


    
    override func viewDidLoad() {
        super.viewDidLoad()

        //  initUI
        initUI()
        //  createTableView
        createTableView()

    }
//    MARK: - initUI
    
    func initUI(){
        
        self.view.backgroundColor = RGBA(239, g: 239, b: 244, a: 1)

        if self.section == 0 {
            self.title = "个人头像"
        }else if self.section == 1{
            self.title = "姓名"
        }else if self.section == 2{
            self.title = "性别"
        }else if self.section == 3{
            self.title = "手机号码"
        }else if self.section == 4{
            self.title = "密码"
        }

    
    }
//    MARK: - changeName  AND  changePassWord
    func ChangeValue(){
        //  进行传值操作
        if section == 1 {
            ChangeName()
        }
        if section == 4{
            ChangePassWord()
        }
        if section == 3{
            ChangePhone()
        }
    }
    
    func ChangeName(){
        
//        http://wxt.xiaocool.net/index.php?g=apps&m=index&a=UpdateUserName&userid=599&nicename=我的昵称
        
        if self.changeName != nil {
            //  沙盒传值
            self.changeName(changeNameFiled.text!)
            let url = "http://wxt.xiaocool.net/index.php?g=apps&m=index&a=UpdateUserName"
            let nicename = changeNameFiled.text!
            let userDefaults = NSUserDefaults.standardUserDefaults()
            let userid = userDefaults.valueForKey("userid")
            let pmara = ["userid":userid,"nicename":nicename]
            GetName(url, pmara: (pmara as? [String:AnyObject])!)
        }
        self.navigationController?.popViewControllerAnimated(true)
    }
    func ChangePhone(){
        if self.changeNumber != nil {
            //  http://wxt.xiaocool.net/index.php?g=apps&m=index&a=UpdateUserPhone&userid=597&phone=18363866803&code=532133
            //  沙盒传值
            self.changeNumber(changePhoneField.text!)
            let url = "http://wxt.xiaocool.net/index.php?g=apps&m=index&a=UpdateUserPhone"
            let userDefaults = NSUserDefaults.standardUserDefaults()
            let userid = userDefaults.valueForKey("userid")
            let code = codeField.text
            let phone = changePhoneField.text
            let pmara = ["userid":userid,"code":code,"phone":phone]
            GetName(url, pmara: (pmara as? [String:AnyObject])!)
        }
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    //  上传姓名
    func GetName(url:String,pmara:NSDictionary){

        
        Alamofire.request(.GET, url, parameters: pmara as? [String:AnyObject]).response { request, response, json, error in

            
        }
        
        
    
    }
    //  修改密码
    func ChangePassWord(){
        if oldPassWordField.text!.isEmpty {
            packUpfield()
            messageHUD(self.view, messageData: "请输原始密码")
            return
        }
        if oldPassWordField.text == passWord {
            if newPassWordField.text!.isEmpty {
                packUpfield()
                messageHUD(self.view, messageData: "请输入新密码")
                return
                //  请输入新密码
            }
            if againPassWordField.text!.isEmpty{
                packUpfield()
                messageHUD(self.view, messageData: "请重新输入密码")
                return
                //  请重新输入原始密码
            }
            if newPassWordField.text != againPassWordField.text{
                packUpfield()
                messageHUD(self.view, messageData: "两次密码输入不一致")
                return
                //  两次密码输入不一致
            }
            packUpfield()
            if self.changePassWord != nil {
                //  进行传值 保存新密码的操作
                
                
                
            }
            messageHUD(self.view, messageData: "修改密码成功")
            //    进行修改密码
            
            
            self.navigationController?.popViewControllerAnimated(true)
            
        }else{
            // 密码错误
            packUpfield()
            messageHUD(self.view, messageData: "原始密码错误")
            return
        }

    }
//    MARK: - packUpTextField

    func packUpfield(){
        self.view.endEditing(true)
    }
    func createTableView(){
        if self.section == 0 {
            getVC()
            return
        }else if self.section == 4{
            tableView.frame = CGRectMake(0, 10, WIDTH, 180)
        }else if self.section == 2{
            tableView.frame = CGRectMake(0, 10, WIDTH, 120)
        }else if self.section == 3{
            tableView.frame = CGRectMake(0, 10, WIDTH, 120)
            
            
        }
        else{
            tableView.frame = CGRectMake(0, 10, WIDTH, 60)
        }
        self.tableView.scrollEnabled = false
        self.view.addSubview(tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func getVC(){
       self.view.backgroundColor = UIColor.blackColor()
        //  得到图片
        self.headerImageView.frame = CGRectMake(0, 20, WIDTH, WIDTH)
        self.view.addSubview(self.headerImageView)
        headerImageView.image = UIImage.init(named: headerImage)
        
        //  添加右按钮
        
        //  点击事件
        
        
    }
    
    func clickAction(){
        //  弹出一个提示框
        //
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    MARK: - tableViewDelegate  AND  tableViewDataSource

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if self.section == 0 {
            return 100
        }else{
            return 60
        }
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.section == 4 {
            return 3
        }else if self.section == 2{
            return 2
        }else if self.section == 3{
            return 2
        }else {
            return 1
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.selectionStyle = .None
        self.indexPath = indexPath
        fillCell()
        return cell
    }
    func fillCell(){
        if section == 0 {
            //  修改头像
            let markLabel = UILabel()
            markLabel.frame = CGRectMake(10, 35, 100, 30)
            markLabel.text = "请选择头像:"
            cell.addSubview(markLabel)
        }else if section == 1 {
            
            let sureButton = UIButton()
            sureButton.frame = CGRectMake(0,  0,  40, 20)
            sureButton.setTitle("保存", forState: .Normal)
            sureButton.addTarget(self, action: #selector(ChangeValue), forControlEvents: .TouchUpInside)
            let rightButton = UIBarButtonItem(customView: sureButton)
            self.navigationItem.rightBarButtonItem = rightButton
            
            changeNameFiled.frame = CGRectMake(10, 5, WIDTH - 50, 50)
            changeNameFiled.text = self.name
            cell.addSubview(changeNameFiled)

        }else if section == 2 {
            //  修改性别
            if self.indexPath.row == 0{
                boyLabel.frame = CGRectMake(10, 15, 100, 30)
                boyLabel.text = "男"
                
                cell.addSubview(boyLabel)
            }else{
                girlLabel.frame = CGRectMake(10, 15, 100, 30)
                girlLabel.text = "女"
                cell.addSubview(girlLabel)
            }
            if self.sex == "男" {
                if self.indexPath.row == 0{
                    let imageView = UIImageView()
                    imageView.frame = CGRectMake(WIDTH - 40, 20, 20, 20)
                    imageView.image = UIImage.init(named: "女")
                    cell.addSubview(imageView)
                }
            }else{
                if self.indexPath.row == 1{
                    let imageView = UIImageView()
                    imageView.frame = CGRectMake(WIDTH - 40, 20, 20, 20)
                    imageView.image = UIImage.init(named: "女")
                    cell.addSubview(imageView)
                }
            }


        }else if section == 3 {
            //  修改手机号码
            if self.indexPath.row == 0 {
                
                
                let sureButton = UIButton()
                sureButton.frame = CGRectMake(0,  0,  40, 20)
                sureButton.setTitle("保存", forState: .Normal)
                sureButton.addTarget(self, action: #selector(ChangeValue), forControlEvents: .TouchUpInside)
                let rightButton = UIBarButtonItem(customView: sureButton)
                self.navigationItem.rightBarButtonItem = rightButton
                
                let phoneLable = UILabel()
                phoneLable.frame = CGRectMake(10, 10, 80, 50)
                phoneLable.textColor = RGBA(155, g: 229, b: 180, a: 1)
                phoneLable.text = "中国＋86"
                cell.addSubview(phoneLable)
                changePhoneField.frame = CGRectMake(100, 5, WIDTH - 100, 50)
                changePhoneField.placeholder = "请输入手机号码"
                cell.addSubview(changePhoneField)
            }else{
                
                let phoneLable = UILabel()
                phoneLable.frame = CGRectMake(10, 10, 80, 50)
                phoneLable.textColor = RGBA(155, g: 229, b: 180, a: 1)
                phoneLable.text = "验证码"
                cell.addSubview(phoneLable)
                
                codeField.frame = CGRectMake(100, 5, 120, 50)
                codeField.placeholder = "请输入验证码"
                cell.addSubview(codeField)
                
//                let label = UILabel()
//                label.frame =  CGRectMake(WIDTH - 110, 15, 100, 30)
//                label.text = "获取验证码"
//                cell.addSubview(label)
//
                
                codeButton.frame = CGRectMake(WIDTH - 110, 15, 100, 30)
                codeButton.setTitleColor(RGBA(155, g: 229, b: 180, a: 1), forState: .Normal)
                //                //  获取验证码
                codeButton.setTitle("获取验证码", forState: .Normal)
                codeButton.addTarget(self, action: #selector(GetCode), forControlEvents: .TouchUpInside)
                cell.addSubview(codeButton)

                
                //  隐藏label
                codeLabel.hidden = true
                codeLabel.frame = CGRectMake(WIDTH - 110, 15, 100, 30)
//                codeLabel.text = "获取验证码"
                codeLabel.textColor = RGBA(155, g: 229, b: 180, a: 1)
                cell.addSubview(codeLabel)
            }
            
        }else if section == 4 {
            //  修改密码
            //  保存按钮
            print(indexPath.row)
            let sureButton = UIButton()
            sureButton.frame = CGRectMake(0,  0,  40, 20)
            sureButton.setTitle("保存", forState: .Normal)
            sureButton.addTarget(self, action: #selector(ChangeValue), forControlEvents: .TouchUpInside)
            let rightButton = UIBarButtonItem(customView: sureButton)
            self.navigationItem.rightBarButtonItem = rightButton

            //  创建三个 label 
            if indexPath.row == 0{
                let oldPassWordLabel = UILabel()
                oldPassWordLabel.frame = CGRectMake(10, 15, 80, 30)
                oldPassWordLabel.text = "原始密码"
                cell.addSubview(oldPassWordLabel)
                
                oldPassWordField.frame = CGRectMake(90, 5, WIDTH - 120, 50)
                oldPassWordField.secureTextEntry = true
                cell.addSubview(oldPassWordField)
            }
            
            if indexPath.row == 1{
                let newPassWordLabel = UILabel()
                newPassWordLabel.frame = CGRectMake(10, 15, 80, 30)
                newPassWordLabel.text = "输入密码"
                cell.addSubview(newPassWordLabel)
            
                newPassWordField.frame = CGRectMake(90, 5, WIDTH - 120, 50)
                newPassWordField.secureTextEntry = true
                cell.addSubview(newPassWordField)

            }
            
            if indexPath.row == 2{
                let againPassWordLabel = UILabel()
                againPassWordLabel.frame = CGRectMake(10, 15, 80, 30)
                againPassWordLabel.text = "确认密码"
                cell.addSubview(againPassWordLabel)
                
                againPassWordField.frame = CGRectMake(90, 5, WIDTH - 120, 50)
                againPassWordField.secureTextEntry = true
                cell.addSubview(againPassWordField)

            }
        }
    }
    func GetCode(){
        //  获得验证码
//        http://wxt.xiaocool.net/index.php?g=apps&m=index&a=SendMobileCode&phone=18653503680
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=index&a=SendMobileCode"
        let pmara = ["phone":changePhoneField.text]
        //  隐藏按钮
        codeButton.hidden = true
        //  显示label
        codeLabel.hidden = false
        timeDow()
        GetName(url, pmara: (pmara as? [String:String])!)
        
    }
    
    
    //    考试倒计时
    func timeDow()
    {
        let time1 = NSTimer.scheduledTimerWithTimeInterval(1.0, target:self, selector: #selector(RegisterGetCodeViewController.updateTime), userInfo: nil, repeats: true)
        timeNow = time1
    }
    //    倒计时
    func showRepeatButton()
    {
        codeLabel.hidden=true
        codeButton.hidden = false
        codeButton.enabled = true
    }
    //    更新时间
    func updateTime()
    {
        count -= 1
        if (count <= 0)
        {
            count = 60
            //  倒计时
            self.showRepeatButton()
            timeNow.invalidate()
        }
        codeLabel.text = "\(count)S"
        
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("选择")
        if section == 2{
        if indexPath.row == 0 {
            //  选择男
            if self.changeSex != nil {
                self.changeSex("男")
            }
            let userDefaults = NSUserDefaults.standardUserDefaults()
            let userid = userDefaults.valueForKey("userid")
            let sex = 1
            let url = "http://wxt.xiaocool.net/index.php?g=apps&m=index&a=UpdateUserSex"
            let pmara = ["userid":userid,"sex":sex]
            GetName(url, pmara: (pmara as? [String:AnyObject])!)
            
            self.navigationController?.popViewControllerAnimated(true)
        }else{
            //  选择女
            if self.changeSex != nil {
                self.changeSex("女")
            }
            let userDefaults = NSUserDefaults.standardUserDefaults()
            let userid = userDefaults.valueForKey("userid")
            let sex = 0
            let url = "http://wxt.xiaocool.net/index.php?g=apps&m=index&a=UpdateUserSex"
            let pmara = ["userid":userid,"sex":sex]
            GetName(url, pmara: (pmara as? [String:AnyObject])!)
            self.navigationController?.popViewControllerAnimated(true)
        }
        }

    }


}
