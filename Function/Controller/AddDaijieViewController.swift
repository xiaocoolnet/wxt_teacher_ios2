//
//  AddDaijieViewController.swift
//  WXT_Teacher
//
//  Created by xiaocool on 16/7/29.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
class AddDaijieViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource,sendnameidDelegate{

    var tableview = UITableView()
    var nameL : UILabel!
    let textview = UITextView()
    var id = String()
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title="确认代接"
        self.view.backgroundColor=UIColor.whiteColor()
        tableview.frame=CGRectMake(0, 0, frame.width, frame.height)
        tableview.delegate=self
        tableview.dataSource=self
       tableview.scrollEnabled=false
        self.view.addSubview(tableview)
    }
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 3
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = UITableViewCell()
        if indexPath.row==0 {
            cell.accessoryType = .DisclosureIndicator
            cell.textLabel?.text="选择学生"
            nameL = UILabel(frame: CGRectMake(frame.width-100,10,90,20))
            nameL.text="选择 "
            nameL.font=UIFont.systemFontOfSize(14)
            cell.contentView.addSubview(nameL)
            
        tableView.rowHeight=44
        }else if indexPath.row==1{
            
            textview.frame=CGRectMake(5, 5, frame.width-10, 190)
            textview.layer.borderWidth=1
            textview.layer.cornerRadius=5
            textview.layer.borderColor=UIColor.grayColor().CGColor

            cell.addSubview(textview)
            tableView.rowHeight=200
        }else{
            cell.textLabel?.text="提交"
            tableview.rowHeight=44
        }
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row==0 {
            let vc = StudentLIstViewController()
            vc.delegate=self
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        if indexPath.row==2 {
            GETDate(self.id)
        }
    }

    func sendnameid(name: String, id: String) {
        nameL.text=name
        self.id=id
    }
  
    //MARK: - 发布待接确认
    //http://wxt.xiaocool.net/index.php?g=apps&m=teacher&a=addtransport&teacherid=605&studentid=661,666&photo=123.jpg&content=asdsad
    func GETDate(id:String){
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=teacher&a=addtransport"
        let defalutid = NSUserDefaults.standardUserDefaults()
        let userid = defalutid.stringForKey("userid")
        let param = [
            "teacherid" : userid,
            "studentid" : id,
            "photo" : "123.jpg",
            "content" : textview.text!
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
