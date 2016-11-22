
//
//  FunctionViewController.swift
//  WXT_Teachers
//
//  Created by 李春波 on 16/2/23.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
class FunctionViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{

    let avatorImage = UIImageView()
    let nameLabel = UILabel()
    let schoolLabel = UILabel()
    let addressLabel = UILabel()
    let chooseBtn = UIButton()
    
    let funTableView = UITableView()
    let paiMingImage = UIImageView()
    let jiFenImage = UIImageView()
    let dengJiImage = UIImageView()
    let paiMing = UILabel()
    let jiFen = UILabel()
    let dengJi = UILabel()
    let paiMingLabel = UILabel()
    let jiFenLabel = UILabel()
    let dengJiLabel = UILabel()
    let xiaoZhuShou = UIImageView()
    let xiaoZhuShouLabel = UILabel()
    let baobaoLeYuan = UIImageView()
    let baobaoLeYuanLabel = UILabel()
    let baobaoLeYuanContent = UILabel()
    let baobaoLeYuanImage = UIImageView()
    let baobaoShiPin = UIImageView()
    let baobaoShiPinLabel = UILabel()
    let baobaoShiPinBtn1 = UIButton()
    let baobaoShiPinBtn2 = UIButton()
    let baobaoShiPinContent1 = UILabel()
    let baobaoShiPinContent2 = UILabel()
    let fangDiu = UIImageView()
    let fangDiuLabel = UILabel()
    let fangDiuContent = UILabel()
    let scrolView = UIScrollView()
    let pageControl = UIPageControl()
    let btn1 = UIButton()
    let btn2 = UIButton()
    let btn3 = UIButton()
    let btn4 = UIButton()
    let btn5 = UIButton()
    let btn6 = UIButton()
    let btn7 = UIButton()
    let btn8 = UIButton()
    let btn9 = UIButton()
    let btn10 = UIButton()
    let btn11 = UIButton()
    let btn12 = UIButton()
    let btn13 = UIButton()
    let btn14 = UIButton()
    let btn15 = UIButton()
    let btn16 = UIButton()
    let lab1 = UILabel()
    let lab2 = UILabel()
    let lab3 = UILabel()
    let lab4 = UILabel()
    let lab5 = UILabel()
    let lab6 = UILabel()
    let lab7 = UILabel()
    let lab8 = UILabel()
    let lab9 = UILabel()
    let lab10 = UILabel()
    let lab11 = UILabel()
    let lab12 = UILabel()
    let lab13 = UILabel()
    let lab14 = UILabel()
    let lab15 = UILabel()
    let lab16 = UILabel()
    var count1 = String()
    var count2 = String()
    var count3 = String()
    var count4 = String()
    var deliveryL = UILabel()
    var leaveL = UILabel()
    var activityL = UILabel()
    var commentL = UILabel()
    
    //班级选择
    let chooseClassBtn = UIButton()
    var classDataSource = ClassInfoList()
    
