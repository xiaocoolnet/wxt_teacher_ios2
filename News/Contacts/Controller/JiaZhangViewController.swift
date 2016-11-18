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
import MJRefresh


class JiaZhangViewController: UIViewController,FlexibleTableViewDelegate {
    
    var contactSource : JiazhangModel?
    var tableView: FlexibleTableView!
    var subRows = Array<Int>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.whiteColor()
        //加载数据
        loadData()
        //加载视图
        loadSubviews()
        
    }
    
    
    //MARK: - 加载数据
    func loadData() -> Void {
        self.GetDate()
    }
    func GetDate(){
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=index&a=ParentContacts"
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
                    print("0")
                    
                }
                if(status.status == "success"){
                    self.contactSource = JiazhangModel(status.data!)
                    self.tableView.refreshData()
//                    print(self.contactSource?.objectlist[0].teacherlist[0].name)
                    print("fu")
                    print(self.contactSource?.count)
                    for ob in (self.contactSource?.objectlist)!{
                        self.subRows.append(ob.student_list.count)
                        
                    }
                    print(self.subRows)
                    
                }
            }
        }
    }
    //MARK: - 加载视图
    func loadSubviews() -> Void {
        tableView = FlexibleTableView(frame: CGRectMake(0, -30, self.view.bounds.width, self.view.bounds.height - 114), delegate: self)
        self.tableView.registerClass(ContactsTableViewCell.self, forCellReuseIdentifier: "ContactsCell")
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(tableView)
    }
    
    
    
    func DropDownUpdate(){
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { 
            self.GetDate()
            self.tableView.mj_header.endRefreshing()
        })
        self.tableView.mj_header.beginRefreshing()
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
        if self.contactSource?.count>0 {
            print(self.contactSource?.count)
            return (self.contactSource?.count)!
        }
        
        return 0
    }
    //默认的哪一行展开(self.contactSource?.count)!
    func tableView(tableView: UITableView, shouldExpandSubRowsOfCellAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        //        if (indexPath.section == 0 && indexPath.row == 0){
        //            return true
        //        }
        //        print("indexpath.row=\(indexPath.row)")
        return false
    }
    //哪一行里面有多少子类行
    func tableView(tableView: UITableView, numberOfSubRowsAtIndexPath indexPath: NSIndexPath) -> Int
    {
        if self.contactSource?.objectlist[indexPath.row].count>0 {
            
            print(self.contactSource?.objectlist[indexPath.row].count)
            return (self.contactSource?.objectlist[indexPath.row].count)!
        }
        
        return 0
    }
    
    //每一父类行的标题是什么
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = FlexibleTableViewCell(style:.Default, reuseIdentifier:"cell")
        cell.expandable = true
        if self.contactSource?.count>0 {
            cell.textLabel?.text = self.contactSource?.objectlist[indexPath.row].classname
            
        }
    
        return cell
    }
    //加载子类行的数据
    func tableView(tableView: UITableView, cellForSubRowAtIndexPath indexPath: FlexibleIndexPath) -> UITableViewCell {

    
        var cell = tableView.dequeueReusableCellWithIdentifier("ContactsCell", forIndexPath: indexPath.ns) as? ContactsTableViewCell
     cell?.iconIV.image=UIImage(named: "宝宝头像")
         cell?.iconIV.layer.cornerRadius=25
        if cell==nil {
            cell = ContactsTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "ContactsCell")
        }
        if self.contactSource?.count>0 {
            let babyname = self.contactSource?.objectlist[indexPath.row].student_list[indexPath.subRow-1].name
            let jzname = self.contactSource?.objectlist[indexPath.row].student_list[indexPath.subRow-1].parent_list[0].name
            let guanxi = self.contactSource?.objectlist[indexPath.row].student_list[indexPath.subRow-1].parent_list[0].appellation
            
            
            cell!.nameLabel.text = jzname!+"("+babyname!+"的"+guanxi!+")"
        }
        
//        cell?.ipBtn.tag = Int((self.contactSource?.objectlist[indexPath.row].teacherlist[indexPath.subRow-1].phone)!)!
        if (self.contactSource?.objectlist[indexPath.row].student_list[indexPath.subRow-1].parent_list[0].phone) != nil {
                 cell?.ipBtn.titleLabel?.text=(self.contactSource?.objectlist[indexPath.row].student_list[indexPath.subRow-1].parent_list[0].phone)!
        }
 
        cell?.ipBtn.addTarget(self, action: #selector(JiaZhangViewController.phone(_:)), forControlEvents: UIControlEvents.TouchUpInside)
    
        return cell!
    }
    
        
    func tableView(tableView: FlexibleTableView, didSelectSubRowAtIndexPath indexPath: FlexibleIndexPath) {
        
    }
    func collapseSubrows() {
        tableView.collapseCurrentlyExpandedIndexPaths()
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    //MARK: - 点击事件
    func phone(button:UIButton) -> Void {
        print("dianhua")
        
        let tel = String(button.titleLabel?.text)
        print(tel)
        let url = NSURL(string: "tel://"+tel)
        if button.titleLabel?.text != nil {
             UIApplication.sharedApplication().openURL(url!)
        }
       
        
        
    }
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden=true
    }
    override func viewWillDisappear(animated: Bool) {
        self.tabBarController?.tabBar.hidden=false
    }
    

    
}
