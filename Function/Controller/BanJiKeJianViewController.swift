//
//  BanJiKeJianViewController.swift
//  WXT_Teacher
//
//  Created by 李春波 on 16/3/12.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
import XWSwiftRefresh

class BanJiKeJianViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var keJianSource = KeJianList()
    
    let kejianTableview = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "宝宝课件"
        self.tabBarController?.tabBar.hidden = true
        self.kejianTableview.delegate = self
        self.kejianTableview.dataSource = self
        self.automaticallyAdjustsScrollViewInsets = false
        self.kejianTableview.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height)
        self.kejianTableview.tableFooterView = UIView(frame: CGRectZero)
        self.view.addSubview(self.kejianTableview)
        let rightItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(ZhouPlanViewController.EditPlan))
        self.navigationItem.rightBarButtonItem = rightItem
        self.DropDownUpdate()
        
        // Do any additional setup after loading the view.
    }
    
    func DropDownUpdate(){
        self.kejianTableview.headerView = XWRefreshNormalHeader(target: self, action: #selector(NewsViewController.GetDate))
        self.kejianTableview.reloadData()
        self.kejianTableview.headerView?.beginRefreshing()
    }
    
    func GetDate(){
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=index&a=SchoolCourseware"
        let user = NSUserDefaults.standardUserDefaults()
        let schoolid = user.stringForKey("schoolid")
        let classid = user.stringForKey("classid")
        
        let param = [
            "schoolid":schoolid,
            "classid":classid
            
        ]
        Alamofire.request(.GET, url, parameters: param as! [String : String]).response { request, response, json, error in
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
                    self.keJianSource = KeJianList(status.data!)
                    self.kejianTableview.reloadData()
                    self.kejianTableview.headerView?.endRefreshing()
                    print("1")
                }
            }
        }
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keJianSource.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let kejianInfo = keJianSource.objectlist[indexPath.row]
        
        //        let checkBtn = UIButton()
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        cell.selectionStyle = .None
        cell.accessoryType = .DisclosureIndicator
        
        cell.textLabel?.text = kejianInfo.subject
        
        let contentLabel = UILabel()
        contentLabel.frame = CGRectMake(self.view.bounds.width - 50, 16, 50, 14)
        contentLabel.font = neirongfont
        contentLabel.textColor = neirongColor
        cell.contentView.addSubview(contentLabel)
        contentLabel.text = "\(kejianInfo.courseware_info.count)条"
        self.view.backgroundColor = UIColor.whiteColor()
        
        //        checkBtn.frame = CGRectMake(0, 10, 70, 30)
        //        checkBtn.frame.origin.x = self.view.bounds.width - 80
        //        checkBtn.backgroundColor = UIColor(red: 255/255, green: 130/255, blue: 4/255, alpha: 1)
        //        checkBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        //        checkBtn.setTitle("查看", forState: .Normal)
        //        checkBtn.addTarget(self, action: #selector(BanJiKeJianViewController.CheckKejian), forControlEvents: .TouchUpInside)
        //        checkBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
        //        checkBtn.layer.cornerRadius = 5
        //        checkBtn.layer.masksToBounds = true
        //        cell.contentView.addSubview(checkBtn)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let kejianInfo = keJianSource.objectlist[indexPath.row]
        
        let kejian = KeJianInfoViewController()
        kejian.activitySource = kejianInfo
        self.navigationController?.pushViewController(kejian, animated: true)
//        kejian.title = kejianInfo.courseware_title
//        kejian.contentTextView.text = kejianInfo.courseware_content
//        kejian.nameKejian.text = "主讲人：" + kejianInfo.releasename!
        
    }
    //    func CheckKejian(){
    //        let kejian = KeJianInfoViewController()
    //        self.navigationController?.pushViewController(kejian, animated: true)
    //    }
    
    
    
    func EditPlan(sender:AnyObject){
        let vc = AddKeJianViewController()
    
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
