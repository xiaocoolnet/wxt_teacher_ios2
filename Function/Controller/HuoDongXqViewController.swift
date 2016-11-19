//
//  HuoDongXqViewController.swift
//  WXT_Teacher
//
//  Created by 李春波 on 16/3/21.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import MBProgressHUD
import Alamofire
class HuoDongXqViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,sendnameidDelegate,sendTimeDelegate {
    
    var tableview = UITableView()
    var titleTF = BRPlaceholderTextView()
    var contentTV = BRPlaceholderTextView()
    var startBT = UIButton()
    var endBT = UIButton()
    var peopleTF = UITextField()
    var phoneTF = UITextField()
    var nameL = UILabel()
    var id = String()
    var timetag = String()
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        self.title = "发布活动"
        let rightItem = UIBarButtonItem(title:"发布",style: .Done,target: self,action: #selector(HuoDongXqViewController.EditKejian))
        self.navigationItem.rightBarButtonItem = rightItem
        tableview.frame=CGRectMake(0, 0, frame.width, frame.height)
        tableview.delegate=self
        tableview.dataSource=self
        self.view.addSubview(tableview)

    }

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section==3 || section==4 {
            return 2
        }else{
            return 1
        }
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        cell.selectionStyle = .None
        if indexPath.section == 0{
            cell.textLabel?.text="选择班级"
            cell.accessoryType = .DisclosureIndicator
            nameL.frame=CGRectMake(frame.width-150, 10, 120, 20)
            nameL.textAlignment = .Right
            nameL.textColor=wenziColor
            nameL.text="请选择"
            cell.contentView.addSubview(nameL)
            tableview.rowHeight=44
        }else if indexPath.section==1{
            titleTF.frame=CGRectMake(10, 10, frame.width-110, 20)
            titleTF.placeholder = "活动标题"
            titleTF.textColor=wenziColor
            cell.contentView.addSubview(titleTF)
            tableview.rowHeight=44
        }else if indexPath.section==2{
            contentTV.frame=CGRectMake(10, 10, frame.width-10, 100)
            contentTV.textColor=wenziColor
            contentTV.placeholder = "活动内容"
            cell.contentView.addSubview(contentTV)
            let textview = UITextView(frame: CGRectMake(5, 30, frame.width-10, 100))
            cell.contentView.addSubview(textview)
            tableview.rowHeight=140
        }else if indexPath.section==3{
            tableview.rowHeight=44
            cell.accessoryType = .DisclosureIndicator
            if indexPath.row==0 {
                cell.textLabel?.text="活动开始日期"
                startBT.frame=CGRectMake(100, 10, frame.width-110, 20)
                startBT.setTitle("请选择", forState: .Normal)
                startBT.setTitleColor(wenziColor, forState: .Normal)
                startBT.addTarget(self, action: #selector(startTime), forControlEvents: .TouchUpInside)
                cell.contentView.addSubview(startBT)
            }else{
                cell.textLabel?.text="活动结束日期"
                endBT.frame=CGRectMake(100, 10, frame.width-110, 20)
                endBT.setTitleColor(wenziColor, forState: .Normal)
                endBT.setTitle("请选择", forState: .Normal)
                endBT.addTarget(self, action: #selector(endTime), forControlEvents: .TouchUpInside)
                cell.contentView.addSubview(endBT)
            }
        }else if indexPath.section==4{
            tableview.rowHeight=44
            if indexPath.row==0 {
                cell.textLabel?.text="联系人"
                peopleTF.frame=CGRectMake(100, 10, frame.width-110, 20)
                peopleTF.textColor=wenziColor
                cell.contentView.addSubview(peopleTF)
            }else{
                cell.textLabel?.text="联系方式"
                phoneTF.frame=CGRectMake(100, 10, frame.width-110, 20)
                phoneTF.textColor=wenziColor
                cell.contentView.addSubview(phoneTF)
            }
        }
        return cell
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section==0 {
            let vc = StudentLIstViewController()
            vc.delegate=self
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    func sendnameid(name: String, id: String) {
        nameL.text=name
        self.id=id
    }
    func startTime(){
        
        let timevc = BirthdayViewController()
        timetag="start"
        timevc.delegate=self
        self.navigationController?.pushViewController(timevc, animated: true)
        
    }
    func endTime(){
       
        let timevc = BirthdayViewController()
        timetag="end"
        timevc.delegate=self
        self.navigationController?.pushViewController(timevc, animated: true)

    }
    func sendTime(time: String) {
        if timetag=="start" {
            startBT.setTitle(time, forState: .Normal)
        }else{
            endBT.setTitle(time, forState: .Normal)
        }
    }
    //发布
    func EditKejian(){
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=teacher&a=addactivity"
        
        let classid = NSUserDefaults.standardUserDefaults()
        let clid = classid.stringForKey("classid")
        let userid = NSUserDefaults.standardUserDefaults()
        let uid = userid.stringForKey("userid")
        let starttime = changeTimeThree((startBT.titleLabel?.text)!)
        let endtime = changeTimeThree((startBT.titleLabel?.text)!)
        
        let param = [
            "teacherid":uid!,
            "title":titleTF.text!,
            "content":contentTV.text!,
            "photo":"2.jpg",
            "classid":clid,
            "begintime":starttime,
            "endtime":endtime,
            "contactman":peopleTF.text,
            "contactphone":phoneTF.text,
            "isapply":"",
            "receiverid":"",
            "picture_url":""
        ]
        Alamofire.request(.GET, url, parameters: param as? [String:String]).response { request, response, json, error in
            if(error != nil){
            }
            else{
                print("request是")
                print(request!)
                print("====================")
                let result = Httpresult(JSONDecoder(json!))
                print("状态是")
                print(result.status)
                if(result.status == "error"){
                    let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                    hud.mode = MBProgressHUDMode.Text
                    hud.labelText = result.errorData
                    hud.margin = 10.0
                    hud.removeFromSuperViewOnHide = true
                    hud.hide(true, afterDelay: 1)
                }
                
                if(result.status == "success"){
                    print("班级活动发表成功")
                    print("Success")
                }
                
            }
            
        }
        
  
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   }
