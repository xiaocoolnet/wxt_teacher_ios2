//
//  StudentLIstViewController.swift
//  WXT_Teacher
//
//  Created by xiaocool on 16/8/9.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
protocol sendnameidDelegate:NSObjectProtocol {
    func sendnameid(name:String,id:String)
}
class StudentLIstViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    var tableView = UITableView()
    var studentSource = StudentListModel()
    var delegate : sendnameidDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor=UIColor.whiteColor()
        tableView.frame=CGRectMake(0, 0, frame.width, frame.height)
        tableView.delegate=self
        tableView.dataSource=self
        self.view.addSubview(tableView)
       GetDate()
    }
    func GetDate(){
       // http://wxt.xiaocool.net/index.php?g=apps&m=teacher&a=getteacherclasslistandstudentlist&teacherid=605
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=teacher&a=getteacherclasslistandstudentlist"
        let userid = NSUserDefaults.standardUserDefaults()
        let uid = userid.stringForKey("userid")
        let param = [
            "teacherid":uid!
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
                    self.studentSource = StudentListModel(status.data!)
                    self.tableView.reloadData()
                
                    
                    
                }
            }
        }
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.studentSource.count
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return self.studentSource.objectlist[section].count
            
        
    }
func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
    let info = studentSource.objectlist[indexPath.section].studentlist[indexPath.row]

    let cell = UITableViewCell()
    
    cell.textLabel?.text=info.name
    
    return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let info = studentSource.objectlist[indexPath.section].studentlist[indexPath.row]
        self.delegate?.sendnameid(info.name!, id: info.id!)
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
