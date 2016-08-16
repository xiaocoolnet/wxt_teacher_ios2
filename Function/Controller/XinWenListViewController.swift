//
//  XinWenListViewController.swift
//  WXT_Teacher
//
//  Created by 李春波 on 16/3/25.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
class XinWenListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
var SchoolNoticesSource = SchoolNoticesModel()
    let XinWenList = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        GetNoticesDate()
        self.view.backgroundColor = UIColor.whiteColor()
        XinWenList.delegate = self
        XinWenList.dataSource = self
        self.title = "新闻列表"
        XinWenList.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height - 64)
        XinWenList.tableFooterView = UIView(frame: CGRectZero)
        self.view.addSubview(XinWenList)
        // Do any additional setup after loading the view.
    }
    //MARK: - 获取校园通知接口
    func GetNoticesDate(){
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=school&a="+"getSchoolNotices"
        let school = NSUserDefaults.standardUserDefaults()
        let schoolid = school.stringForKey("schoolid")
        let param=[
            
            "schoolid":schoolid
        ]
        Alamofire.request(.GET, url, parameters: param as? [String:String]).response { request, response, json, error in
            print(request)
            if(error != nil){
            }
            else{
                
                let status = Http(JSONDecoder(json!))
                print("状态是")
                print(status.status)
                dispatch_async(dispatch_get_main_queue(), {
                    
                    if(status.status == "error"){
                        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                        hud.mode = MBProgressHUDMode.Text;
                        hud.margin = 10.0
                        hud.removeFromSuperViewOnHide = true
                        hud.hide(true, afterDelay: 1)
                    }
                    if(status.status == "success"){
                        self.SchoolNoticesSource = SchoolNoticesModel(status.data!)
                        self.XinWenList.reloadData()
                    }
                    
                    
                    
                })
            }
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SchoolNoticesSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let newsinfo = SchoolNoticesSource.objectlist[indexPath.row]
        
        let cell = SchoolListCell.cellWithTableView(tableView)
        cell.iconIV.image=UIImage(named: "宝宝秀场")
        cell.titleL.text=newsinfo.post_title
        cell.contentL.text=newsinfo.post_excerpt
        cell.timeL.text=newsinfo.post_date
        tableView.rowHeight=100
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
         let newsinfo = SchoolNoticesSource.objectlist[indexPath.row]
        let teacherinfo = XinWenInfoViewController()
        teacherinfo.id=newsinfo.id!
        teacherinfo.ziduan="notice"
        self.navigationController?.pushViewController(teacherinfo, animated: true)
    }

  

}
