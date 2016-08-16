//
//  MineMainViewController.swift
//  WXT_Teachers
//
//  Created by 李春波 on 16/2/25.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
//import Haneke
import MBProgressHUD

class MineMainViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    let mineTableView = UITableView()
    let exitBtn = UIButton()
    let avatorImage = UIImageView()
    let nameLabel = UILabel()
    let infoLabel = UILabel()
    let editBtn = UIButton()
    let jifenLabel = UILabel()
    let duiHuanBtn = UIButton()
    let qingchuHuancun = UIButton()
    let footview = UIView()
    let phoneBtn = UIButton()
    
    let vip = "Lv.2"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的"
        mineTableView.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height - 44 - 64)
        mineTableView.delegate = self
        mineTableView.dataSource = self
        mineTableView.registerClass(MineTableViewCell.self, forCellReuseIdentifier: "MineCell")
        let button1 = UIButton(frame:CGRectMake(0, 0, 40, 20))
        button1.setTitle("设置", forState: .Normal)
       button1.addTarget(self,action:#selector(setup),forControlEvents:.TouchUpInside)
        let barButton1 = UIBarButtonItem(customView: button1)
        self.navigationItem.rightBarButtonItem=barButton1


       
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(mineTableView)
    }
    //MARK: - 跳转设置
    func setup(){
        let vc = SetUpViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = false
    }
    //MARK: - 返回多少组
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    //MARK: - 返回多少行
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return 1
        }else{
            return 6
        }
        
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    //行高
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.section == 0){
            
                return 166
            
            
        }else{
            return 44
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Value1, reuseIdentifier: "userInfoCell")
        cell.selectionStyle = .None
        cell.accessoryType = .DisclosureIndicator
        let lable = UILabel(frame: CGRectMake(frame.width-200,10,170,20))
        lable.textAlignment = .Right
        lable.textColor=UIColor.grayColor()
        lable.font=UIFont.systemFontOfSize(14)
        
        
        if(indexPath.section == 0){
            if(indexPath.row == 0){
              
                cell.backgroundColor=UIColor(red: 155.0 / 255.0, green: 229.0 / 255.0, blue: 180.0 / 255.0, alpha: 1.0)
                self.avatorImage.frame = CGRectMake(10, 62, 80, 80)
                self.avatorImage.layer.cornerRadius = 40
                self.avatorImage.layer.masksToBounds = true
                self.avatorImage.image = UIImage(named: "Logo")
                let bt = UIButton(frame: CGRectMake(10, 62, 80, 80))
                bt.addTarget(self, action: #selector(changeInfo), forControlEvents: .TouchUpInside)
                
                self.nameLabel.frame = CGRectMake(104, 90, 73, 16)
                self.nameLabel.font = UIFont.systemFontOfSize(16)
                self.nameLabel.textColor = UIColor.whiteColor()
                self.nameLabel.text = "王丹老师"
                self.infoLabel.frame = CGRectMake(105, 115, 110, 11)
                self.infoLabel.font = UIFont.systemFontOfSize(11)
                self.infoLabel.textColor = UIColor.whiteColor()
                self.infoLabel.text = String(vip)
                
                cell.contentView.addSubview(self.avatorImage)
                cell.contentView.addSubview(self.nameLabel)
                cell.contentView.addSubview(self.infoLabel)
                cell.contentView.addSubview(bt)

                
            }}else {
                if indexPath.row==0 {
                    cell.textLabel?.text="积分商城"
                    lable.text="当前积分1000"
                    cell.contentView.addSubview(lable)
                }else if indexPath.row==1{
                    cell.textLabel?.text="扫一扫打卡"
                }else if indexPath.row==2{
                    cell.textLabel?.text="维护人员"
                    lable.text="小明 17878787878"
                    cell.contentView.addSubview(lable)
                }else if indexPath.row==3{
                    cell.textLabel?.text="在线留言"
                }else if indexPath.row==4{
                    cell.textLabel?.text="系统通知"
                }else if indexPath.row==5{
                    cell.textLabel?.text="客户端二维码名片"
                }
                
            }

        return cell
    }
    func changeInfo(){
        let vc = PersonInformation()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            }
    
        
    func ExitLogin(){
        let alertController = UIAlertController(title: NSLocalizedString("", comment: "Warn"), message: NSLocalizedString("确认注销？", comment: "empty message"), preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
        let doneAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            let userid = NSUserDefaults.standardUserDefaults()
            userid.setValue("", forKey: "userid")
            let defalutid = NSUserDefaults.standardUserDefaults()
            defalutid.setValue("", forKey: "cid")
            let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("LoginView") as! UINavigationController
            self.presentViewController(vc, animated: true, completion: nil)
        }
        alertController.addAction(doneAction)
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }

  
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
