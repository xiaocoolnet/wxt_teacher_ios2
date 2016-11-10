//
//  NewsViewController.swift
//  WXT_Teachers
//
//  Created by 李春波 on 16/2/23.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
import XWSwiftRefresh

class NewsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var dataTableView = UITableView()
    var newsSource = NewsList()
    //群发消息
    var messageLab = UILabel()
    //家长叮嘱
    var trustLab = UILabel()
    //通知公告
    var noticeLab = UILabel()
    //代办
    var scheduleLab = UILabel()
    //待接（园丁沟通）
    var deliveryLab = UILabel()
    //作业
    var homeworkLab = UILabel()

    var count1 = "0"
    var count2 = "0"
    var count3 = "0"
    var count4 = "0"
    var count5 = "0"
 
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "消息"
        dataTableView.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height - 44)
        dataTableView.delegate = self
        dataTableView.dataSource = self
        dataTableView.registerClass(NewsTableViewCell.self, forCellReuseIdentifier: "NewsCell")
        let rightItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: #selector(NewsViewController.RightBtn))
        let leftItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Search, target: self, action: #selector(NewsViewController.LeftBtn))
        self.navigationItem.rightBarButtonItem = rightItem
        self.navigationItem.leftBarButtonItem = leftItem
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(dataTableView)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.gameOver(_:)), name: "push", object: nil)
        self.DropDownUpdate()
    }
    func gameOver(title:NSNotification){
        if title.object as! String == "message"{
            let vc = QFListViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if title.object as! String == "trust"{
            let vc = JZdingzhuViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if title.object as! String == "notice"{
            let vc = AnnounceViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if title.object as! String == "schedule"{
            let vc = DaiBanViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if title.object as! String == "homework"{
            let vc = HomeworkViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }

    }
    

    func DropDownUpdate(){
        self.dataTableView.headerView = XWRefreshNormalHeader(target: self, action: #selector(NewsViewController.GetDate))
        self.dataTableView.reloadData()
        self.dataTableView.headerView?.beginRefreshing()
    }
    
    func GetDate(){
        let url = apiUrl+"ReceiveidMessage"
        let userid = NSUserDefaults.standardUserDefaults()
        let uid = userid.stringForKey("userid")
        let param = [
            "userid":uid!
        ]
        Alamofire.request(.GET, url, parameters: param).response { request, response, json, error in
            if(error != nil){
            }
            else{
                print("request是")
                print(request!)
                print("====================")
                let status = Http(JSONDecoder(json!))
                print("状态是")
                print(status.status)
                if(status.status == "error"){
                    let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                    hud.mode = MBProgressHUDMode.Text;
                    hud.margin = 10.0
                    hud.removeFromSuperViewOnHide = true
                    hud.hide(true, afterDelay: 1)
                    
                }
                if(status.status == "success"){
                    self.newsSource = NewsList(status.data!)
                    self.dataTableView.reloadData()
                    
                }
                
            }
            self.dataTableView.headerView?.endRefreshing()
        }
    }
    
    func RightBtn(){
        print("点击了右边的按钮")
        
    }
    
    func LeftBtn(){
        print("点击了左边的按钮")
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = false
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.game(_:)), name: "count", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.game2(_:)), name: "trustArr", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.game3(_:)), name: "noticeArr", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.game4(_:)), name: "scheduleArr", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.game6(_:)), name: "homeworkArr", object: nil)
        let chid = NSUserDefaults.standardUserDefaults()
        if chid.valueForKey("count") != nil {
            
            let arr = chid.valueForKey("count") as! NSArray
            messageLab.text = String(arr.count)
            messageLab.hidden=false
        }else{
            messageLab.removeFromSuperview()
        }
        if messageLab.text == "0" {
            messageLab.removeFromSuperview()
        }
        if chid.valueForKey("trustArr") != nil {
            
            let arr = chid.valueForKey("trustArr") as! NSArray
            trustLab.text = String(arr.count)
            trustLab.hidden=false
            
        }else{
            trustLab.removeFromSuperview()
        }
        if trustLab.text == "0" {
            trustLab.removeFromSuperview()
        }
        if chid.valueForKey("noticeArr") != nil {
            
            let arr = chid.valueForKey("noticeArr") as! NSArray
            noticeLab.text = String(arr.count)
        }else{
            noticeLab.removeFromSuperview()
        }
        if noticeLab.text == "0" {
            noticeLab.removeFromSuperview()
        }
        if chid.valueForKey("scheduleArr") != nil {
            
            let arr = chid.valueForKey("scheduleArr") as! NSArray
            scheduleLab.text = String(arr.count)
        }else{
            scheduleLab.removeFromSuperview()
        }
        if scheduleLab.text == "0" {
            scheduleLab.removeFromSuperview()
        }
        if chid.valueForKey("homeworkArr") != nil {
            
            let arr = chid.valueForKey("homeworkArr") as! NSArray
            homeworkLab.text = String(arr.count)
        }else{
            homeworkLab.removeFromSuperview()
        }
        if homeworkLab.text == "0" {
            homeworkLab.removeFromSuperview()
        }

    dataTableView.reloadData()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    func game(count:NSNotification){
        let arr = count.object as! NSArray
        messageLab.text = String(arr.count)
        count1=String(arr.count)
        print("lable =", String(arr.count))
        dataTableView.reloadData()
    }
    func game2(count:NSNotification){
        let arr = count.object as! NSArray
        trustLab.text = String(arr.count)
        count2=String(arr.count)
        dataTableView.reloadData()
    }
    func game3(count:NSNotification){
        let arr = count.object as! NSArray
        noticeLab.text = String(arr.count)
        count3=String(arr.count)
        dataTableView.reloadData()
    }
    func game4(count:NSNotification){
        let arr = count.object as! NSArray
        scheduleLab.text = String(arr.count)
        count4=String(arr.count)
        dataTableView.reloadData()
    }

    func game6(count:NSNotification){
        let arr = count.object as! NSArray
        homeworkLab.text = String(arr.count)
        count5=String(arr.count)
        dataTableView.reloadData()
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return 7
        }
       if(section == 1){
            return newsSource.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("NewsCell", forIndexPath: indexPath) as! NewsTableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        let user = NSUserDefaults.standardUserDefaults()
        if(indexPath.section == 0){
       
            if(indexPath.row == 0){
                
                let qunfa = user.valueForKey("qunfa") as? String
                if qunfa=="" || qunfa==nil {
                    cell.contextLabel.text = "暂无消息"
                }else{
                
                cell.contextLabel.text = qunfa
                }
                cell.nameLabel.text = "信息群发"
                cell.avatorImage.image = UIImage(named:"信息群发")
                messageLab.frame=CGRectMake(40,6,18,18)
                messageLab.backgroundColor=UIColor.redColor()
                messageLab.layer.masksToBounds=true
                messageLab.layer.cornerRadius=9
                messageLab.adjustsFontSizeToFitWidth=true
                messageLab.textColor=UIColor.whiteColor()
                messageLab.textAlignment = .Center
                messageLab.font=UIFont.systemFontOfSize(12)
                if count1 != "0" {
                    cell.contentView.addSubview(messageLab)
                }
                
                return cell
            }
            if(indexPath.row == 1){
                let qunfa = user.valueForKey("dingzhu") as? String
                if qunfa=="" || qunfa==nil {
                    cell.contextLabel.text = "暂无消息"
                }else{
                    
                    cell.contextLabel.text = qunfa
                }

                cell.nameLabel.text = "家长叮嘱"
                cell.avatorImage.image = UIImage(named:"家长叮嘱" )
                trustLab.frame=CGRectMake(40,6,18,18)
                trustLab.backgroundColor=UIColor.redColor()
                trustLab.layer.masksToBounds=true
                trustLab.layer.cornerRadius=9
                trustLab.adjustsFontSizeToFitWidth=true
                trustLab.textColor=UIColor.whiteColor()
                trustLab.textAlignment = .Center
                trustLab.font=UIFont.systemFontOfSize(12)
                if count2 != "0" {
                    cell.contentView.addSubview(trustLab)
                }
                
                
                return cell
            }
            if(indexPath.row == 2){
                let qunfa = user.valueForKey("gonggao") as? String
                if qunfa=="" || qunfa==nil {
                    cell.contextLabel.text = "暂无消息"
                }else{
                    
                    cell.contextLabel.text = qunfa
                }

                cell.nameLabel.text = "通知公告"
                cell.avatorImage.image = UIImage(named:"通知公告" )
                noticeLab.frame=CGRectMake(40,6,18,18)
                noticeLab.backgroundColor=UIColor.redColor()
                noticeLab.layer.masksToBounds=true
                noticeLab.layer.cornerRadius=9
                noticeLab.adjustsFontSizeToFitWidth=true
                noticeLab.textColor=UIColor.whiteColor()
                noticeLab.textAlignment = .Center
                noticeLab.font=UIFont.systemFontOfSize(12)
                if count3 != "0" {
                    cell.contentView.addSubview(noticeLab)
                }
                
                return cell
            }
            if(indexPath.row == 3){
                let qunfa = user.valueForKey("daiban") as? String
                if qunfa=="" || qunfa==nil {
                    cell.contextLabel.text = "暂无消息"
                }else{
                    
                    cell.contextLabel.text = qunfa
                }

                cell.nameLabel.text = "待办事宜"
                cell.avatorImage.image = UIImage(named:"代办事宜" )
                scheduleLab.frame=CGRectMake(40,6,18,18)
                scheduleLab.backgroundColor=UIColor.redColor()
                scheduleLab.layer.masksToBounds=true
                scheduleLab.layer.cornerRadius=9
                scheduleLab.adjustsFontSizeToFitWidth=true
                scheduleLab.textColor=UIColor.whiteColor()
                scheduleLab.textAlignment = .Center
                scheduleLab.font=UIFont.systemFontOfSize(12)
                if count4 != "0" {
                    
                    cell.contentView.addSubview(scheduleLab)
                }
                

                return cell
            }
            if(indexPath.row == 4){
                let qunfa = user.valueForKey("yuanding") as? String
                if qunfa=="" || qunfa==nil {
                    cell.contextLabel.text = "暂无消息"
                }else{
                    
                    cell.contextLabel.text = qunfa
                }

                cell.nameLabel.text = "园丁沟通"
                cell.avatorImage.image = UIImage(named:"园丁沟通" )
                return cell
            }else if indexPath.row==5{
                
                cell.nameLabel.text = "通讯录"
                cell.avatorImage.image = UIImage(named:"园丁沟通" )
            }else if indexPath.row==6{
                let qunfa = user.valueForKey("zuoye") as? String
                if qunfa=="" || qunfa==nil {
                    cell.contextLabel.text = "暂无消息"
                }else{
                    
                    cell.contextLabel.text = qunfa
                }

                cell.nameLabel.text = "班级作业"
                cell.avatorImage.image = UIImage(named:"园丁沟通" )
                homeworkLab.frame=CGRectMake(40,6,18,18)
                homeworkLab.backgroundColor=UIColor.redColor()
                homeworkLab.layer.masksToBounds=true
                homeworkLab.layer.cornerRadius=9
                homeworkLab.adjustsFontSizeToFitWidth=true
                homeworkLab.textColor=UIColor.whiteColor()
                homeworkLab.textAlignment = .Center
                homeworkLab.font=UIFont.systemFontOfSize(12)
                if count5 != "0" {
                    
                    cell.contentView.addSubview(homeworkLab)
                }
            }
            
        }
        if(indexPath.section == 1){
            let newsInfo = newsSource.objectlist[indexPath.row]
            cell.contextLabel.text = newsInfo.message_content!
            cell.nameLabel.text = newsInfo.sendName!
            cell.avatorImage.image = UIImage(named: "Logo")
            return cell
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0{
          
            if indexPath.row == 0{
                let newsInfo = QFListViewController()
                self.navigationController?.pushViewController(newsInfo, animated: true)

                newsInfo.tabBarController?.tabBar.hidden = true
            }
            if indexPath.row == 1 {
                let JZvc = JZdingzhuViewController()
                self.navigationController?.pushViewController(JZvc, animated: true)
                JZvc.tabBarController?.tabBar.hidden=true
                
            }
            if indexPath.row == 2{
                let tongZhi = AnnounceViewController()
                self.navigationController?.pushViewController(tongZhi, animated: true)
                tongZhi.tabBarController?.tabBar.hidden = true
            }
            if indexPath.row == 3{
                let daiBan = DaiBanViewController()
                self.navigationController?.pushViewController(daiBan, animated: true)
                daiBan.tabBarController?.tabBar.hidden = true
            }else if indexPath.row==4{
                
              
                
            }else if indexPath.row==5{
                
                let vc=AddressBookViewController()
                self.navigationController?.pushViewController(vc, animated: true)
                
            }else if indexPath.row==6{
                let vc = HomeworkViewController()
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
        }
        if(indexPath.section == 1){
            self.dataTableView.deselectRowAtIndexPath(indexPath, animated: true)
            let newsInfo = NewsInfoViewController()
            self.navigationController?.pushViewController(newsInfo, animated: true)
            newsInfo.newsInfo = self.newsSource.objectlist[indexPath.row]
            newsInfo.tabBarController?.tabBar.hidden = true
        }
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if(indexPath.section == 0){
            return false
        }
        return true
    }

    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        print(indexPath.section)
        if editingStyle == .Delete
        {
            
        }
    }

}
