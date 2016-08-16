//
//  SchoolViewController.swift
//  WXT_Teacher
//
//  Created by 李春波 on 16/3/11.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import ImageSlideshow
import Alamofire
import MBProgressHUD
class SchoolViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    let schoolTableView = UITableView()
    let scrollImageView = ImageSlideshow()
    let yuanquBtn = UIButton()
    let yuanquLabel = UILabel()
    let jiaoshiBtn = UIButton()
    let jiaoshiLabel = UILabel()
    let xiaoyfcBtn = UIButton()
    let xiaoyfcLabel = UILabel()
    let bbxcBtn = UIButton()
    let bbxcLabel = UILabel()
    let zhaopinBT = UIButton()
    let zhaopinL = UILabel()
    let xinxiangBT = UIButton()
    let xinxiangL = UILabel()
    let xingquBT = UIButton()
    let xingquL = UILabel()
    let baomingBT = UIButton()
    let baomingL = UILabel()

    let yqgg = UIImageView()
    let yqggLabel1 = UILabel()
    let yqggLabel2 = UILabel()
    let teacherPic = UIImageView()
    let contentText = UILabel()
    let xwdt = UIImageView()
    let xwdtLabel1 = UILabel()
    let xwdtLabel2 = UILabel()
    let teacherPic1 = UIImageView()
    let contentText1 = UILabel()
    let yedt = UIImageView()
    let yedtLabel1 = UILabel()
    let yedtLabel2 = UILabel()
    let teacherPic2 = UIImageView()
    let contentText2 = UILabel()
    var schoolListSource = SchoolListModel()
    var SchoolNoticesSource = SchoolNoticesModel()
    
    var yuErList = YuErList()
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //加载数据
        loadData()
        //加载视图
        loadSubviews()
        
        
    }
    
    //MARK: - 加载数据
    func loadData() -> Void {
        
//        getYuErData()
        
        GetNewsDate()
        GetNoticesDate()
        
        
    }
    
  
    //获取育儿知识
    func getYuErData() -> Void {
        let url = apiUrl+"ParentingKnowledge"
        let schoolid = 1
        
        let param = [
            "schoolid":schoolid
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
                    
                }
                if(status.status == "success"){
                    print(status.data)
                    self.yuErList = YuErList(status.data!)
                    self.schoolTableView.reloadData()
                    self.schoolTableView.headerView?.endRefreshing()
                }
            }
        }

    }
    //MARK: - 加载视图
    func loadSubviews() -> Void {
        self.title = "学校官网"
        self.schoolTableView.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height-64)
        self.automaticallyAdjustsScrollViewInsets = false
        self.schoolTableView.delegate = self
        self.schoolTableView.dataSource = self
        ScrollViewImage()
        self.view.backgroundColor = UIColor.whiteColor()
        self.tabBarController?.tabBar.hidden = true
        self.view.addSubview(self.schoolTableView)
    }
    
  //MARK: - 滚动式图添加图片
    func ScrollViewImage(){
        scrollImageView.slideshowInterval = 5.0
        scrollImageView.setImageInputs([AFURLSource(urlString: "http://pic2.ooopic.com/01/03/51/25b1OOOPIC19.jpg")!, AFURLSource(urlString: "http://ppt360.com/background/UploadFiles_6733/201012/2010122016291897.jpg")!, AFURLSource(urlString: "http://img.taopic.com/uploads/allimg/130501/240451-13050106450911.jpg")!])
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
                        self.schoolTableView.reloadData()
                    }
                    
                    
                    
                })
            }
        }
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
                        self.schoolTableView.reloadData()
                    }
                    
                    
                    
                })
            }
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0{
            if indexPath.row == 0{
                return 150
            }
            return 200
        }
        if indexPath.section == 1{
            if indexPath.row == 0{
                return 30
            }
            return 100
        }
        if indexPath.section == 2{
            if indexPath.row == 0{
                return 30
            }
            return 100
        }
        if indexPath.section == 3{
            if indexPath.row == 0{
                return 30
            }
            return 100
        }

        return 0
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1:
            return SchoolNoticesSource.count+1
        case 2:
            return schoolListSource.count+1
        case 3:
            return 2
        default:
            return 2
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        cell.selectionStyle = .None
        if indexPath.section == 0{
            if indexPath.row == 0{
                scrollImageView.frame = CGRectMake(0, 0, self.view.bounds.width, 150)
                cell.contentView.addSubview(scrollImageView)
                return cell
            }
            if indexPath.row == 1{
                self.yuanquBtn.frame = CGRectMake(0, 3, 60, 60)
                self.yuanquBtn.center.x = self.view.bounds.width/8
                self.yuanquBtn.setImage(UIImage(named: "园区介绍"), forState: .Normal)
                self.yuanquBtn.addTarget(self, action: #selector(SchoolViewController.yuanquJieShao), forControlEvents: .TouchUpInside)
                self.yuanquLabel.frame = CGRectMake(0, 66, 50, 12)
                self.yuanquLabel.font = UIFont.systemFontOfSize(12)
                self.yuanquLabel.center.x = self.view.bounds.width/8
                self.yuanquLabel.text = "园区介绍"
                self.yuanquLabel.textAlignment = .Center
                self.jiaoshiBtn.frame = CGRectMake(0, 3, 60, 60)
                self.jiaoshiBtn.center.x = self.view.bounds.width/8*3
                self.jiaoshiBtn.setImage(UIImage(named: "教师风采"), forState: .Normal)
                self.jiaoshiBtn.addTarget(self, action: #selector(SchoolViewController.jiaoshifengcai), forControlEvents: .TouchUpInside)
                self.jiaoshiLabel.frame = CGRectMake(0, 66, 50, 12)
                self.jiaoshiLabel.font = UIFont.systemFontOfSize(12)
                self.jiaoshiLabel.center.x = self.view.bounds.width/8*3
                self.jiaoshiLabel.textAlignment = .Center
                self.jiaoshiLabel.text = "教师风采"
                self.xiaoyfcBtn.frame = CGRectMake(0, 3, 60, 60)
                self.xiaoyfcBtn.center.x = self.view.bounds.width/8*5
                self.xiaoyfcBtn.setImage(UIImage(named: "校园风采"), forState: .Normal)
                self.xiaoyfcBtn.addTarget(self, action: #selector(SchoolViewController.schoolFengCai), forControlEvents: .TouchUpInside)
                self.xiaoyfcLabel.frame = CGRectMake(0, 66, 50, 12)
                self.xiaoyfcLabel.text = "每日食谱"
                self.xiaoyfcLabel.center.x = self.view.bounds.width/8*5
                self.xiaoyfcLabel.font = UIFont.systemFontOfSize(12)
                self.xiaoyfcLabel.textAlignment = .Center
                self.bbxcBtn.frame = CGRectMake(0, 3, 60, 60)
                self.bbxcBtn.setImage(UIImage(named: "宝宝秀场"), forState: .Normal)
                self.bbxcBtn.addTarget(self, action: #selector(SchoolViewController.babyShows), forControlEvents: .TouchUpInside)
                self.bbxcBtn.center.x = self.view.bounds.width/8*7
                self.bbxcLabel.frame = CGRectMake(0, 66, 50, 12)
                self.bbxcLabel.text = "宝宝秀场"
                self.bbxcLabel.font = UIFont.systemFontOfSize(12)
                self.bbxcLabel.center.x = self.view.bounds.width/8*7
                self.bbxcLabel.textAlignment = .Center
                self.zhaopinBT.frame = CGRectMake(0, 103, 60, 60)
                self.zhaopinBT.center.x = self.view.bounds.width/8
                self.zhaopinBT.setImage(UIImage(named: "园区介绍"), forState: .Normal)
                self.zhaopinBT.addTarget(self, action: #selector(SchoolViewController.zhaopin), forControlEvents: .TouchUpInside)
                self.zhaopinL.frame = CGRectMake(0, 166, 50, 12)
                self.zhaopinL.font = UIFont.systemFontOfSize(12)
                self.zhaopinL.center.x = self.view.bounds.width/8
                self.zhaopinL.text = "校园招聘"
                self.zhaopinL.textAlignment = .Center
                self.xinxiangBT.frame = CGRectMake(0, 103, 60, 60)
                self.xinxiangBT.center.x = self.view.bounds.width/8*3
                self.xinxiangBT.setImage(UIImage(named: "教师风采"), forState: .Normal)
                self.xinxiangBT.addTarget(self, action: #selector(SchoolViewController.xinxiang), forControlEvents: .TouchUpInside)
                self.xinxiangL.frame = CGRectMake(0, 166, 50, 12)
                self.xinxiangL.font = UIFont.systemFontOfSize(12)
                self.xinxiangL.center.x = self.view.bounds.width/8*3
                self.xinxiangL.textAlignment = .Center
                self.xinxiangL.text = "园长信箱"
                self.xingquBT.frame = CGRectMake(0, 103, 60, 60)
                self.xingquBT.center.x = self.view.bounds.width/8*5
                self.xingquBT.setImage(UIImage(named: "校园风采"), forState: .Normal)
                self.xingquBT.addTarget(self, action: #selector(SchoolViewController.xingqu), forControlEvents: .TouchUpInside)
                self.xingquL.frame = CGRectMake(0, 166, 50, 12)
                self.xingquL.text = "兴趣班"
                self.xingquL.center.x = self.view.bounds.width/8*5
                self.xingquL.font = UIFont.systemFontOfSize(12)
                self.xingquL.textAlignment = .Center
                self.baomingBT.frame = CGRectMake(0, 103, 60, 60)
                self.baomingBT.setImage(UIImage(named: "宝宝秀场"), forState: .Normal)
                self.baomingBT.addTarget(self, action: #selector(SchoolViewController.baoming), forControlEvents: .TouchUpInside)
                self.baomingBT.center.x = self.view.bounds.width/8*7
                self.baomingL.frame = CGRectMake(0, 166, 50, 12)
                self.baomingL.text = "在线报名"
                self.baomingL.font = UIFont.systemFontOfSize(12)
                self.baomingL.center.x = self.view.bounds.width/8*7
                self.baomingL.textAlignment = .Center
                cell.contentView.addSubview(self.yuanquBtn)
                cell.contentView.addSubview(self.yuanquLabel)
                cell.contentView.addSubview(self.jiaoshiBtn)
                cell.contentView.addSubview(self.jiaoshiLabel)
                cell.contentView.addSubview(self.xiaoyfcBtn)
                cell.contentView.addSubview(self.xiaoyfcLabel)
                cell.contentView.addSubview(self.bbxcLabel)
                cell.contentView.addSubview(self.bbxcBtn)
                cell.contentView.addSubview(self.zhaopinBT)
                cell.contentView.addSubview(self.zhaopinL)
                cell.contentView.addSubview(self.xinxiangBT)
                cell.contentView.addSubview(self.xinxiangL)
                cell.contentView.addSubview(self.xingquBT)
                cell.contentView.addSubview(self.xingquL)
                cell.contentView.addSubview(self.baomingBT)
                cell.contentView.addSubview(self.baomingL)
                return cell
            }
        }
        //MARK: - 新闻动态列表
        if indexPath.section == 2{
            if indexPath.row == 0{
                cell.accessoryType = .DisclosureIndicator
                self.yqgg.frame = CGRectMake(10, 7, 15, 17)
                self.yqgg.image = UIImage(named: "学校官网_03")
                self.yqggLabel1.frame = CGRectMake(36, 9, 59, 13)
                self.yqggLabel1.font = UIFont.systemFontOfSize(14)
                self.yqggLabel1.text = "新闻动态"
                self.yqggLabel2.frame = CGRectMake(0, 8, 28, 14)
                self.yqggLabel2.text = "更多"
                self.yqggLabel2.frame.origin.x = self.view.bounds.width - 55
                self.yqggLabel2.font = UIFont.systemFontOfSize(14)
                self.yqggLabel2.textColor = UIColor.grayColor()
                cell.contentView.addSubview(self.yqggLabel2)
                cell.contentView.addSubview(self.yqggLabel1)
                cell.contentView.addSubview(self.yqgg)
                return cell
            }else{
                let newsinfo = schoolListSource.objectlist[indexPath.row-1]
                
                let cell = SchoolListCell.cellWithTableView(tableView)
                cell.iconIV.image=UIImage(named: "宝宝秀场")
                cell.titleL.text=newsinfo.post_title
                cell.contentL.text=newsinfo.post_excerpt
                cell.timeL.text=newsinfo.post_date
                return cell
            }
        }
        //MARK: - 校园通知cell
        if indexPath.section == 1{
            if indexPath.row == 0{
                cell.accessoryType = .DisclosureIndicator
                self.xwdt.frame = CGRectMake(10, 7, 15, 17)
                self.xwdt.image = UIImage(named: "学校官网_07")
                self.xwdtLabel1.frame = CGRectMake(36, 9, 59, 13)
                self.xwdtLabel1.font = UIFont.systemFontOfSize(14)
                self.xwdtLabel1.text = "校园通知"
                self.xwdtLabel2.frame = CGRectMake(0, 8, 28, 14)
                self.xwdtLabel2.text = "更多"
                self.xwdtLabel2.frame.origin.x = self.view.bounds.width - 55
                self.xwdtLabel2.font = UIFont.systemFontOfSize(14)
                self.xwdtLabel2.textColor = UIColor.grayColor()
                cell.contentView.addSubview(self.xwdtLabel1)
                cell.contentView.addSubview(self.xwdtLabel2)
                cell.contentView.addSubview(self.xwdt)
                return cell
            }else{
                let newsinfo = SchoolNoticesSource.objectlist[indexPath.row-1]
                
                let cell = SchoolListCell.cellWithTableView(tableView)
                cell.iconIV.image=UIImage(named: "宝宝秀场")
                cell.titleL.text=newsinfo.post_title
                cell.contentL.text=newsinfo.post_excerpt
                cell.timeL.text=newsinfo.post_date
                return cell            }
        }
        if indexPath.section == 3{
            if indexPath.row == 0{
                cell.accessoryType = .DisclosureIndicator
                self.yedt.frame = CGRectMake(10, 7, 15, 17)
                self.yedt.image = UIImage(named: "学校官网_07")
                self.yedtLabel1.frame = CGRectMake(36, 9, 59, 13)
                self.yedtLabel1.font = UIFont.systemFontOfSize(14)
                self.yedtLabel1.text = "育儿知识"
                self.yedtLabel2.frame = CGRectMake(self.view.bounds.width - 55, 8, 28, 14)
                self.yedtLabel2.text = "更多"
                self.yedtLabel2.font = UIFont.systemFontOfSize(14)
                self.yedtLabel2.textColor = UIColor.grayColor()
                cell.contentView.addSubview(self.yedtLabel1)
                cell.contentView.addSubview(self.yedtLabel2)
                cell.contentView.addSubview(self.yedt)
                return cell
            }
            if indexPath.row == 1{
                self.teacherPic2.frame = CGRectMake(5, 5, 80, 80)
                self.teacherPic2.image = UIImage(named: "teacherPic")
                cell.contentView.addSubview(self.teacherPic2)
                self.contentText2.frame = CGRectMake(88, 5, self.view.bounds.width - 90, 80)
                self.contentText1.numberOfLines = 0
                if self.yuErList.objectlist.count>0 {
                    self.contentText2.text = self.yuErList.objectlist[0].happy_title
                }
                
                self.contentText2.font = UIFont.systemFontOfSize(15)
                cell.contentView.addSubview(self.contentText2)
                return cell
            }
        }

        return cell
    }
  //MARK: - 点击事件
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //MARK: - 校园通知点击事件
        if indexPath.section == 1{
            if indexPath.row == 0{
                let xinwenlist = XinWenListViewController()
                self.navigationController?.pushViewController(xinwenlist, animated: true)
            }else{
                let newsinfo = SchoolNoticesSource.objectlist[indexPath.row-1]
                let xinweninfo = XinWenInfoViewController()
                xinweninfo.id=newsinfo.id!
                xinweninfo.ziduan="notice"
                self.navigationController?.pushViewController(xinweninfo, animated: true)
            }
        }
        //MARK: - 新闻动态点击事件
        if indexPath.section == 2{
            if indexPath.row == 0{
                let tonggaolist = TongGaoListViewController()
                self.navigationController?.pushViewController(tonggaolist, animated: true)
            }else{
                let newsinfo = schoolListSource.objectlist[indexPath.row-1]
                let xinweninfo = XinWenInfoViewController()
                xinweninfo.id=newsinfo.id!
                xinweninfo.ziduan="news"
                self.navigationController?.pushViewController(xinweninfo, animated: true)
                
              
            }
        }
        //MARK: - 育儿知识点击事件
        if indexPath.section == 3{
            if indexPath.row == 0{
                let yuErList = YuErListTableViewController()
                yuErList.yuErList = self.yuErList
                self.navigationController?.pushViewController(yuErList, animated: true)
            }
            if indexPath.row == 1{
                let yuErInfo = YuErInfoViewController()
                yuErInfo.yuErInfo = self.yuErList.objectlist.first!
                self.navigationController?.pushViewController(yuErInfo, animated: true)
            }
        }

    }
    //MARK: - 上方按钮点击事件
    func yuanquJieShao(){
        let yqjs = YuanquJieShaoViewController()
        self.navigationController?.pushViewController(yqjs, animated: true)
    }
    
    func jiaoshifengcai(){
        let jsfc = TeacherLIstViewController()
        self.navigationController?.pushViewController(jsfc, animated: true)
    }
    
    func schoolFengCai(){
        let jsfc = FoodMenuViewController()
        self.navigationController?.pushViewController(jsfc, animated: true)
    }
    
    func babyShows(){
        let jsfc = BBShowsViewController()
        self.navigationController?.pushViewController(jsfc, animated: true)
    }
    func zhaopin(){
        let vc = ZhaoPinViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    func xinxiang(){
        let vc = XinXiangViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    func xingqu(){
        let vc = XingQuViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    func baoming(){
        
    }
}
