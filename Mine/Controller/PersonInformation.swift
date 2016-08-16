//
//  PersonInformation.swift
//  WXT_Parents
//
//  Created by 沈晓龙 on 16/7/11.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import MBProgressHUD
import Alamofire

class PersonInformation: UIViewController,UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    let headerImageView = UIImageView()
    let personNameLabel = UILabel()
    let personSexLabel = UILabel()
    let personPhoneLabel = UILabel()
    var imageStr = String()
//
    var data = NSData()
    
    var hud = MBProgressHUD()
    
    var changeImage = UIImageView()


    //  tableview
    var tableView = UITableView()
    //  dataSource(不需要)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //  隐藏芬兰控制器
        self.tabBarController?.tabBar.hidden = true
        //  初始化  UI
        initUI()
        //  数据请求
        GetData()

    }
    func initUI(){
        self.tableView.frame = self.view.bounds
        self.view.addSubview(tableView)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func GetData(){
    
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        //  段数据
        return 5
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //  行数据
        return 1
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        //  行高
        if indexPath.section == 0{
            return 100
        }else{
            //  返回行高
        return 50
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //  返回cell
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.selectionStyle = .None

        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        if indexPath.section == 0 {
            
            let imageViewLabel = UILabel()
            imageViewLabel.frame = CGRectMake(10, 35, 100, 30)
            //  添加头像
            imageViewLabel.text = "头像"
            cell.contentView.addSubview(imageViewLabel)
            
            headerImageView.frame = CGRectMake(WIDTH - 120, 10, 80, 80)
            let photo = NSUserDefaults.standardUserDefaults()

            imageStr = (photo.valueForKey("photo") as? String)!
//            imageStr="1.png"
            headerImageView.yy_setImageWithURL(NSURL.init(string: imageUrl + imageStr), placeholder: UIImage(named: "无网络的背景图"))
            cell.contentView.addSubview(headerImageView)

        }else if indexPath.section == 1{
            
            let nameLabel = UILabel()
            nameLabel.frame = CGRectMake(10, 10, 100, 30)
            nameLabel.text = "姓名"
            cell.contentView.addSubview(nameLabel)
            
            personNameLabel.frame = CGRectMake(WIDTH - 190, 10, 150, 30)
            personNameLabel.textAlignment = NSTextAlignment.Right
            
            //  得到沙盒
            let userDefaults = NSUserDefaults.standardUserDefaults()
            personNameLabel.text = userDefaults.valueForKey("name") as? String
            cell.contentView.addSubview(personNameLabel)
            
        }else if indexPath.section == 2{
            
            let sexLabel = UILabel()
            sexLabel.frame = CGRectMake(10, 10, 100, 30)
            sexLabel.text = "性别"
            cell.contentView.addSubview(sexLabel)
            
            personSexLabel.frame = CGRectMake(WIDTH - 190, 10, 150, 30)
            personSexLabel.textAlignment = NSTextAlignment.Right
            let userDefaults = NSUserDefaults.standardUserDefaults()
            personSexLabel.text = userDefaults.valueForKey("sex") as? String

            if personSexLabel.text == nil{
                //  默认为男
                personSexLabel.text = "男"
            }
            cell.contentView.addSubview(personSexLabel)
            
        }else if indexPath.section == 3{
            
            let phoneLabel = UILabel()
            phoneLabel.frame = CGRectMake(10, 10, 100, 30)
            phoneLabel.text = "手机号码"
            cell.contentView.addSubview(phoneLabel)
            
            personPhoneLabel.frame = CGRectMake(WIDTH - 190, 10, 150, 30)
            personPhoneLabel.textAlignment = NSTextAlignment.Right
            let userDefaults = NSUserDefaults.standardUserDefaults()
            personPhoneLabel.text = userDefaults.valueForKey("phone") as? String
            cell.contentView.addSubview(personPhoneLabel)
            
        }else{
            
            let changePassWordLabel = UILabel()
            changePassWordLabel.frame = CGRectMake(10, 10, 100, 30)
            changePassWordLabel.text = "修改密码"
            cell.contentView.addSubview(changePassWordLabel)
            
        }
        

        return cell
        
        
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5.0
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //  单元格的点击事件
        if indexPath.section == 0 {
            print("修改头像")
//            let changePageVC = ChangeInformationPageVC()
//            changePageVC.section = indexPath.section
//            changePageVC.headerImage = imageStr
//            self.navigationController?.pushViewController(changePageVC, animated: true)
            //  直接弹出一个对话框，选取照片的模式
            self.changeHeaderImage()
            
            
        }else if indexPath.section == 1{
            print("修改姓名")
            let changePageVC = ChangeInformationPageVC()
            changePageVC.section = indexPath.section
            changePageVC.name = personNameLabel.text
            //  通过闭包进行接收值
            changePageVC.changeName = {(getName) ->Void in
                self.personNameLabel.text = getName
                let userDefaults = NSUserDefaults.standardUserDefaults()
                userDefaults.setValue(getName, forKey: "name")

            }
            self.navigationController?.pushViewController(changePageVC, animated: true)

        }else if indexPath.section == 2{
            print("修改性别")
            let changePageVC = ChangeInformationPageVC()
            changePageVC.section = indexPath.section
            changePageVC.sex = personSexLabel.text
            changePageVC.changeSex = {(getSex) -> Void in
                self.personSexLabel.text = getSex
                let userDefaults = NSUserDefaults.standardUserDefaults()
                userDefaults.setValue(getSex, forKey: "sex")
            }
            self.navigationController?.pushViewController(changePageVC, animated: true)

        }else if indexPath.section == 3{
            print("修改手机号码")
            let changePageVC = ChangeInformationPageVC()
            changePageVC.section = indexPath.section
            changePageVC.changeNumber = {(phoneNumber) -> Void in
                self.personPhoneLabel.text = phoneNumber
                let userDefaults = NSUserDefaults.standardUserDefaults()
                userDefaults.setValue(phoneNumber, forKey: "phone")
            }
            self.navigationController?.pushViewController(changePageVC, animated: true)

        }else{
            print("修改密码")
            let changePageVC = ChangeInformationPageVC()
            changePageVC.section = indexPath.section
            changePageVC.passWord = "111"
            changePageVC.changePassWord = {(getSex) -> Void in
                let userDefaults = NSUserDefaults.standardUserDefaults()
                userDefaults.setValue(getSex, forKey: "mima")
            }

            self.navigationController?.pushViewController(changePageVC, animated: true)
        
        }
    }
    func changeHeaderImage(){
        let cancelAction = UIAlertAction(title: "取消",style:UIAlertActionStyle.Cancel){
            (UIAlertAction) -> Void in
        }
        //  1.相册
        let GoImageAl = UIAlertAction(title: "照片",style: UIAlertActionStyle.Default){
            (UIAlertAction) -> Void in
            self.GoImage()
        }
        //  2.相机
        let GoCameraAl = UIAlertAction(title: "相机",style: UIAlertActionStyle.Default){
            (UIAlertAction) -> Void in
            self.GoCamera()
        }
        
        //    把上述的三种情况添加到我的提示框中
        let actionSheet = UIAlertController(title: "选择图片", message: "", preferredStyle: UIAlertControllerStyle.ActionSheet)
        actionSheet.addAction(cancelAction)
        actionSheet.addAction(GoCameraAl)
        actionSheet.addAction(GoImageAl)
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    func GoImage(){
        let pickerImage = UIImagePickerController()
        //  得到视图
        
        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary){
            pickerImage.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            pickerImage.mediaTypes = UIImagePickerController.availableMediaTypesForSourceType(pickerImage.sourceType)!
        }
        pickerImage.delegate = self
        pickerImage.allowsEditing = true
        //        self.presentViewController(pickerImage, animated: true, completion: nil)
        self.presentViewController(pickerImage, animated: true) {
            self.changeImage = self.headerImageView
        }
        
    }
    func GoCamera(){
        var sourceType = UIImagePickerControllerSourceType.Camera
        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        }
        let picker = UIImagePickerController()
        //picker.delegate = self
        
        picker.delegate = self
        picker.allowsEditing = true//设置可编辑
        picker.sourceType = sourceType
        //        self.presentViewController(picker, animated: true, completion: nil)//进入照相界面
        self.presentViewController(picker, animated: true) {
            self.changeImage = self.headerImageView
        }
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        print("choose--------->>")
//        print(info)
    
        
        
//        let img = info[UIImagePickerControllerOriginalImage] as! UIImage
        let img = info[UIImagePickerControllerEditedImage] as! UIImage
        if(img.size.width>200 || img.size.height>200)
        {
            data = UIImageJPEGRepresentation(img, 0.1)!
        }
        else
        {
            data = UIImageJPEGRepresentation(img, 0.3)!
        }
        if (data.length>104850)
        {
            self.hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            self.hud.mode = MBProgressHUDMode.Text
            self.hud.margin = 10
            self.hud.removeFromSuperViewOnHide = true
            self.hud.labelText = "图片大于1M，请重新选择"
            self.hud.hide(true, afterDelay: 1)
            return
            
        }
        //  谁的图片需要修改
        self.changeImage.image = img
        //  现在有图片
        //  存到本地
        //  取到图片
        //  把本地图片文件改为二进制
        
        self.uploadImage("" as String)
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setValue("", forKey: "photo")



        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }

    func uploadImage(image:String){
        //  http://wxt.xiaocool.net/index.php?g=apps&m=index&a=UpdateUserName&userid=578&avatar=2939393.jpg
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let userid = userDefaults.valueForKey("userid")
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=index&a=UpdateUserName"
        let pmara = ["userid":userid,"avatar":image]
        POSTData(url, pmara: (pmara as? [String:AnyObject])!)
        
        
    }
    
    //  上传姓名
    func POSTData(url:String,pmara:NSDictionary){
        
        
        Alamofire.request(.GET, url, parameters: pmara as? [String:AnyObject]).response { request, response, json, error in
            
            
        }
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController){
        
        picker.dismissViewControllerAnimated(true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    



}
