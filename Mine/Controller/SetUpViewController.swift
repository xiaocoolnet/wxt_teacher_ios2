//
//  SetUpViewController.swift
//  WXT_Teacher
//
//  Created by xiaocool on 16/7/20.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class SetUpViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var tableView = UITableView()
    var indexPath = NSIndexPath()
    var cell = UITableViewCell()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        createTableView()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //    MARK: - initUI()
    func initUI(){
        self.title = "设置"
        self.tabBarController?.tabBar.hidden = true
        self.view.backgroundColor = RGBA(239, g: 239, b: 244, a: 1)
        let exitButton = UIButton()
        exitButton.frame = CGRectMake(10, HEIGHT * 0.6, WIDTH - 20, 45)
        exitButton.backgroundColor = RGBA(155, g: 229, b: 180, a: 1)
        exitButton.layer.cornerRadius = 4
        exitButton.setTitle("退出登陆", forState: .Normal)
        exitButton.addTarget(self, action: #selector(Exitlogin), forControlEvents: .TouchUpInside)
        self.view.addSubview(exitButton)
    }
    //    MARK: - 退出登录
    func Exitlogin(){
        let alertController = UIAlertController(title: NSLocalizedString("", comment: "Warn"), message: NSLocalizedString("确认注销？", comment: "empty message"), preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
        let doneAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            //          清除登录信息
            let useDefaults = NSUserDefaults.standardUserDefaults()
            useDefaults.removeObjectForKey("userid")
            useDefaults.removeObjectForKey("name")
            useDefaults.removeObjectForKey("password")
            useDefaults.removeObjectForKey("schoolid")
            useDefaults.removeObjectForKey("classid")
            useDefaults.removeObjectForKey("chid")
            useDefaults.removeObjectForKey("chidname")
            useDefaults.synchronize()
            //            退出环信
//            EaseMob.sharedInstance().chatManager.asyncLogoffWithUnbindDeviceToken(false)
            
            let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            
            let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("LoginView")
            self.presentViewController(vc, animated: true, completion: nil)
            
        }
        alertController.addAction(doneAction)
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    //    MARK: - createTableView
    func createTableView(){
        tableView.frame = CGRectMake(0, 2, WIDTH, 200)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 50
        self.view.addSubview(tableView)
    }
    //    MARK: - UITableViewDataSource,UITableViewdeleGate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        self.indexPath = indexPath
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        self.cell = cell
        if indexPath.row == 3 {
        }else{
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }
        cell.selectionStyle = .None
        fillCell()
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //  点击事件
        print(indexPath)
        if indexPath.row == 0 {
            
        }
        if indexPath.row == 1 {
           
        }
        if indexPath.row == 2 {
        
            
        }
        if indexPath.row == 3 {
            // 取出cache文件夹路径
            let cachePath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).first
            // 打印路径,需要测试的可以往这个路径下放东西
            print(cachePath)
            // 取出文件夹下所有文件数组
            let files = NSFileManager.defaultManager().subpathsAtPath(cachePath!)
            // 用于统计文件夹内所有文件大小
            var big = Int();
            
            // 快速枚举取出所有文件名
            for p in files!{
                // 把文件名拼接到路径中
                let path = cachePath!.stringByAppendingFormat("/\(p)")
                // 取出文件属性
                let floder = try! NSFileManager.defaultManager().attributesOfItemAtPath(path)
                // 用元组取出文件大小属性
                for (abc,bcd) in floder {
                    // 只去出文件大小进行拼接
                    if abc == NSFileSize{
                        big += bcd.integerValue
                    }
                }
            }
            // 提示框
            let message = "\(big/(1024*1024))M缓存"
            let alert = UIAlertController(title: "清除缓存", message: message, preferredStyle: UIAlertControllerStyle.Alert)
            
            let alertConfirm = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default) { (alertConfirm) -> Void in
                // 点击确定时开始删除
                for p in files!{
                    // 拼接路径
                    let path = cachePath!.stringByAppendingFormat("/\(p)")
                    // 判断是否可以删除
                    if(NSFileManager.defaultManager().fileExistsAtPath(path)){
                        // 删除
                        try? NSFileManager.defaultManager().removeItemAtPath(path)
                    }
                }
            }
            alert.addAction(alertConfirm)
            let cancle = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel) { (cancle) -> Void in
            }
            alert.addAction(cancle)
            // 提示框弹出
            presentViewController(alert, animated: true) { () -> Void in
            }
        }
    }
    //  MARK: - 填充cell
    func fillCell(){
        if indexPath.row == 0 {
            getLabel("使用帮助")
        }
        if indexPath.row == 1 {
            getLabel("意见反馈")
        }
        if indexPath.row == 2 {
            getLabel("关于我们")
        }
        if indexPath.row == 3 {
            getLabel("清除缓存")
        }
    }
    func getLabel(content:String){
        let label = UILabel()
        label.text = content
        label.frame = CGRectMake(10, 10, 80, 30)
        cell.addSubview(label)
    }
    
    
    
}
