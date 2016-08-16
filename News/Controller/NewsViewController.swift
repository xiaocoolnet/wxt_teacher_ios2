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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "消息"
        dataTableView.frame = CGRectMake(0, -55, self.view.bounds.width, self.view.bounds.height - 44)
        dataTableView.delegate = self
        dataTableView.dataSource = self
        dataTableView.registerClass(NewsTableViewCell.self, forCellReuseIdentifier: "NewsCell")
        let rightItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: #selector(NewsViewController.RightBtn))
        let leftItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Search, target: self, action: #selector(NewsViewController.LeftBtn))
        self.navigationItem.rightBarButtonItem = rightItem
        self.navigationItem.leftBarButtonItem = leftItem
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(dataTableView)
        
        self.DropDownUpdate()
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
                    self.dataTableView.headerView?.endRefreshing()
                }
            }
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return 8
        }
       if(section == 1){
            return newsSource.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("NewsCell", forIndexPath: indexPath) as! NewsTableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        if(indexPath.section == 0){
            if(indexPath.row == 0){
                cell.contextLabel.text = "小张妈妈发布了一张日记照片"
                cell.nameLabel.text = "最新消息"
                cell.avatorImage.image = UIImage(named:"最新消息" )
                return cell
            }
            if(indexPath.row == 1){
                cell.contextLabel.text = "小张妈妈回复了一条信息"
                cell.nameLabel.text = "信息群发"
                cell.avatorImage.image = UIImage(named:"信息群发")
                return cell
            }
            if(indexPath.row == 2){
                cell.contextLabel.text = "小张妈妈回复了一条信息"
                cell.nameLabel.text = "家长叮嘱"
                cell.avatorImage.image = UIImage(named:"家长叮嘱" )
                return cell
            }
            if(indexPath.row == 3){
                cell.contextLabel.text = "小张妈妈回复了一条信息"
                cell.nameLabel.text = "通知公告"
                cell.avatorImage.image = UIImage(named:"通知公告" )
                return cell
            }
            if(indexPath.row == 4){
                cell.contextLabel.text = "小张妈妈回复了一条信息"
                cell.nameLabel.text = "代办事宜"
                cell.avatorImage.image = UIImage(named:"代办事宜" )
                return cell
            }
            if(indexPath.row == 5){
                cell.contextLabel.text = "小张妈妈回复了一条信息"
                cell.nameLabel.text = "园丁沟通"
                cell.avatorImage.image = UIImage(named:"园丁沟通" )
                return cell
            }else if indexPath.row==6{
                cell.contextLabel.text = "小张妈妈回复了一条信息"
                cell.nameLabel.text = "通讯录"
                cell.avatorImage.image = UIImage(named:"园丁沟通" )
            }else if indexPath.row==7{
                cell.contextLabel.text = "小张妈妈回复了一条信息"
                cell.nameLabel.text = "作业"
                cell.avatorImage.image = UIImage(named:"园丁沟通" )
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
                let newsInfo = ZuiXinNewsViewController()
                self.navigationController?.pushViewController(newsInfo, animated: true)
                newsInfo.tabBarController?.tabBar.hidden = true
            }
            if indexPath.row == 1{
                let newsInfo = QFListViewController()
                self.navigationController?.pushViewController(newsInfo, animated: true)

                newsInfo.tabBarController?.tabBar.hidden = true
            }
            if indexPath.row == 2 {
                let JZvc = JZdingzhuViewController()
                self.navigationController?.pushViewController(JZvc, animated: true)
                JZvc.tabBarController?.tabBar.hidden=true
                
            }
            if indexPath.row == 3{
                let tongZhi = AnnounceViewController()
                self.navigationController?.pushViewController(tongZhi, animated: true)
                tongZhi.tabBarController?.tabBar.hidden = true
            }
            if indexPath.row == 4{
                let daiBan = DaiBanViewController()
                self.navigationController?.pushViewController(daiBan, animated: true)
                daiBan.tabBarController?.tabBar.hidden = true
            }else if indexPath.row==5{
                
              
                
            }else if indexPath.row==6{
                
                let vc=AddressBookViewController()
                self.navigationController?.pushViewController(vc, animated: true)
                
            }else if indexPath.row==7{
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
