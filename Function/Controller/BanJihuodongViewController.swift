//
//  BanJihuodongViewController.swift
//  WXT_Teacher
//
//  Created by 李春波 on 16/3/15.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import YYWebImage
import Alamofire
import MBProgressHUD
import MJRefresh

class BanJihuodongViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var activitySource = ActivityList()
  
    let arrayPeople = NSMutableArray()

    let huoDongTableView = UITableView()
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.GetDate()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "班级活动"
        self.view.backgroundColor = UIColor.whiteColor()
        
        //增加班级活动按钮
        let addBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: #selector(BanJihuodongViewController.addHuodong))
        self.navigationItem.rightBarButtonItem = addBtn
        
        self.automaticallyAdjustsScrollViewInsets = false
        huoDongTableView.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.frame.height-64)
        self.huoDongTableView.tableFooterView = UIView(frame: CGRectZero)
        huoDongTableView.delegate = self
        huoDongTableView.dataSource = self
        self.tabBarController?.tabBar.hidden = true
        self.view.addSubview(huoDongTableView)
        
        self.DropDownUpdate()
        GetDate()
        
    }
    
    func DropDownUpdate(){
        self.huoDongTableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { 
            self.GetDate()
            self.huoDongTableView.mj_header.endRefreshing()
        })
        self.huoDongTableView.mj_header.beginRefreshing()
    }
    
    //    获取活动列表
    func GetDate(){
        
        //       http://wxt.xiaocool.net/index.php?g=apps&m=index&a=ClassActivity&schoolid=1&classid=1
        
        let defalutid = NSUserDefaults.standardUserDefaults()
        let uid = defalutid.stringForKey("userid")
        let classid = defalutid.stringForKey("classid")
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=teacher&a=getactivitylist"
        let params = [
        
            "userid" : uid,
            "classid" : classid
        
        ]
        
        Alamofire.request(.GET, url, parameters: params as! [String : String]).response { request, response, json, error in
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
                    self.activitySource = ActivityList(status.data!)
                    self.huoDongTableView.reloadData()
//                    self.huoDongTableView.headerView?.endRefreshing()
                }
            }
        }
        
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.activitySource.count
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: String(indexPath.row))
        cell.selectionStyle = .None
        let activityInfo = self.activitySource.activityList[indexPath.row]
       
        
        //  得到活动中的内容
       
        
        //  活动标题
        let titleLbl = UILabel()
        titleLbl.frame = CGRectMake(10, 10, WIDTH - 20, 30)
        titleLbl.textAlignment = NSTextAlignment.Center
        titleLbl.text = activityInfo.title
        titleLbl.textColor = biaotiColor
        titleLbl.font = biaotifont
        cell.contentView.addSubview(titleLbl)
        //  活动内容
        let contentLbl = UILabel()
        contentLbl.font = neirongfont
        contentLbl.textColor = neirongColor
        contentLbl.text = activityInfo.content
        let contentLblheight = calculateHeight(activityInfo.content!, size: 15, width: WIDTH-20)
        contentLbl.frame = CGRectMake(10, titleLbl.frame.maxY + CGFloat(10), WIDTH - 20, contentLblheight)
        cell.contentView.addSubview(contentLbl)
        
        //  活动图片
        
        let pic = activityInfo.pic
        var image_h = CGFloat()
        var pics = Array<String>()
        for item in pic {
            pics.append(item.pictureurl!)
        }
        let picView = NinePicView(frame:CGRectMake(0, contentLbl.frame.maxY + 10, WIDTH,0),pic:pics,vc:self)
        cell.contentView.addSubview(picView)
        image_h = picView.image_h
        
        
        tableView.rowHeight = contentLbl.frame.maxY + 10 + image_h + 100
        
        let imageView = UIImageView()
        imageView.frame = CGRectMake(10, 80 + image_h + 10, 21, 21)
        imageView.image = UIImage.init(named: "ic_fasong")
        cell.contentView.addSubview(imageView)
        
        let senderLbl = UILabel()
        senderLbl.frame = CGRectMake(40, 80 + image_h + 10, 100, 20)
        senderLbl.font = timefont
        senderLbl.textColor = timeColor
        senderLbl.text = activityInfo.teacher_name
        cell.contentView.addSubview(senderLbl)
        print("aaaaaaaaaaa")
        print(senderLbl.text)
       
  


        //  活动时间
//        let dateformate = NSDateFormatter()
//        dateformate.dateFormat = "yyyy-MM-dd HH:mm"
//        let date = NSDate(timeIntervalSince1970: NSTimeInterval(activityInfo.create_time!)!
//        let str:String = dateformate.stringFromDate(date)
        let timeLbl = UILabel()
        timeLbl.frame = CGRectMake(110, 80+image_h+10, WIDTH - 120, 20)
        timeLbl.textAlignment = NSTextAlignment.Right
        timeLbl.font = timefont
        timeLbl.textColor = timeColor
        timeLbl.text = changeTime(activityInfo.create_time!)
        cell.contentView.addSubview(timeLbl)
        
        let line = UILabel()
        line.frame = CGRectMake(1, 119.5 + image_h, WIDTH - 2, 0.5)
        line.backgroundColor = UIColor.lightGrayColor()
        cell.addSubview(line)
        
        let baoming = UILabel()
        baoming.frame = CGRectMake(15, 130 + image_h, WIDTH - 30, 20)
        baoming.text = "已报名\(activityInfo.applylist.count)"
        baoming.textColor = UIColor.orangeColor()
        baoming.font = neirongfont
        cell.addSubview(baoming)
        
        let view = UIView()
        view.frame = CGRectMake(0, 160 + image_h, WIDTH, 20)
        view.backgroundColor = RGBA(242.0, g: 242.0, b: 242.0, a: 1)
        cell.addSubview(view)
        
        
        
        //  已报名
        //        cell.signUpLbl.text = "已报名\(activityInfo.readcount!)"
        
        return cell
    }

    func clickBtn(sender:UIButton){
        //            let activityInfo = self.activitySource.activityList[sender.tag]
        //            let detailsVC = PicDetailViewController()
        //
        //            detailsVC.activitySource = activityInfo
        //            detailsVC.activity_listSource = activity_listList(activityInfo.activity_list!)
        //            detailsVC.apply_countSource = apply_countList(activityInfo.apply_count!)
        //            detailsVC.picSource = picList(activityInfo.pic!)
        //            self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let activityInfo = self.activitySource.activityList[indexPath.row]
        //  进行传值
        let detailsVC = QCDetailsClassActiveVC()
        detailsVC.activitySource = activityInfo
      
        self.navigationController?.pushViewController(detailsVC, animated: true)
        

    }

    //MARK: - 增加班级活动事件
    func addHuodong() {
        let huodongVC = HuoDongXqViewController()
        self.navigationController?.pushViewController(huodongVC, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
