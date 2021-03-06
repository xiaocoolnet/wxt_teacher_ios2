//
//  ChooseTeacherViewController.swift
//  WXT_Teacher
//
//  Created by xiaocool on 16/8/29.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
import MJRefresh
protocol sendteachernameidArray:NSObjectProtocol {
    func sendteachernameid(name:NSMutableArray,id:NSMutableArray)
}
class ChooseTeacherViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let tableView = UITableView()
    var dataSource = ChooseTeacherModel()
    var selectAllBtnArray = NSMutableArray()
    var nameLabel = UILabel()
    var nameAry = NSMutableArray()
    var idAry = NSMutableArray()
    var delegate : sendteachernameidArray?
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
                    i += 1
                    nameAry.addObject(data.name!)
                    idAry.addObject(data.id!)
                }
            
            
        }
        nameLabel.text = "已选\(i)人"
    }
    //    开始刷新
    func DropDownUpdate(){
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.loadStudentData()
            self.tableView.mj_header.endRefreshing()
        })
        self.tableView.mj_header.beginRefreshing()

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
        headerView.backgroundColor = UIColor.whiteColor()
        
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
        cell.nameLabel.textColor = UIColor.blackColor()
        print(model.name)
        cell.select.selected = model.isSelected
        cell.select.tag = indexPath.row
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        cell.select.addTarget(self, action: #selector(self.selectBtnClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let currentCell = tableView.cellForRowAtIndexPath(indexPath) as! ChooseUserTableViewCell
        let model = self.dataSource.objectlist[indexPath.row]
        if currentCell.select.selected {
            currentCell.select.selected = false
            model.isSelected = false
            nameAry.removeAllObjects()
            idAry.removeAllObjects()
        }else{
            currentCell.select.selected = true
            model.isSelected = true
            nameAry.removeAllObjects()
            idAry.removeAllObjects()
        }
        var i = 0
        for user in self.dataSource.objectlist {
            if user.isSelected {
                i += 1
            }
        }
        //        if i < self.dataSource.objectlist.count{
        //            self.dataSource.objectlist[sender.sections!].isSelected = false
        //        }else if i == self.dataSource.objectlist[sender.sections!].studentlist.count{
        //            self.dataSource.objectlist[sender.sections!].isSelected = true
        //        }
        
        self.reloadDataFooterUI()
        tableView.reloadData()

    }
    
    
            //单选Btn
    func selectBtnClick(sender:CustomBtn) -> Void {
        let model = self.dataSource.objectlist[sender.tag]
        if sender.selected {
            sender.selected = false
            model.isSelected = false
            nameAry.removeAllObjects()
            idAry.removeAllObjects()
        }else{
            sender.selected = true
            model.isSelected = true
            nameAry.removeAllObjects()
            idAry.removeAllObjects()
        }
        var i = 0
        for user in self.dataSource.objectlist {
            if user.isSelected {
                i += 1
            }
        }
//        if i < self.dataSource.objectlist.count{
//            self.dataSource.objectlist[sender.sections!].isSelected = false
//        }else if i == self.dataSource.objectlist[sender.sections!].studentlist.count{
//            self.dataSource.objectlist[sender.sections!].isSelected = true
//        }
        
        self.reloadDataFooterUI()
        tableView.reloadData()
    }
    
    //根部全选按钮触发事件
    func footerSelectAllBtnClick() -> Void {
        nameAry.removeAllObjects()
        idAry.removeAllObjects()
        for data in self.dataSource.objectlist {
            data.isSelected = true
//            for model in data.studentlist {
//                model.isChecked = true
//            }
        }
        
        self.reloadDataFooterUI()
        tableView.reloadData()
    }
    //MARK: - 确认选择
    func Choose(){
        self.delegate?.sendteachernameid(nameAry, id: idAry)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
}
