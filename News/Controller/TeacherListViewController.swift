//
//  TeacherListViewController.swift
//  WXT_Teacher
//
//  Created by xiaocool on 16/9/29.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
import XWSwiftRefresh
protocol sendteacherArray:NSObjectProtocol {
    func sendteachernameid(name:String,id:String)
}
class TeacherListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let tableView = UITableView()
    var dataSource = ChooseTeacherModel()
    var selectAllBtnArray = NSMutableArray()
    var nameLabel = UILabel()
    var delegate : sendteacherArray?
    var isOpen = false
    var type = String()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=bkColor
        self.title="接收人"
        // 初始化视图
        initView()
        //刷新数据
        DropDownUpdate()
        
    }
    
    
    func initView() -> Void {
        tableView.frame = CGRectMake(0, 0, WIDTH, HEIGHT-64)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .None
        tableView.registerClass(ChooseUserTableViewCell.self, forCellReuseIdentifier: "chooseReciverCell")
        self.view.addSubview(tableView)

     
        
    }
        //    开始刷新
    func DropDownUpdate(){
        self.tableView.headerView = XWRefreshNormalHeader(target: self, action: #selector(self.loadStudentData))
        self.tableView.reloadData()
        self.tableView.headerView?.beginRefreshing()
    }
    
    
    func loadStudentData(){
        
        //http://wxt.xiaocool.net/index.php?g=apps&m=teacher&a=getteacherclasslistandstudentlist&teacherid=507
        
        let defalutid = NSUserDefaults.standardUserDefaults()
        let chid = defalutid.stringForKey("schoolid")
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=school&a=getteacherinfo"
        let param = [
            "schoolid":chid!,
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
                    hud.mode = MBProgressHUDMode.Text
                    hud.labelText = status.errorData
                    hud.margin = 10.0
                    hud.removeFromSuperViewOnHide = true
                    hud.hide(true, afterDelay: 1)
                }
                if(status.status == "success"){
                    //  self.messageSource = sendMessageList(status.data!)
                    
                    self.dataSource = ChooseTeacherModel(status.data!)
                    
                    self.tableView.reloadData()
                    self.tableView.headerView?.endRefreshing()
                }
            }
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: delegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (isOpen) {
            print(isOpen)
            return self.dataSource.objectlist.count;
        }else{
            return 0;
        }
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        let headerView = UIView()
        headerView.frame = CGRectMake(0, 0, WIDTH, 40)
        
        //展开折叠按钮
        let big_select_btn = UIButton()
        big_select_btn.frame = CGRectMake(0, 0, WIDTH, 40)
        big_select_btn.tag = section
        big_select_btn.selected = isOpen
        big_select_btn.addTarget(self, action: #selector(self.outspread(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        headerView.addSubview(big_select_btn)
        
        //组头展开折叠按钮
        let point_btn = UIButton()
        point_btn.frame = CGRectMake(10, 10, 20, 20)
        point_btn.setBackgroundImage(UIImage(named: "right"), forState: UIControlState.Normal)
        point_btn.setBackgroundImage(UIImage(named: "down"), forState: UIControlState.Selected)
        point_btn.tag = section
        point_btn.selected = isOpen
        headerView.addSubview(point_btn)
        
        
        //组名
        let titlelabel = UILabel()
        titlelabel.frame = CGRectMake(40, 10, WIDTH - 80, 20)
        titlelabel.text = "老师"
        titlelabel.textColor = UIColor.blackColor()
        headerView.addSubview(titlelabel)
        
        //分割线
        let lineView = UIView()
        lineView.frame = CGRectMake(0, 39.5, WIDTH, 0.5)
        lineView.backgroundColor = tableView.separatorColor
        headerView.addSubview(lineView)
        
        return headerView
    }
    //MARK: click
    //折叠展开点击事件
    func outspread(sender:UIButton) -> Void {
        if sender.selected {
            sender.selected = false
        }else{
            sender.selected = true
        }
        
        isOpen = sender.selected
        
        tableView.reloadData()
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("chooseReciverCell", forIndexPath: indexPath) as! ChooseUserTableViewCell
        
        let model = self.dataSource.objectlist[indexPath.row]
        
        
        cell.nameLabel.text = model.name
        cell.nameLabel.textColor = neirongColor
        cell.nameLabel.font=neirongfont
        print(model.name)
        cell.select.hidden=true
        
        
        
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if type=="1" {
            let model = self.dataSource.objectlist[indexPath.row]
            self.delegate?.sendteachernameid(model.name!, id:model.id! )
            self.navigationController?.popViewControllerAnimated(true)
        }
        
    }
    
}
