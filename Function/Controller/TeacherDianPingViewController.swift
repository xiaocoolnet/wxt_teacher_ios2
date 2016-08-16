//
//  TeacherDianPingViewController.swift
//  WXT_Teacher
//
//  Created by 李春波 on 16/3/12.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
import XWSwiftRefresh

class TeacherDianPingViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var dianPingSource = DianPingList()

    let DianPingView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "点评记录"
        self.view.backgroundColor = UIColor.whiteColor()
        self.tabBarController?.tabBar.hidden = true
        DianPingView.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height)
        DianPingView.dataSource = self
        DianPingView.delegate = self
        self.automaticallyAdjustsScrollViewInsets = false
        let emptyView = UIView()
        emptyView.frame = CGRectZero
        DianPingView.tableFooterView = emptyView
        let rightItem = UIBarButtonItem(title: "点评", style: .Done, target: self, action: #selector(TeacherDianPingViewController.FaBiao))
        self.navigationItem.rightBarButtonItem = rightItem
        DianPingView.registerClass(TeacherDianPingTableViewCell.self, forCellReuseIdentifier: "TDP")
        self.view.addSubview(DianPingView)
        // Do any additional setup after loading the view.
        self.DropDownUpdate()
    }
    
    func DropDownUpdate(){
//        self.DianPingView.headerView = XWRefreshNormalHeader(target: self, action: #selector(NewsViewController.GetDate))
//        self.DianPingView.reloadData()
//        self.DianPingView.headerView?.beginRefreshing()
    }
    
    func GetDate(){
        let url = apiUrl+"TeacherComment"
        //let userid = NSUserDefaults.standardUserDefaults()
        let uid = 599
        let param = [
            "stuid":uid
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
                    self.dianPingSource = DianPingList(status.data!)
                    self.DianPingView.reloadData()
                    self.DianPingView.headerView?.endRefreshing()
                    print("1")
                }
            }
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dianPingSource.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 114
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TDP", forIndexPath: indexPath) as! TeacherDianPingTableViewCell
        
        let pingsInfo = dianPingSource.objectlist[indexPath.row]
        
        cell.avatorImage.image = UIImage(named: "老师点评-1")
        cell.nameLabel.text = pingsInfo.name
        cell.timeLabel.text = pingsInfo.comment_time
        cell.selectionStyle = .None
        let options : NSStringDrawingOptions = NSStringDrawingOptions.UsesLineFragmentOrigin
        let string:NSString = pingsInfo.comment_content!
        let screenBounds:CGRect = UIScreen.mainScreen().bounds
        let boundingRect = string.boundingRectWithSize(CGSizeMake(screenBounds.width, 0), options: options, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(15)], context: nil)
        cell.contentLabel.frame = CGRectMake(11, 54, self.view.bounds.width - 22, boundingRect.height)
        cell.contentLabel.text = pingsInfo.comment_content
        return cell
    }
    
    func FaBiao(){
        print("发表")
        let dianpingList = DianPingListViewController()
        self.navigationController?.pushViewController(dianpingList, animated: true)
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
