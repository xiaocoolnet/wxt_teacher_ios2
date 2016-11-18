//
//  TongGaoViewController.swift
//  WXT_Teacher
//
//  Created by 李春波 on 16/3/29.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD


class TongGaoListViewController:UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var TongGaoList = UITableView()
    var schoolListSource = SchoolListModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GetNewsDate()
        self.view.backgroundColor = UIColor.whiteColor()
        TongGaoList.delegate = self
        TongGaoList.dataSource = self
        self.title = "公告列表"
        TongGaoList.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height - 64)
        TongGaoList.tableFooterView = UIView(frame: CGRectZero)
        self.view.addSubview(TongGaoList)
        // Do any additional setup after loading the view.
        
       
    }
    //MARK: - 获取新闻动态接口
    func GetNewsDate(){
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=school&a="+"getSchoolNews"
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
                        self.schoolListSource = SchoolListModel(status.data!)
                        self.TongGaoList.reloadData()
                    }
                    
                    
                    
                })
            }
        }
    }
     func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return schoolListSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
 
        let newsinfo = schoolListSource.objectlist[indexPath.row]
        
        let cell = SchoolListCell.cellWithTableView(tableView)
        cell.iconIV.image=UIImage(named: "宝宝秀场")
        cell.titleL.text=newsinfo.post_title
        cell.contentL.text=newsinfo.post_excerpt
        cell.timeL.text=newsinfo.post_date
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let newsinfo = schoolListSource.objectlist[indexPath.row]
        let xinweninfo = XinWenInfoViewController()
        xinweninfo.id=newsinfo.id!
        xinweninfo.ziduan="news"
        self.navigationController?.pushViewController(xinweninfo, animated: true)
    }
    
}
