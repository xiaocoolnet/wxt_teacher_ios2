//
//  ChooseClassViewController.swift
//  WXT_Teacher
//
//  Created by xiaocool on 16/9/4.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
import XWSwiftRefresh
class ChooseClassViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    let tableView = UITableView()
    var dataSource = ChooseUserList()
    var selectAllBtnArray = NSMutableArray()
    var nameLabel = UILabel()
    var nameAry = NSMutableArray()
    var idAry = NSMutableArray()
    var delegate : sendnameidArray?
    var isOpen = false
    
    
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
        tableView.frame = CGRectMake(0, 0, WIDTH, HEIGHT-64-40)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .None
        tableView.registerClass(ChooseUserTableViewCell.self, forCellReuseIdentifier: "chooseReciverCell")
        self.view.addSubview(tableView)
        let rightItem = UIBarButtonItem(title: "确认", style: UIBarButtonItemStyle.Done, target: self, action: #selector(Choose))
        self.navigationItem.rightBarButtonItem = rightItem
        //初始化下面全选view
        self.setFooterUI()
        
        
    }
    
    func setFooterUI() -> Void {
        let footerView = UIView()
        footerView.backgroundColor = UIColor.whiteColor()
        footerView.frame = CGRectMake(0, HEIGHT - 104, WIDTH, 40)
        self.view.addSubview(footerView)
        
        nameLabel.frame = CGRectMake(10, 0, WIDTH - 100, 40)
        nameLabel.textColor = UIColor.orangeColor()
        nameLabel.text = "已选0人"
        footerView.addSubview(nameLabel)
        
        let selectAllbtn = UIButton()
        selectAllbtn.frame = CGRectMake(WIDTH - 100, 0, 100, 40)
        selectAllbtn.backgroundColor = UIColor.blueColor()
        selectAllbtn.setTitle("全选", forState: UIControlState.Normal)
        selectAllbtn.addTarget(self, action: #selector(self.footerSelectAllBtnClick), forControlEvents: UIControlEvents.TouchUpInside)
        footerView.addSubview(selectAllbtn)
        self.reloadDataFooterUI()
        
        
    }
    
    func reloadDataFooterUI() -> Void {
        var i = 0
        for data in self.dataSource.objectlist {
            if data.isSelected {
                nameAry.addObject(data.classname!)
                idAry.addObject(data.classid!)
                i += 1
            }
           
       }
        nameLabel.text = "已选\(i)个班级　"
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
        let chid = defalutid.stringForKey("userid")
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=teacher&a=getteacherclasslistandstudentlist"
        let param = [
            "teacherid":chid!,
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
                    
                    self.dataSource = ChooseUserList(status.data!)
                    
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
        if (self.isOpen) {
            print(self.isOpen)
            return self.dataSource.objectlist.count;
        }else{
            return 0;
        }
        
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "班级"
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        let headerView = UIView()
        headerView.frame = CGRectMake(0, 0, WIDTH, 40)
        
        //展开折叠按钮
        let big_select_btn = UIButton()
        big_select_btn.frame = CGRectMake(0, 0, WIDTH, 40)
        big_select_btn.tag = section
        big_select_btn.selected = self.isOpen
        big_select_btn.addTarget(self, action: #selector(self.outspread(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        headerView.addSubview(big_select_btn)
        
        //组头展开折叠按钮
        let point_btn = UIButton()
        point_btn.frame = CGRectMake(10, 10, 20, 20)
        point_btn.setBackgroundImage(UIImage(named: "right"), forState: UIControlState.Normal)
        point_btn.setBackgroundImage(UIImage(named: "down"), forState: UIControlState.Selected)
        point_btn.tag = section
        point_btn.selected = self.isOpen
        headerView.addSubview(point_btn)
        
        
        //组头全选按钮
//        let select_all_btn = UIButton()
//        select_all_btn.frame = CGRectMake(WIDTH - 30, 10, 20, 20)
//        select_all_btn.setBackgroundImage(UIImage(named: "deseleted"), forState: UIControlState.Normal)
//        select_all_btn.setBackgroundImage(UIImage(named: "selected"), forState: UIControlState.Selected)
//        select_all_btn.tag = section
//        select_all_btn.addTarget(self, action: #selector(self.selecAllBtnClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
//        selectAllBtnArray.addObject(select_all_btn)
//        headerView.addSubview(select_all_btn)
        
        //组名
        let titlelabel = UILabel()
        titlelabel.frame = CGRectMake(40, 10, WIDTH - 80, 20)
        titlelabel.text = "班级"
        titlelabel.textColor = UIColor.blackColor()
        headerView.addSubview(titlelabel)
        
        //分割线
        let lineView = UIView()
        lineView.frame = CGRectMake(0, 39.5, WIDTH, 0.5)
        lineView.backgroundColor = tableView.separatorColor
        headerView.addSubview(lineView)
        
        return headerView
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("chooseReciverCell", forIndexPath: indexPath) as! ChooseUserTableViewCell
        
        let model = self.dataSource.objectlist[indexPath.row]
        
        
        cell.nameLabel.text = model.classname
        cell.nameLabel.textColor = UIColor.blackColor()
        print(model.classname)
        cell.select.selected = model.isSelected
        cell.select.tag = indexPath.row
        cell.select.sections = indexPath.section
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        cell.select.addTarget(self, action: #selector(self.selectBtnClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        
        return cell
    }
    
    
    
    
    //MARK: click
    //折叠展开点击事件
    func outspread(sender:UIButton) -> Void {
        if sender.selected {
            sender.selected = false
        }else{
            sender.selected = true
        }
        
        self.isOpen = sender.selected
        
        tableView.reloadData()
    }
    //组头全选按钮
    func selecAllBtnClick(sender:UIButton) -> Void {
//        self.dataSource.objectlist[sender.tag].isSelected = false
        if sender.selected {
            sender.selected = false
            for model in self.dataSource.objectlist {
                model.isSelected = false
            }
        }else{
            sender.selected = true
//            self.dataSource.objectlist[sender.tag].isSelected = true
            for model in self.dataSource.objectlist {
                model.isSelected = true
            }
        }
        
        self.reloadDataFooterUI()
        tableView.reloadData()
    }
    //单选Btn
    func selectBtnClick(sender:CustomBtn) -> Void {
        let model = self.dataSource.objectlist[sender.tag]
        if sender.selected {
            sender.selected = false
            model.isSelected = false
//            nameAry.removeAllObjects()
//            idAry.removeAllObjects()
        }else{
            sender.selected = true
            model.isSelected = true
        }
        var i = 0
        for user in self.dataSource.objectlist{
            if user.isSelected {
                i += 1
            }
        }
        if i < self.dataSource.objectlist.count{
            self.dataSource.objectlist[sender.tag].isSelected = false
        }else if i == self.dataSource.objectlist[sender.sections!].studentlist.count{
            self.dataSource.objectlist[sender.tag].isSelected = true
        }
        
        self.reloadDataFooterUI()
        tableView.reloadData()
    }
    
    //根部全选按钮触发事件
    func footerSelectAllBtnClick() -> Void {
        
        for data in self.dataSource.objectlist {
            data.isSelected = true
        }
        
        self.reloadDataFooterUI()
        tableView.reloadData()
    }
    //MARK: - 确认选择
    func Choose(){
        self.delegate?.sendnameid(nameAry, id: idAry)
        self.navigationController?.popViewControllerAnimated(true)
    }
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden=true
        
    }
    override func viewWillDisappear(animated: Bool) {
        nameAry.removeAllObjects()
        idAry.removeAllObjects()
        self.tabBarController?.tabBar.hidden=false
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
