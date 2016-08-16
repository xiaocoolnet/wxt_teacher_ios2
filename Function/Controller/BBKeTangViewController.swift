//
//  BBKeTangViewController.swift
//  WXT_Teacher
//
//  Created by 李春波 on 16/3/12.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
import XWSwiftRefresh

class BBKeTangViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var keBiaoSource = KeChengList()
    
    let lastDayBtn = UIButton()
    let nextDayBtn = UIButton()
    let timeLabel = UILabel()
    let lastMonthBtn = UIButton()
    let nextMonthBtn = UIButton()
    let weekLabel = UILabel()
    let ketangTableView = UITableView()
    var yi = NSMutableArray()
    var er = NSMutableArray()
    var san = NSMutableArray()
    var si = NSMutableArray()
    var wu = NSMutableArray()
    var liu = NSMutableArray()
    var qi = NSMutableArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "宝宝课表"
        self.ketangTableView.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height-40)
        self.ketangTableView.dataSource = self
        self.ketangTableView.delegate = self
        self.ketangTableView.tableFooterView = UIView(frame: CGRectZero)
        self.automaticallyAdjustsScrollViewInsets = false
        self.tabBarController?.tabBar.hidden = true
        self.view.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(self.ketangTableView)
        // Do any additional setup after loading the view.
        
        self.DropDownUpdate()
        
    }
    
    func DropDownUpdate(){
        self.ketangTableView.headerView = XWRefreshNormalHeader(target: self, action: #selector(NewsViewController.GetDate))
        self.ketangTableView.reloadData()
        self.ketangTableView.headerView?.beginRefreshing()
    }
    
    func GetDate(){
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=school&a="+"ClassSyllabus"
        let defalutid = NSUserDefaults.standardUserDefaults()
        let classid = defalutid.stringForKey("classid")
        let schoolid = defalutid.stringForKey("schoolid")
        
        let param = [
            "schoolid":schoolid,
            "classid":classid
            
        ]
        Alamofire.request(.GET, url, parameters: param as?[String:String]).response { request, response, json, error in
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
                    self.keBiaoSource = KeChengList(status.data!)
                    print(self.keBiaoSource.count)
                    //将课程分组
                    for kechen in self.keBiaoSource.objectlist {

                            self.yi.addObject(kechen.monday!)


                            self.er.addObject(kechen.tuesday!)

                            self.san.addObject(kechen.wednesday!)

                            self.si.addObject(kechen.thursday!)

                            self.wu.addObject(kechen.friday!)

                            self.liu.addObject(kechen.saturday!)

                            self.qi.addObject(kechen.sunday!)

                    }
                    self.ketangTableView.reloadData()
                    self.ketangTableView.headerView?.endRefreshing()
                }
            }
        }
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.keBiaoSource.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section==0 {
            return yi.count
        }
        if section==1 {
            return er.count
        }
        if section==2 {
            return san.count
        }
        if section==3 {
            return si.count
        }
        if section==4 {
            return wu.count
        }
        if section==5 {
            return liu.count
        }
        else{
            return qi.count
        }

        
    }

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 20
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 50
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        cell.selectionStyle = .None

        if indexPath.section==0 {
            let str = yi[indexPath.row] as! String
            cell.textLabel?.text="第\(indexPath.row+1)节课："+str
        }
        if indexPath.section==1{
            let str = er[indexPath.row] as! String
            cell.textLabel?.text="第\(indexPath.row+1)节课："+str
        }
        if indexPath.section==2{
            let str = san[indexPath.row] as! String
            cell.textLabel?.text="第\(indexPath.row+1)节课："+str
        }
        if indexPath.section==3{
            let str = si[indexPath.row] as! String
            cell.textLabel?.text="第\(indexPath.row+1)节课："+str
        }
        if indexPath.section==4{
            let str = wu[indexPath.row] as! String
            cell.textLabel?.text="第\(indexPath.row+1)节课："+str
        }
        if indexPath.section==5{
            let str = liu[indexPath.row] as! String
            cell.textLabel?.text="第\(indexPath.row+1)节课："+str
        }
        if indexPath.section==6{
            let str = qi[indexPath.row] as! String
            cell.textLabel?.text="第\(indexPath.row+1)节课："+str
        }
       
        return cell
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        if(section == 0){
            let view = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 18))
            let label = UILabel(frame: CGRectMake(5, 1, tableView.frame.size.width, 18))
            label.font = UIFont.systemFontOfSize(12)
            label.text = "星期一"
            label.textColor = UIColor(red: 144/255, green: 144/255, blue: 144/255, alpha: 1)
            view.addSubview(label)
            view.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
            return view
        }
        if(section == 1){
            let view = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 18))
            let label = UILabel(frame: CGRectMake(5, 1, tableView.frame.size.width, 18))
            label.font = UIFont.systemFontOfSize(12)
            label.text = "星期二"
            label.textColor = UIColor(red: 144/255, green: 144/255, blue: 144/255, alpha: 1)
            view.addSubview(label)
            view.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
            return view
        }
        if(section == 2){
            let view = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 18))
            let label = UILabel(frame: CGRectMake(5, 1, tableView.frame.size.width, 18))
            label.font = UIFont.systemFontOfSize(12)
            label.text = "星期三"
            label.textColor = UIColor(red: 144/255, green: 144/255, blue: 144/255, alpha: 1)
            view.addSubview(label)
            view.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
            return view
        }
        if(section == 3){
            let view = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 18))
            let label = UILabel(frame: CGRectMake(5, 1, tableView.frame.size.width, 18))
            label.font = UIFont.systemFontOfSize(12)
            label.text = "星期四"
            label.textColor = UIColor(red: 144/255, green: 144/255, blue: 144/255, alpha: 1)
            view.addSubview(label)
            view.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
            return view
        }
        if(section == 4){
            let view = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 18))
            let label = UILabel(frame: CGRectMake(5, 1, tableView.frame.size.width, 18))
            label.font = UIFont.systemFontOfSize(12)
            label.text = "星期五"
            label.textColor = UIColor(red: 144/255, green: 144/255, blue: 144/255, alpha: 1)
            view.addSubview(label)
            view.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
            return view
        }
        if(section == 5){
            let view = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 18))
            let label = UILabel(frame: CGRectMake(5, 1, tableView.frame.size.width, 18))
            label.font = UIFont.systemFontOfSize(12)
            label.text = "星期六"
            label.textColor = UIColor(red: 144/255, green: 144/255, blue: 144/255, alpha: 1)
            view.addSubview(label)
            view.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
            return view
        }
        if(section == 6){
            let view = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 18))
            let label = UILabel(frame: CGRectMake(5, 1, tableView.frame.size.width, 18))
            label.font = UIFont.systemFontOfSize(12)
            label.text = "星期日"
            label.textColor = UIColor(red: 144/255, green: 144/255, blue: 144/255, alpha: 1)
            view.addSubview(label)
            view.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
            return view
        }

        return UIView(frame: CGRectZero)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    

   

}
