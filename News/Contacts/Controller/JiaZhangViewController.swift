//
//  JiaZhangViewController.swift
//  WXT_Teachers
//
//  Created by 李春波 on 16/2/23.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
import XWSwiftRefresh


class JiaZhangViewController: UIViewController,FlexibleTableViewDelegate {
    
    var contactSource : ContactList = ContactList.init()
    var tableView: FlexibleTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = FlexibleTableView(frame: CGRectMake(0, -30, self.view.bounds.width, self.view.bounds.height - 114), delegate: self)
        self.tableView.registerClass(ContactsTableViewCell.self, forCellReuseIdentifier: "ContactsCell")
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(tableView)
    }
    
    func DropDownUpdate(){
        self.tableView.headerView = XWRefreshNormalHeader(target: self, action: #selector(JiaZhangViewController.GetDate))
        self.tableView.reloadData()
        self.tableView.headerView?.beginRefreshing()
    }
    
    func GetDate(){
        let url = apiUrl+"MessageAddress"
        let userid = 597
//        let uid = userid.stringForKey("userid")
        let param = [
            "userid":userid
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
                    print("0")
                    
                }
                if(status.status == "success"){
                    self.contactSource = ContactList(status.data!)
                    self.tableView.reloadData()
                    self.tableView.headerView?.endRefreshing()
                    print("1")
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //有几组
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    //一组几个父类行
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    //默认的哪一行展开
    func tableView(tableView: UITableView, shouldExpandSubRowsOfCellAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        if (indexPath.section == 0 && indexPath.row == 0){
            return true
        }
        
        return false
    }
    //哪一行里面有多少子类行
    func tableView(tableView: UITableView, numberOfSubRowsAtIndexPath indexPath: NSIndexPath) -> Int
    {
        if(indexPath.row == 0){
            return 2
        }
        if(indexPath.row == 1){
            return 3
        }
        return 0
    }
    
    //每一父类行的标题是什么
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = FlexibleTableViewCell(style:.Default, reuseIdentifier:"cell")
        cell.expandable = true
        if(indexPath.row == 0){
            cell.textLabel?.text = "小二班"
        }
        if(indexPath.row == 1){
            cell.textLabel?.text = "幼儿三班"
        }
        
        return cell
    }
    //加载子类行的数据
    func tableView(tableView: UITableView, cellForSubRowAtIndexPath indexPath: FlexibleIndexPath) -> UITableViewCell {
        let duanxinBtn = UIButton()
        let ipBtn = UIButton()
        let phoneBtn = UIButton()
        let cell = tableView.dequeueReusableCellWithIdentifier("ContactsCell", forIndexPath: indexPath.ns) as! ContactsTableViewCell
        duanxinBtn.frame = CGRectMake(0, 26, 17, 17)
        duanxinBtn.frame.origin.x = self.view.bounds.width - 72
        ipBtn.frame = CGRectMake(0, 26, 17, 17)
        ipBtn.frame.origin.x = self.view.bounds.width - 50
        phoneBtn.frame = CGRectMake(0, 26, 17, 17)
        phoneBtn.frame.origin.x = self.view.bounds.width - 30
        duanxinBtn.setImage(UIImage(named: "发消息"), forState: .Normal)
        ipBtn.setImage(UIImage(named: "电话"), forState: .Normal)
        phoneBtn.setImage(UIImage(named: "电话2"), forState: .Normal)
        cell.nameLabel.text = "小明爸爸"
        cell.contentView.addSubview(duanxinBtn)
        cell.contentView.addSubview(ipBtn)
        cell.contentView.addSubview(phoneBtn)
        return cell
    }
    
    func collapseSubrows() {
        tableView.collapseCurrentlyExpandedIndexPaths()
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
