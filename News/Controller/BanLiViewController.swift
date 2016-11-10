//
//  BanLiViewController.swift
//  WXT_Teacher
//
//  Created by xiaocool on 16/9/1.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
class BanLiViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource,sendteachernameidArray{

    var tableview = UITableView()
    var nameL=UILabel()
    var contentL = UILabel()
    var lastnameL = UILabel()
    var lastideaL = UILabel()
    var myideaTV = UITextView()
    var nextnameL = UILabel()
    var info = DaibanInfo()
    var idStr = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor=UIColor.whiteColor()
        self.title="详情页"
        tableview.frame=CGRectMake(0, 0, frame.width, frame.height)
        tableview.delegate=self
        tableview.dataSource=self
        self.view.addSubview(tableview)
        let view = UIView(frame: CGRectMake(0,0,frame.width,120))
        tableview.tableFooterView=view
        let zhuanBT = UIButton(frame: CGRectMake(30,40,frame.width/4,30))
        zhuanBT.setTitle("转派", forState: .Normal)
        zhuanBT.addTarget(self, action: #selector(self.zhuanpai), forControlEvents: UIControlEvents.TouchUpInside)
        zhuanBT.layer.cornerRadius=5
        zhuanBT.backgroundColor=orangeColor
        view.addSubview(zhuanBT)
        let banBT = UIButton(frame: CGRectMake(frame.width-30-frame.width/4,40,frame.width/4,30))
        banBT.setTitle("办结", forState: .Normal)
        banBT.addTarget(self, action: #selector(self.banjie), forControlEvents: UIControlEvents.TouchUpInside)
        banBT.layer.cornerRadius=5
        banBT.backgroundColor=greenColor
        view.addSubview(banBT)
        
        
        
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if section==0 {
            return 5
        }else{
            return 1
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = UITableViewCell()
        cell.selectionStyle = .None
        if indexPath.section==0{
            if indexPath.row==0 {
                
                cell.textLabel?.text="发起人"
                nameL.frame=CGRectMake(150, 10, frame.width-160, 20)
                nameL.font=UIFont.systemFontOfSize(15)
                nameL.text=info.name
                let namel_H = calculateHeight(nameL.text!, size: 15, width: frame.width-160)
                nameL.frame.size.height=namel_H
                cell.contentView.addSubview(nameL)
                tableView.rowHeight=20+namel_H
                
            }else if indexPath.row==1{
                
                cell.textLabel?.text="申请内容"
                contentL.frame=CGRectMake(150, 10, frame.width-160, 20)
                contentL.font=UIFont.systemFontOfSize(15)
                contentL.text=info.content
                let namel_H = calculateHeight(contentL.text!, size: 15, width: frame.width-160)
                contentL.frame.size.height=namel_H
                cell.contentView.addSubview(contentL)
                tableView.rowHeight=20+namel_H
                
            }else if indexPath.row==2{
                
                cell.textLabel?.text="上一步经办人"
                lastnameL.frame=CGRectMake(150, 10, frame.width-160, 20)
                lastnameL.font=UIFont.systemFontOfSize(15)
                lastnameL.text=""
                if info.reciverlist.count != 0 {
    
                lastideaL.text=info.reciverlist.first?.name
                }
                let namel_H = calculateHeight(lastnameL.text!, size: 15, width: frame.width-160)
                lastnameL.frame.size.height=namel_H
                cell.contentView.addSubview(lastnameL)
                tableView.rowHeight=20+namel_H
                
            }else if indexPath.row==3{
                
                cell.textLabel?.text="上一步意见"
                lastideaL.frame=CGRectMake(150, 10, frame.width-160, 20)
                lastideaL.font=UIFont.systemFontOfSize(15)
                lastideaL.text=""
                if info.reciverlist.count != 0 {
                    lastideaL.text=info.reciverlist.first?.feedback
                }
                let namel_H = calculateHeight(lastideaL.text!, size: 15, width: frame.width-160)
                lastideaL.frame.size.height=namel_H
                cell.contentView.addSubview(lastideaL)
                tableView.rowHeight=20+namel_H
                
            }else {
                
                cell.textLabel?.text="我的意见"
                myideaTV.frame=CGRectMake(150, 10, frame.width-160, 60)
                myideaTV.layer.cornerRadius=5
                myideaTV.layer.borderWidth=1
                myideaTV.layer.borderColor=UIColor.grayColor().CGColor
                cell.contentView.addSubview(myideaTV)
                tableView.rowHeight=80
                
            }
        }else{
            
            cell.textLabel?.text="转派人"
            cell.accessoryType = .DisclosureIndicator
            nextnameL.frame=CGRectMake(150, 10, frame.width-180, 20)
            nextnameL.font=UIFont.systemFontOfSize(15)
            cell.contentView.addSubview(nextnameL)
            tableView.rowHeight=40
        }
        return cell
        
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section==1 {
            let vc = ChooseDaiBanViewController()
            vc.delegate=self
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    func sendteachernameid(name: NSMutableArray, id: NSMutableArray) {
        nextnameL.text=name.componentsJoinedByString(",")
        idStr = id.componentsJoinedByString(",")
    }
    
    //MARK:   点击事件
    func zhuanpai(){
        sendBanLi("0")
    }
    func banjie(){
        sendBanLi("1")
    }
    
    func sendBanLi(type:String) -> Void {
        if type == "0" {
            if  myideaTV.text.isEmpty {
                let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                hud.mode = MBProgressHUDMode.Text
                hud.labelText = "请选择转派人"
                hud.margin = 10.0
                hud.removeFromSuperViewOnHide = true
                hud.hide(true, afterDelay: 1)
                return
            }
        }
        let defalutid = NSUserDefaults.standardUserDefaults()
        let chid = defalutid.stringForKey("userid")
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=school&a=DoSchedul"
        let param = [
            "userid":chid!,
            "scheduleid":info.id,
            "feedback":myideaTV.text,
            "reciveid":idStr,
            "finish":type
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
                    let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                    hud.mode = MBProgressHUDMode.Text
                    hud.labelText = type=="0" ? "转派成功" : "办结成功"
                    hud.margin = 10.0
                    hud.removeFromSuperViewOnHide = true
                    hud.hide(true, afterDelay: 1)

                    
                    let vc = DaiBanViewController()
                    var target:UIViewController?
                    
                    for controller in (self.navigationController?.viewControllers)! {
                        if controller.isKindOfClass(vc .classForCoder) {
                            target = controller
                        }
                    }
                    if (target != nil) {
                        self.navigationController?.popToViewController(target!, animated: true)
                    }

                }
            }
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