    let chooseClassScrollView = UIScrollView()
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "功能"
        funTableView.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height - 44 - 64)
        funTableView.delegate = self
        funTableView.dataSource = self
        funTableView.registerClass(FunTableViewCell.self, forCellReuseIdentifier: "FunCell")
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(funTableView)

         NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.gameOver(_:)), name: "push", object: nil)
        
        loadClassData()
        funTableView.reloadData()
        
        createAlertChooseClassView()
        
    }
    
    //班级切换
    
    func loadClassData(){
        //http://wxt.xiaocool.net/index.php?g=apps&m=teacher&a=getteacherclasslist&teacherid=605
        let defalutid = NSUserDefaults.standardUserDefaults()
        let chid = defalutid.stringForKey("userid")
        
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=teacher&a=getteacherclasslist&teacherid="
        let param = [
            "teacherid":chid!,
            ]
        Alamofire.request(.GET, url, parameters: param).response { request, response, json, error in
            if(error != nil){
                
            }else{
                let status = Http(JSONDecoder(json!))
                if(status.status == "error"){
                    let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                    hud.mode = MBProgressHUDMode.Text
                    hud.labelText = status.errorData
                    hud.margin = 10.0
                    hud.removeFromSuperViewOnHide = true
                    hud.hide(true, afterDelay: 1)
                }
                if(status.status == "success"){
                    self.classDataSource.objectlist.removeAll()
                    self.classDataSource = ClassInfoList(status.data!)
                    
                    if self.classDataSource.objectlist.count > 0{
                        self.schoolLabel.text = self.classDataSource.objectlist.first?.classname
                    }
                    
                    
                    for index in 0..<self.classDataSource.objectlist.count{
                        
                        let button = UIButton()
                        
                        button.frame = CGRectMake(0, CGFloat(index) + CGFloat(index) * CGFloat(40), frame.width, 40)
                        button.setTitle(self.classDataSource.objectlist[index].classname, forState: UIControlState.Normal)
                        button .setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
                        button.tag = index
                        button.addTarget(self, action: #selector(self.chooseBtnClicked(_:
                            )), forControlEvents: UIControlEvents.TouchUpInside)
                        self.chooseClassScrollView.addSubview(button)
                        
                    }
                    self.chooseClassScrollView.contentSize = CGSizeMake(0, CGFloat(self.classDataSource.objectlist.count * 40))
                    
                    
                }
            }
        }
    }

    func gameOver(title:NSNotification){
        let message = title.object!.valueForKey("type") as! String
        if message == "leave"{
            let vc = QingJiaViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if message == "deliery"{
            let vc = DJViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if message == "activity"{
            let vc = BanJihuodongViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if message == "comment"{
            let vc = TeacherDianPingViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
 
    } 
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = false
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.game(_:)), name: "deliveryAry", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.game2(_:)), name: "leaveArr", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.game3(_:)), name: "activityArr", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.game4(_:)), name: "commentArr", object: nil)
        let chid = NSUserDefaults.standardUserDefaults()
        if chid.valueForKey("deliveryAry") != nil {
            
            let arr = chid.valueForKey("deliveryAry") as! NSArray
            deliveryL.text = String(arr.count)
            deliveryL.hidden=false
        }else{
            deliveryL.removeFromSuperview()
        }
        if deliveryL.text == "0" {
            deliveryL.removeFromSuperview()
        }
        if chid.valueForKey("leaveArr") != nil {
            
            let arr = chid.valueForKey("leaveArr") as! NSArray
            leaveL.text = String(arr.count)
            leaveL.hidden=false
            
        }else{
            leaveL.removeFromSuperview()
        }
        if leaveL.text == "0" {
            leaveL.removeFromSuperview()
        }
        if chid.valueForKey("activityArr") != nil {
            
            let arr = chid.valueForKey("activityArr") as! NSArray
            activityL.text = String(arr.count)
        }else{
            activityL.removeFromSuperview()
        }
        if activityL.text == "0" {
            activityL.removeFromSuperview()
        }
        if chid.valueForKey("commentArr") != nil {
            
            let arr = chid.valueForKey("commentArr") as! NSArray
            commentL.text = String(arr.count)
        }else{
            commentL.removeFromSuperview()
        }
        if commentL.text == "0" {
            commentL.removeFromSuperview()
        }
        

    }
    func game(count:NSNotification){
        let arr = count.object as! NSArray
        deliveryL.text = String(arr.count)
        deliveryL.textAlignment = .Center
        deliveryL.textColor=UIColor.whiteColor()
        if deliveryL.text != "0" {
           btn4.addSubview(deliveryL)
        }
        
        
    }
    func game2(count:NSNotification){
        let arr = count.object as! NSArray
        leaveL.text = String(arr.count)
        leaveL.textAlignment = .Center
        leaveL.textColor=UIColor.whiteColor()
        if leaveL.text != "0" {
            btn5.addSubview(leaveL)
        }
    }
    func game3(count:NSNotification){
        let arr = count.object as! NSArray
        activityL.text = String(arr.count)
        activityL.textAlignment = .Center
        activityL.textColor = UIColor.whiteColor()
        if activityL.text != "0" {
            btn15.addSubview(activityL)
        }
    }
    func game4(count:NSNotification){
        let arr = count.object as! NSArray
        commentL.text = String(arr.count)
        commentL.textAlignment = .Center
        commentL.textColor = UIColor.whiteColor()
        if commentL.text != "0" {
            btn9.addSubview(commentL)
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return 1
        }
        if(section == 1){
            return 1
        }
        if(section == 2){
            return 2
        }
        if(section == 3){
            return 3
        }
        if(section == 4){
            return 1
        }
        return 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.section == 0){
            return 150
        }
        if(indexPath.section == 1){
            return 68
        }
        if(indexPath.section == 2){
            if(indexPath.row == 0){
                return 34
            }
            if(indexPath.row == 1){
                return 181
            }
        }
        if(indexPath.section == 3){
            if(indexPath.row == 0){
                return 34
            }
            if(indexPath.row == 1){
                return 135
            }
            if(indexPath.row == 2){
                return 40
            }
        }
        if(indexPath.section == 4){
            return 68
        }
        return 0
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let user = NSUserDefaults.standardUserDefaults()
        let cell = UITableViewCell(style:.Value1, reuseIdentifier:"userInfoCell")
        if(indexPath.section == 0){
            let cell = UITableViewCell(style:.Value1, reuseIdentifier:"userInfoCell")
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            avatorImage.frame = CGRectMake(15, 60, 80, 80)
            avatorImage.layer.cornerRadius = 40
            avatorImage.layer.masksToBounds = true
            let bt = UIButton(frame: CGRectMake(15, 60, 80, 80))
            bt.addTarget(self, action: #selector(changeInfo), forControlEvents: .TouchUpInside)
            
            let photo = user.stringForKey("photo")
            print(user.stringForKey("userid"))
            let url = imageUrl+photo!
            avatorImage.yy_setImageWithURL(NSURL(string: url), placeholder: UIImage(named: "Logo"))
            
            nameLabel.frame = CGRectMake(100, 85, 100, 20)
            nameLabel.font = UIFont.systemFontOfSize(16)
            nameLabel.textColor = UIColor(red: 54.0 / 255.0, green: 190.0 / 255.0, blue: 100.0 / 255.0, alpha: 1.0)
            
            let username = user.stringForKey("username")
            nameLabel.text = username
            schoolLabel.frame = CGRectMake(100, 105, 60, 15)
            schoolLabel.font = UIFont.systemFontOfSize(13)
            schoolLabel.textColor = UIColor.grayColor()
            let school_name = user.stringForKey("school_name")
            addressLabel.frame = CGRectMake(180, 105, 160, 15)
            addressLabel.text=school_name
            addressLabel.font = UIFont.systemFontOfSize(13)
            addressLabel.textColor = UIColor.grayColor()
            chooseBtn.frame = CGRectMake(140, 95, 30, 30)
            chooseBtn.setImage(UIImage(named: "qh.png"), forState: UIControlState.Normal)
            //班级选择按钮
            chooseClassBtn.frame = CGRectMake(CGRectGetMinX(schoolLabel.frame), CGRectGetMinY(nameLabel.frame), 300, 50)
            chooseClassBtn.addTarget(self, action: #selector(FunctionViewController.chooseClassBtnClicked), forControlEvents: .TouchUpInside)
            cell.contentView.addSubview(avatorImage)
            cell.contentView.addSubview(bt)
            cell.contentView.addSubview(nameLabel)
            cell.contentView.addSubview(schoolLabel)
            cell.contentView.addSubview(addressLabel)
            cell.contentView.addSubview(chooseBtn)
            cell.contentView.addSubview(chooseClassBtn)
            
            return cell
        }
        if(indexPath.section == 1){
            let cell = UITableViewCell(style:.Value1, reuseIdentifier:"userJiFenCell")
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            paiMingImage.frame = CGRectMake(0, 12, 40, 40)
            paiMingImage.layer.cornerRadius = 20
            paiMingImage.layer.masksToBounds = true
            paiMingImage.image = UIImage(named: "排名")
            paiMingImage.center.x = self.view.bounds.width/9
            paiMing.frame = CGRectMake(0, 29, 30, 11)
            paiMing.font = UIFont.systemFontOfSize(13)
            paiMing.text = "排名"
            paiMing.center.x = (self.view.bounds.width/9)*2
            paiMingLabel.frame = CGRectMake(0, 27, 25, 13)
            paiMingLabel.font = UIFont.systemFontOfSize(18)
            paiMingLabel.textColor = UIColor(red: 203.0 / 255.0, green: 225.0 / 255.0, blue: 139.0 / 255.0, alpha: 1.0)
//            paiMingLabel.text = "13"
            paiMingLabel.frame.origin.x = (self.view.bounds.width/9)*2 + 10
            jiFenImage.frame = CGRectMake(0, 12, 40, 40)
            jiFenImage.layer.cornerRadius = 20
            jiFenImage.layer.masksToBounds = true
            jiFenImage.image = UIImage(named: "积分")
            jiFenImage.center.x = (self.view.bounds.width/9)*4
            jiFen.frame = CGRectMake(0, 29, 30, 11)
            jiFen.font = UIFont.systemFontOfSize(13)
            jiFen.text = "积分"
            jiFen.center.x = (self.view.bounds.width/9)*5
            jiFenLabel.frame = CGRectMake(0, 27, 35, 13)
            jiFenLabel.font = UIFont.systemFontOfSize(18)
//            jiFenLabel.text = "23"
            jiFenLabel.frame.origin.x = (self.view.bounds.width/9)*5 + 10
            jiFenLabel.textColor = UIColor(red: 175.0 / 255.0, green: 216.0 / 255.0, blue: 246.0 / 255.0, alpha: 1.0)
            dengJiImage.frame = CGRectMake(0, 12, 40, 40)
            dengJiImage.image = UIImage(named: "等级")
            dengJiImage.layer.cornerRadius = 20
            dengJiImage.layer.masksToBounds = true
            dengJiImage.center.x = (self.view.bounds.width/9)*7
            dengJi.frame = CGRectMake(0, 29, 30, 11)
            dengJi.font = UIFont.systemFontOfSize(13)
            dengJi.text = "等级"
            dengJi.center.x = (self.view.bounds.width/9)*8
            dengJiLabel.frame = CGRectMake(0, 27, 35, 13)
            dengJiLabel.font = UIFont.systemFontOfSize(18)
//            dengJiLabel.text = "11"
            dengJiLabel.textColor = UIColor(red: 234.0 / 255.0, green: 200.0 / 255.0, blue: 84.0 / 255.0, alpha: 1.0)
            dengJiLabel.frame.origin.x = (self.view.bounds.width/9)*8 + 10
            cell.contentView.addSubview(paiMingLabel)
            cell.contentView.addSubview(paiMing)
            cell.contentView.addSubview(paiMingImage)
            cell.contentView.addSubview(jiFenImage)
            cell.contentView.addSubview(jiFen)
            cell.contentView.addSubview(jiFenLabel)
            cell.contentView.addSubview(dengJiImage)
            cell.contentView.addSubview(dengJi)
            cell.contentView.addSubview(dengJiLabel)
            return cell
        }
        if(indexPath.section == 2){
            if indexPath.row == 0{
                let cell = UITableViewCell(style: .Value1, reuseIdentifier: "xiaozhushou")
                cell.selectionStyle = UITableViewCellSelectionStyle.None
                xiaoZhuShou.frame = CGRectMake(11, 13, 14, 14)
                xiaoZhuShou.image = UIImage(named: "小助手")
                xiaoZhuShouLabel.frame = CGRectMake(31, 13, 42, 13)
                xiaoZhuShouLabel.font = UIFont.systemFontOfSize(14)
                xiaoZhuShouLabel.text = "小助手"
                cell.contentView.addSubview(xiaoZhuShouLabel)	
                cell.contentView.addSubview(xiaoZhuShou)
                return cell
            }
            if indexPath.row == 1{
                let cell = UITableViewCell(style: .Value1, reuseIdentifier: "xiaozhushou")
                let viewWidth = self.view.bounds.width
                scrolView.frame = CGRectMake(0, 0, self.view.bounds.width, 181)
                scrolView.pagingEnabled = true
                scrolView.showsHorizontalScrollIndicator = false
                scrolView.showsVerticalScrollIndicator = false
                scrolView.scrollsToTop = false
                scrolView.bounces = false
                scrolView.contentOffset = CGPointZero
                scrolView.contentSize = CGSize(width: scrolView.frame .size.width * CGFloat(2), height: scrolView.frame.size.height)
                scrolView.delegate = self
                btn1.frame = CGRectMake(0, 16, 44, 44)
                btn1.layer.cornerRadius = 22
                btn1.layer.masksToBounds = true
                btn1.setBackgroundImage(UIImage(named: "学校官网"), forState: UIControlState.Normal)
                btn1.center.x = viewWidth/8
                btn1.addTarget(self, action: #selector(FunctionViewController.SchoolView), forControlEvents: .TouchUpInside)
                btn2.frame = CGRectMake(0, 16, 44, 44)
                btn2.layer.cornerRadius = 22
                btn2.layer.masksToBounds = true
                btn2.setBackgroundImage(UIImage(named: "宝宝相册"), forState: UIControlState.Normal)
                btn2.center.x = (viewWidth/8)*3
                btn2.addTarget(self, action: #selector(FunctionViewController.PhotoView), forControlEvents: .TouchUpInside)
                btn3.frame = CGRectMake(0, 16, 44, 44)
                btn3.layer.cornerRadius = 22
                btn3.layer.masksToBounds = true
                btn3.setBackgroundImage(UIImage(named: "成长档案"), forState: UIControlState.Normal)
                btn3.center.x = (viewWidth/8)*5
                btn3.addTarget(self, action: #selector(FunctionViewController.ChengZhangView), forControlEvents: .TouchUpInside)
                btn4.frame = CGRectMake(0, 16, 44, 44)
//                btn4.layer.cornerRadius = 22
//                btn4.layer.masksToBounds = true
                btn4.setBackgroundImage(UIImage(named: "代接确认"), forState: UIControlState.Normal)
                btn4.center.x = (viewWidth/8)*7
                btn4.addTarget(self, action: #selector(FunctionViewController.DaiJieView), forControlEvents: .TouchUpInside)
                deliveryL.frame=CGRectMake(44-18, 0, 18, 18)
                deliveryL.backgroundColor=UIColor.redColor()
                deliveryL.layer.masksToBounds=true
                deliveryL.layer.cornerRadius=9
                
                btn5.frame = CGRectMake(0, 100, 44, 44)
//                btn5.layer.cornerRadius = 22
//                btn5.layer.masksToBounds = true
                btn5.setBackgroundImage(UIImage(named: "在线请假"), forState: UIControlState.Normal)
                btn5.center.x = (viewWidth/8)
                btn5.addTarget(self, action: #selector(FunctionViewController.QingJiaView), forControlEvents: .TouchUpInside)
                leaveL.frame=CGRectMake(44-18, 0, 18, 18)
                leaveL.backgroundColor=UIColor.redColor()
                leaveL.layer.masksToBounds=true
                leaveL.layer.cornerRadius=9
                
                btn6.frame = CGRectMake(0, 100, 44, 44)
                btn6.layer.cornerRadius = 22
                btn6.layer.masksToBounds = true
                btn6.setBackgroundImage(UIImage(named: "家长叮嘱"), forState: UIControlState.Normal)
                btn6.center.x = (viewWidth/8)*3
                btn6.addTarget(self, action: #selector(FunctionViewController.DingzhuView), forControlEvents: .TouchUpInside)
                btn7.frame = CGRectMake(0, 100, 44, 44)
                btn7.layer.cornerRadius = 22
                btn7.layer.masksToBounds = true
                btn7.setBackgroundImage(UIImage(named: "食谱"), forState: UIControlState.Normal)
                btn7.center.x = (viewWidth/8)*5
                btn7.addTarget(self, action: #selector(FunctionViewController.ShiPuView), forControlEvents: .TouchUpInside)
                btn8.frame = CGRectMake(0, 100, 44, 44)
                btn8.layer.cornerRadius = 22
                btn8.layer.masksToBounds = true
                btn8.setBackgroundImage(UIImage(named: "班级考勤"), forState: UIControlState.Normal)
                btn8.center.x = (viewWidth/8)*7
                btn8.addTarget(self, action: #selector(FunctionViewController.KaoQinView), forControlEvents: .TouchUpInside)
                btn9.frame = CGRectMake(0, 16, 44, 44)
//                btn9.layer.cornerRadius = 22
//                btn9.layer.masksToBounds = true
                btn9.setBackgroundImage(UIImage(named: "老师点评"), forState: UIControlState.Normal)
                btn9.center.x = (viewWidth/8)*9
                btn9.addTarget(self, action: #selector(FunctionViewController.TeacherDPView), forControlEvents: .TouchUpInside)
                commentL.frame=CGRectMake(44-18, 0, 18, 18)
                commentL.backgroundColor=UIColor.redColor()
                commentL.layer.masksToBounds=true
                commentL.layer.cornerRadius=9
                
                btn10.frame = CGRectMake(0, 16, 44, 44)
                btn10.layer.cornerRadius = 22
                btn10.layer.masksToBounds = true
                btn10.setBackgroundImage(UIImage(named: "老师考勤"), forState: UIControlState.Normal)
                btn10.center.x = (viewWidth/8)*11
                btn10.addTarget(self, action: #selector(FunctionViewController.daKaView), forControlEvents: .TouchUpInside)
                btn11.frame = CGRectMake(0, 16, 44, 44)
                btn11.layer.cornerRadius = 22
                btn11.layer.masksToBounds = true
                btn11.setBackgroundImage(UIImage(named: "周计划"), forState: UIControlState.Normal)
                btn11.center.x = (viewWidth/8)*13
                btn11.addTarget(self, action: #selector(FunctionViewController.ZhouPlanView), forControlEvents: .TouchUpInside)
                btn12.frame = CGRectMake(0, 16, 44, 44)
                btn12.layer.cornerRadius = 22
                btn12.layer.masksToBounds = true
                btn12.setBackgroundImage(UIImage(named: "信息审核"), forState: UIControlState.Normal)
                btn12.center.x = (viewWidth/8)*15
                btn12.addTarget(self, action: #selector(FunctionViewController.XinxiView), forControlEvents: .TouchUpInside)
                btn13.frame = CGRectMake(0, 100, 44, 44)
                btn13.layer.cornerRadius = 22
                btn13.layer.masksToBounds = true
                btn13.setBackgroundImage(UIImage(named: "宝宝课件"), forState: UIControlState.Normal)
                btn13.center.x = (viewWidth/8)*9
                btn13.addTarget(self, action: #selector(FunctionViewController.KeJianView), forControlEvents: .TouchUpInside)
                btn14.frame = CGRectMake(0, 100, 44, 44)
                btn14.layer.cornerRadius = 22
                btn14.layer.masksToBounds = true
                btn14.setBackgroundImage(UIImage(named: "成长档案"), forState: UIControlState.Normal)
                btn14.center.x = (viewWidth/8)*11
                btn14.addTarget(self, action: #selector(FunctionViewController.BBkeChengView), forControlEvents: .TouchUpInside)
                btn15.frame = CGRectMake(0, 100, 44, 44)
//                btn15.layer.cornerRadius = 22
//                btn15.layer.masksToBounds = true
                btn15.setBackgroundImage(UIImage(named: "班级活动"), forState: UIControlState.Normal)
                btn15.center.x = (viewWidth/8)*13
                btn15.addTarget(self, action: #selector(FunctionViewController.huoDongView), forControlEvents: .TouchUpInside)
                activityL.frame=CGRectMake(44-18, 0, 18, 18)
                activityL.backgroundColor=UIColor.redColor()
                activityL.layer.masksToBounds=true
                activityL.layer.cornerRadius=9
                
                btn16.frame = CGRectMake(0, 100, 44, 44)
                btn16.layer.cornerRadius = 22
                btn16.layer.masksToBounds = true
                btn16.setBackgroundImage(UIImage(named: "园所情况"), forState: UIControlState.Normal)
                btn16.center.x = (viewWidth/8)*15
                btn16.addTarget(self, action: #selector(FunctionViewController.QingKuang), forControlEvents: .TouchUpInside)
                lab1.text = "学校官网"
                lab1.frame = CGRectMake(0, 66, 55, 15)
                lab1.center.x = (viewWidth/8)
                lab1.font = UIFont.systemFontOfSize(13)
                lab1.textAlignment = .Center
                lab2.text = "班级相册"
                lab2.frame = CGRectMake(0, 66, 55, 15)
                lab2.center.x = (viewWidth/8)*3
                lab2.font = UIFont.systemFontOfSize(13)
                lab2.textAlignment = .Center
                lab3.text = "成长档案"
                lab3.frame = CGRectMake(0, 66, 55, 15)
                lab3.center.x = (viewWidth/8)*5
                lab3.font = UIFont.systemFontOfSize(13)
                lab3.textAlignment = .Center
                lab4.text = "代接确认"
                lab4.frame = CGRectMake(0, 66, 55, 15)
                lab4.center.x = (viewWidth/8)*7
                lab4.font = UIFont.systemFontOfSize(13)
                lab4.textAlignment = .Center
                lab5.text = "在线请假"
                lab5.frame = CGRectMake(0, 150, 55, 15)
                lab5.center.x = (viewWidth/8)
                lab5.font = UIFont.systemFontOfSize(13)
                lab5.textAlignment = .Center
                lab6.text = "家长叮嘱"
                lab6.frame = CGRectMake(0, 150, 55, 15)
                lab6.center.x = (viewWidth/8)*3
                lab6.font = UIFont.systemFontOfSize(13)
                lab6.textAlignment = .Center
                lab7.text = "食谱"
                lab7.frame = CGRectMake(0, 150, 55, 15)
                lab7.center.x = (viewWidth/8)*5
                lab7.font = UIFont.systemFontOfSize(13)
                lab7.textAlignment = .Center
                lab8.text = "考勤"
                lab8.frame = CGRectMake(0, 150, 55, 15)
                lab8.center.x = (viewWidth/8)*7
                lab8.font = UIFont.systemFontOfSize(13)
                lab8.textAlignment = .Center
                lab9.text = "老师点评"
                lab9.frame = CGRectMake(0, 66, 55, 15)
                lab9.center.x = (viewWidth/8)*9
                lab9.font = UIFont.systemFontOfSize(13)
                lab9.textAlignment = .Center
                lab10.text = "老师考勤"
                lab10.frame = CGRectMake(0, 66, 55, 15)
                lab10.center.x = (viewWidth/8)*11
                lab10.font = UIFont.systemFontOfSize(13)
                lab10.textAlignment = .Center
                lab11.text = "周计划"
                lab11.frame = CGRectMake(0, 66, 55, 15)
                lab11.center.x = (viewWidth/8)*13
                lab11.font = UIFont.systemFontOfSize(13)
                lab11.textAlignment = .Center
                lab12.text = "信息审核"
                lab12.frame = CGRectMake(0, 66, 55, 15)
                lab12.center.x = (viewWidth/8)*15
                lab12.font = UIFont.systemFontOfSize(13)
                lab12.textAlignment = .Center
                lab13.text = "宝宝课件"
                lab13.frame = CGRectMake(0, 150, 55, 15)
                lab13.center.x = (viewWidth/8)*9
                lab13.font = UIFont.systemFontOfSize(13)
                lab13.textAlignment = .Center
                lab14.text = "班级课程"
                lab14.frame = CGRectMake(0, 150, 55, 15)
                lab14.center.x = (viewWidth/8)*11
                lab14.font = UIFont.systemFontOfSize(13)
                lab14.textAlignment = .Center
                lab15.text = "班级活动"
                lab15.frame = CGRectMake(0, 150, 55, 15)
                lab15.center.x = (viewWidth/8)*13
                lab15.font = UIFont.systemFontOfSize(13)
                lab15.textAlignment = .Center
                lab16.text = "园所情况"
                lab16.frame = CGRectMake(0, 150, 55, 15)
                lab16.center.x = (viewWidth/8)*15
                lab16.font = UIFont.systemFontOfSize(13)
                lab16.textAlignment = .Center
                scrolView.addSubview(btn1)
                scrolView.addSubview(btn2)
                scrolView.addSubview(btn3)
                scrolView.addSubview(btn4)
                scrolView.addSubview(btn5)
                scrolView.addSubview(btn6)
                scrolView.addSubview(btn7)
                scrolView.addSubview(btn8)
                scrolView.addSubview(btn9)
                scrolView.addSubview(btn10)
                scrolView.addSubview(btn11)
                scrolView.addSubview(btn12)
                scrolView.addSubview(btn13)
                scrolView.addSubview(btn14)
                scrolView.addSubview(btn15)
                scrolView.addSubview(btn16)
                scrolView.addSubview(lab1)
                scrolView.addSubview(lab2)
                scrolView.addSubview(lab3)
                scrolView.addSubview(lab4)
                scrolView.addSubview(lab5)
                scrolView.addSubview(lab6)
                scrolView.addSubview(lab7)
                scrolView.addSubview(lab8)
                scrolView.addSubview(lab9)
                scrolView.addSubview(lab10)
                scrolView.addSubview(lab11)
                scrolView.addSubview(lab12)
                scrolView.addSubview(lab13)
                scrolView.addSubview(lab14)
                scrolView.addSubview(lab15)
                scrolView.addSubview(lab16)
                pageControl.frame = CGRectMake(0, 170, 10, 8)
                pageControl.center.x = cell.center.x
                pageControl.currentPageIndicatorTintColor = UIColor(red: 54.0 / 255.0, green: 190.0 / 255.0, blue: 100.0 / 255.0, alpha: 1.0)
                pageControl.pageIndicatorTintColor = UIColor.grayColor()
                pageControl.numberOfPages = 2
                cell.contentView.addSubview(scrolView)
                cell.contentView.addSubview(pageControl)
                return cell
            }
        }
        
        if(indexPath.section == 3){
            if(indexPath.row == 0){
                let cell = UITableViewCell(style: .Value1, reuseIdentifier: "baobaoShiPin")
                cell.selectionStyle = .None
                cell.accessoryType = .DisclosureIndicator
                baobaoShiPin.frame = CGRectMake(11, 13, 14, 14)
                baobaoShiPin.image = UIImage(named: "宝宝视频")
                baobaoShiPinLabel.frame = CGRectMake(31, 13, 60, 13)
                baobaoShiPinLabel.font = UIFont.systemFontOfSize(14)
                baobaoShiPinLabel.text = "宝宝视频"
                cell.contentView.addSubview(baobaoShiPinLabel)
                cell.contentView.addSubview(baobaoShiPin)
                return cell
            }
            if(indexPath.row == 1){
                let cell = UITableViewCell(style: .Value1, reuseIdentifier: "baobaoShiPin")
                cell.selectionStyle = .None
                baobaoShiPinBtn1.frame = CGRectMake(8, 3, self.view.bounds.width/2 - 10, 126)
                baobaoShiPinBtn1.setImage(UIImage(named: "宝宝监控"), forState: UIControlState.Normal)
                baobaoShiPinBtn2.frame = CGRectMake(self.view.bounds.width/2 + 2, 3, self.view.bounds.width/2 - 10, 126)
                baobaoShiPinBtn2.setImage(UIImage(named: "宝宝监控"), forState: UIControlState.Normal)
                cell.contentView.addSubview(baobaoShiPinBtn2)
                cell.contentView.addSubview(baobaoShiPinBtn1)
                return cell
            }
            if(indexPath.row == 2){
                let cell = UITableViewCell(style: .Value1, reuseIdentifier: "baobaoShiPin")
                cell.selectionStyle = .None
                baobaoShiPinContent1.frame = CGRectMake(8, 3, self.view.bounds.width, 30)
                baobaoShiPinContent1.textColor = UIColor.grayColor()
                baobaoShiPinContent1.text = "更新于2015-10-12日 10:00"
                baobaoShiPinContent1.font = UIFont.systemFontOfSize(14)
                baobaoShiPinContent1.numberOfLines = 0
                cell.contentView.addSubview(baobaoShiPinContent1)
                return cell
            }
        }
        if(indexPath.section == 4){
            fangDiu.frame = CGRectMake(9, 11, 38, 38)
            fangDiu.layer.cornerRadius = 19
            fangDiu.layer.masksToBounds = true
            fangDiu.image = UIImage(named: "定位")
            fangDiuLabel.frame = CGRectMake(56, 13, 60, 14)
            fangDiuLabel.font = UIFont.systemFontOfSize(14)
            fangDiuLabel.text = "防丢定位"
            fangDiuContent.frame = CGRectMake(56, 36, 107, 12)
            fangDiuContent.text = "显示宝宝当前位置"
            fangDiuContent.font = UIFont.systemFontOfSize(12)
            fangDiuContent.textColor = UIColor.grayColor()
            cell.selectionStyle = .None
            cell.contentView.addSubview(fangDiuContent)
            cell.contentView.addSubview(fangDiu)
            cell.contentView.addSubview(fangDiuLabel)
            return cell
        }

        return cell
    }
   
    
    func SchoolView(){
        let school = SchoolViewController()
        self.navigationController?.pushViewController(school, animated: true)
    }
    @objc private func chooseClassBtnClicked(){
       
        
        if chooseClassScrollView.hidden == true {
            chooseClassScrollView.hidden = false
        }else {
            chooseClassScrollView.hidden = true

        }
        
    }
    @objc private func chooseBtnClicked(sender: UIButton?){
        schoolLabel.text = self.classDataSource.objectlist[(sender?.tag)!].classname
        chooseClassScrollView.hidden = true
        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.mode = MBProgressHUDMode.Text
        hud.labelText = "切换成功！"
        hud.margin = 10.0
        hud.removeFromSuperViewOnHide = true
        hud.hide(true, afterDelay: 1)

    }
    private func createAlertChooseClassView(){
        chooseClassScrollView.frame=CGRectMake(0,120, frame.width, 40)
        chooseClassScrollView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        chooseClassScrollView.hidden = true
        self.view.addSubview(chooseClassScrollView)

    }
    func DaiJieView(){
        let DaiJie = DJViewController()
        self.navigationController?.pushViewController(DaiJie, animated: true)
    }
    
    func PhotoView(){
        let Photo = PhotoViewController()
        self.navigationController?.pushViewController(Photo, animated: true)
    }
    
    func ChengZhangView(){
        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.mode = MBProgressHUDMode.Text
        hud.labelText = "功能暂未实现，敬请期待"
        hud.margin = 10.0
        hud.removeFromSuperViewOnHide = true
        hud.hide(true, afterDelay: 1)
//        let ChengZhang = ChengZhangViewController()
//        self.navigationController?.pushViewController(ChengZhang, animated: true)
    }
    
    func QingJiaView(){
        let QingJia = QingJiaViewController()
        self.navigationController?.pushViewController(QingJia, animated: true)
    }
    
    func TeacherDPView(){
        let tecDianPing = TeacherDianPingViewController()
        self.navigationController?.pushViewController(tecDianPing, animated: true)
    }
    
    func KaoQinView(){
        let kaoqin = ClassKaoqinViewController()
        self.navigationController?.pushViewController(kaoqin, animated: true)
    }
    
    func ShiPuView(){
        let shipu = FoodMenuViewController()
        self.navigationController?.pushViewController(shipu, animated: true)
    }
    
    func KeJianView(){
        let banJikejian = BanJiKeJianViewController()
        self.navigationController?.pushViewController(banJikejian, animated: true)
    }
    
    func ZhouPlanView(){
        let zhouPlan = ZhouPlanViewController()
        self.navigationController?.pushViewController(zhouPlan, animated: true)
    }
    
    func BBkeChengView(){
        let bbkc = ClassScheduleTableViewController()
        self.navigationController?.pushViewController(bbkc, animated: true)
    }
    
    func huoDongView(){
        let bjhd = BanJihuodongViewController()
        self.navigationController?.pushViewController(bjhd, animated: true)
    }
    
    func DingzhuView(){
   
    }
    
    func XinxiView(){
        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.mode = MBProgressHUDMode.Text
        hud.labelText = "功能暂未实现，敬请期待"
        hud.margin = 10.0
        hud.removeFromSuperViewOnHide = true
        hud.hide(true, afterDelay: 1)
//        let xinxi = XinXiViewController()
//        self.navigationController?.pushViewController(xinxi, animated: true)
    }
    
    func daKaView(){
        let daka = KaoQinViewController()
        self.navigationController?.pushViewController(daka, animated: true)
    }
    
    func QingKuang(){
        let qingkuang = YSQingKuangViewController()
        self.navigationController?.pushViewController(qingkuang, animated: true)
        
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
        if (indexPath.section == 3) {
            if (indexPath.row == 0) {
                
                let videos = VideosViewController()
                self.navigationController?.pushViewController(videos, animated: true)
                
                print("0")
            }else {
                
                let videoPlay = VideoPlayViewController()
                self.navigationController?.pushViewController(videoPlay, animated: true)
                
                print("1")
            }
        }
        if (indexPath.section == 4) {
            let fangdiu = FangDiuViewController()
            self.navigationController?.pushViewController(fangdiu, animated: true)
            
            print("防丢失")
        }
    }
    func changeInfo(){
        let vc = PersonInformation()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension FunctionViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        pageControl.currentPage = Int(offset.x / view.bounds.width)
        // 因为currentPage是从0开始，所以numOfPages减1
        //print("啊！！")
    }
}

