//
//  QCOnlineHelpVC.swift
//  WXT_Parents
//
//  Created by 沈晓龙 on 16/7/14.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

class QOnlineHelpVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableView = UITableView()
    var dataSource = AirlinesList()
    
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = true
        loadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        let btn = UIButton()
        btn.frame = CGRectMake(0, 0, 40, 20)
        btn.setTitle("留言", forState: .Normal)
        btn.addTarget(self, action: #selector(self.shezhi), forControlEvents: .TouchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btn)
        
        createTable()
//        loadData()
        
    }
    
    func shezhi(){
        let vc = QCOnlineHelpVC()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func loadData(){
        
//         http://wxt.xiaocool.net/index.php?g=apps&m=index&a=GetLeaveMessageBySelf&userid=
        //
        //下面两hid句代码是从缓存中取出userid（入参）值
        let defalutid = NSUserDefaults.standardUserDefaults()
        let chid = defalutid.stringForKey("userid")
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=index&a=GetLeaveMessageBySelf"
        let param = [
            "userid":chid!,
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
                    //                    self.messageSource = sendMessageList(status.data!)
                    
                    self.dataSource = AirlinesList(status.data!)
                    
                    self.tableView.reloadData()
                    //                    self.table.headerView?.endRefreshing()
                }
            }
        }
    }
    
    func createTable(){
        tableView.frame = CGRectMake(0, 0, WIDTH, HEIGHT - 60)
        tableView.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.objectlist.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier:String(indexPath.row))
        tableView.separatorStyle = .None
        cell.selectionStyle = .None
        let model = self.dataSource.objectlist[indexPath.row]
        
        let photo = UIImageView()
        photo.frame = CGRectMake(10, 10, 30, 30)
        photo.image = UIImage(named: "touxiang")
        cell.contentView.addSubview(photo)
        
        let content = UILabel()
        content.frame = CGRectMake(50, 10, WIDTH - 60, 30)
        content.text = model.message
        content.numberOfLines = 0
        content.sizeToFit()
        cell.contentView.addSubview(content)
        // 计算群发内容高度
        let options : NSStringDrawingOptions = NSStringDrawingOptions.UsesLineFragmentOrigin
        let screenBounds:CGRect = UIScreen.mainScreen().bounds
        let boundingRect = String(content.text).boundingRectWithSize(CGSizeMake(screenBounds.width, 0), options: options, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(17)], context: nil)
        let contentheight = boundingRect.size.height + 10
        
        let time = UILabel()
        time.frame = CGRectMake(50, contentheight + 30, WIDTH - 60, 20)
        time.text = changeTime(model.create_time!)
        time.font = UIFont.systemFontOfSize(15)
        time.textColor = UIColor.lightGrayColor()
        cell.contentView.addSubview(time)
        let line = UILabel()
        line.backgroundColor = UIColor.lightGrayColor()
        line.frame = CGRectMake(0, contentheight + 49.5, WIDTH, 0.5)
        cell.contentView.addSubview(line)
        
        let img = UIImageView()
        img.frame = CGRectMake(10, contentheight + 60, 30, 30)
        img.image = UIImage(named: "touxiang")
        cell.contentView.addSubview(img)
        
        let contentLab = UILabel()
        contentLab.frame = CGRectMake(50, contentheight + 60, WIDTH - 60, 30)
        
        let timeLab = UILabel()
        
        if model.feed_time != "0" {
            contentLab.text = model.feed_back
            contentLab.numberOfLines = 0
            contentLab.sizeToFit()
            cell.contentView.addSubview(contentLab)
            // 计算群发内容高度
            let option : NSStringDrawingOptions = NSStringDrawingOptions.UsesLineFragmentOrigin
            let screenBound:CGRect = UIScreen.mainScreen().bounds
            let boundingRec = String(contentLab.text).boundingRectWithSize(CGSizeMake(screenBound.width, 0), options: option, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(17)], context: nil)
            let contentheigt = boundingRec.size.height + 10
            
            timeLab.frame = CGRectMake(10, contentheigt + 30, WIDTH - 20, 20)
            timeLab.text = changeTime(model.feed_time!)
            timeLab.font = UIFont.systemFontOfSize(15)
            timeLab.textColor = UIColor.lightGrayColor()
            cell.contentView.addSubview(timeLab)
            
            let view = UIView()
            view.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
            view.frame = CGRectMake(0, contentheigt + 50, WIDTH, 10)
            cell.contentView.addSubview(view)
            tableView.rowHeight = view.frame.maxY
        }else{
            contentLab.text = "客服还没有给回复"
            cell.contentView.addSubview(contentLab)
            
            let nowDate = NSDate()
            let formatter = NSDateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            let dateString = formatter.stringFromDate(nowDate)
            timeLab.frame = CGRectMake(50, contentheight + 110, WIDTH - 60, 20)
            timeLab.text = dateString
            timeLab.font = UIFont.systemFontOfSize(15)
            timeLab.textColor = UIColor.lightGrayColor()
            cell.contentView.addSubview(timeLab)
            let view = UIView()
            view.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
            view.frame = CGRectMake(0, contentheight + 130, WIDTH, 10)
            cell.contentView.addSubview(view)
            tableView.rowHeight = view.frame.maxY
        }
        
        return cell
    }
    
    
    //时间戳转时间
    func changeTime(string:String)->String{
        let dateformate = NSDateFormatter()
        dateformate.dateFormat = "yyyy-MM-dd HH:mm"//获得日期
        let date = NSDate(timeIntervalSince1970: NSTimeInterval(string)!)
        let str:String = dateformate.stringFromDate(date)
        return str
    }
}

