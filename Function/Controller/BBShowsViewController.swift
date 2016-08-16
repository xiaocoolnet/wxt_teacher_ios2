//
//  BBShowsViewController.swift
//  WXT_Teacher
//
//  Created by apple on 16/4/7.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

import Alamofire
import MBProgressHUD
class BBShowsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    private var tableview=UITableView()
    private var TeacherSoure=TeacherModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title="宝宝秀场"
        tableview.frame=CGRectMake(0, 0, frame.width, frame.height)
        tableview.delegate=self
        tableview.dataSource=self
        tableview.rowHeight=80
        getTeacherList()
        self.view.addSubview(tableview)
        
    }
    func getTeacherList(){
        
        let url = schoolUrl+"getbabyinfos"
        let school = NSUserDefaults.standardUserDefaults()
        let schoolid = school.stringForKey("schoolid")
        let param = [
            "schoolid":schoolid
        ]
        print(url)
        Alamofire.request(.GET, url, parameters: param as? [String : String]).response { request, response, json, error in
            if(error != nil){
            }
            else{
                print(request)
                let status = Http(JSONDecoder(json!))
                print("状态是")
                print(status.status)
                if(status.status == "error"){
                    let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                    hud.mode = MBProgressHUDMode.Text;
                    hud.margin = 10.0
                    hud.removeFromSuperViewOnHide = true
                    hud.hide(true, afterDelay: 1)
                }
                if(status.status == "success"){
                    self.TeacherSoure = TeacherModel(status.data!)
                    self.tableview.reloadData()
                }
                
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return TeacherSoure.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = TeacherTableViewCell.cellWithTableView(tableView)
        let teacherlistinfo = TeacherSoure.objectlist[indexPath.row]
        
        
        cell.titleL.text=teacherlistinfo.post_title
        cell.iconIV.image=UIImage(named: "宝宝秀场")
        cell.timeL.text=teacherlistinfo.post_date
        cell.contentL.text=teacherlistinfo.post_excerpt
        
        return cell
        
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = TeacherInfoViewController()
        let teacherlistinfo = TeacherSoure.objectlist[indexPath.row]
        vc.a="baby"
        vc.id=teacherlistinfo.id!
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
