//
//  AddJZGongGaoViewController.swift
//  WXT_Teacher
//
//  Created by xiaocool on 16/8/11.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
class AddJZGongGaoViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource,sendnameidDelegate{

    var tableview = UITableView()
    var nameL = UILabel()
    var titleTF = UITextField()
    var contentTV = UITextView()
    var id = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.frame=CGRectMake(0, 0, frame.width, frame.height)
        tableview.delegate=self
        tableview.dataSource=self
        self.view.addSubview(tableview)
        let rightItem = UIBarButtonItem(title: "发送", style: UIBarButtonItemStyle.Done, target: self, action: #selector(addDaijie))
        self.navigationItem.rightBarButtonItem = rightItem
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return 4
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = UITableViewCell()
        cell.selectionStyle = .None
        if indexPath.row==0 {
            cell.textLabel?.text="选择家长"
            cell.accessoryType = .DisclosureIndicator
            nameL.frame=CGRectMake(frame.width-120, 10, 90, 20)
            nameL.textAlignment = .Right
            nameL.text="选择家长"
            nameL.textColor=wenziColor
            cell.contentView.addSubview(nameL)
            tableView.rowHeight=40
        }else if indexPath.row==1{
            cell.textLabel?.text="公告标题"
            titleTF.frame=CGRectMake(100, 10, frame.width-120, 20)
            titleTF.textColor=wenziColor
            cell.contentView.addSubview(titleTF)
            tableView.rowHeight=40
            
        }else if indexPath.row==2{
            let lable = UILabel(frame: CGRectMake(15,10,100,20))
            lable.text="公告内容"
            cell.contentView.addSubview(lable)
            contentTV.frame=CGRectMake(5, 40, frame.width-10, 100)
            contentTV.layer.borderWidth=1
            contentTV.layer.cornerRadius=5
            contentTV.layer.borderColor=UIColor.grayColor().CGColor
            cell.contentView.addSubview(contentTV)
            tableView.rowHeight=150
        }else{
            cell.textLabel?.text="提交"
            tableView.rowHeight=40
        }
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row==0 {
            let vc = StudentLIstViewController()
            vc.delegate=self
            self.navigationController?.pushViewController(vc, animated: true)
            
        }else if indexPath.row==3{
           
        }
    }
    func sendnameid(name: String, id: String) {
        nameL.text=name
        self.id=id
    }
    func PandKong()->Bool{
        if(nameL.text=="选择家长"){
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.mode = MBProgressHUDMode.Text
            hud.labelText = "请选择家长"
            hud.margin = 10.0
            hud.removeFromSuperViewOnHide = true
            hud.hide(true, afterDelay: 1)
            return false
        }
        if(titleTF.text!.isEmpty){
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.mode = MBProgressHUDMode.Text
            hud.labelText = "请输入标题"
            hud.margin = 10.0
            hud.removeFromSuperViewOnHide = true
            hud.hide(true, afterDelay: 1)
            return false
        }
        if (contentTV.text!.isEmpty) {
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.mode = MBProgressHUDMode.Text
            hud.labelText = "请输入内容"
            hud.margin = 10.0
            hud.removeFromSuperViewOnHide = true
            hud.hide(true, afterDelay: 1)
            return false
            
        }

        
        return true
    }
    //http://wxt.xiaocool.net/index.php?g=apps&m=school&a=publishnotice&userid=597&type=1&title=标题&content=内容&photo=11.jpg&reciveid=12
    //MARK: - 发布通知公告
    func GETDate(id:String){
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=school&a=publishnotice"
        let defalutid = NSUserDefaults.standardUserDefaults()
        let userid = defalutid.stringForKey("userid")
        let param = [
            "userid" : userid,
            "reciveid" : id,
            "photo" : "123.jpg",
            "content" : contentTV.text!,
            "type":"1",
            "title":titleTF.text!
        ]
        Alamofire.request(.GET, url, parameters: param as? [String:String]).response { request, response, json, error in
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
                    hud.labelText = status.errorData
                    hud.margin = 10.0
                    hud.removeFromSuperViewOnHide = true
                    hud.hide(true, afterDelay: 1)
                }
                if(status.status == "success"){
                    print("Success")
                    
                }
            }
        }
        
        
    }
    func addDaijie(){
        if PandKong() {
            GETDate(self.id)
            self.navigationController?.popViewControllerAnimated(true)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
