//
//  KaoQinHistroyViewController.swift
//  WXT_Teacher
//
//  Created by qiang on 16/8/29.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
class KaoQinHistroyViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var picker:DatePickerView?
    let chooseClass = UIButton()
    let chooseDateBtn = UIButton()
    let tableView = UITableView()
    var classDataSource = ClassInfoList()
    var classHistroySource = ClassHistroy()
    var classid = NSUserDefaults.standardUserDefaults().stringForKey("classid")
    var begintime : String?
    var endtime : String?
    
    private  var nowDate: NSDate = NSDate()  //当前日期
    private  var getOneweek=0    //获取到年月的1号是周几
    private  var daycount=0        //获取到年月的总天数


    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = true
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "签到历史"
        self.view.backgroundColor = UIColor.whiteColor()
    
        loadData()
        
        loadSubviews()
        // Do any additional setup after loading the view.
    }

    //MARK: 加载数据
    func loadData(){
        
        initLoadDate()
        //获取班级列表
        loadClassData()
       
        //获取考勤记录列表
        loadKaoQinHistroy()
    }
    func loadClassData(){
        //http://wxt.xiaocool.net/index.php?g=apps&m=teacher&a=getteacherclasslist&teacherid=605
        let defalutid = NSUserDefaults.standardUserDefaults()
        let chid = defalutid.stringForKey("userid")
        
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=teacher&a=getteacherclasslist"
        let param = [
            "teacherid":chid!,
            ]
        Alamofire.request(.GET, url, parameters: param).response { request, response, json, error in
            if(error != nil){
                
            }else{
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
                    
                    self.classDataSource.objectlist.removeAll()
                    self.classDataSource = ClassInfoList(status.data!)
                    if self.classDataSource.objectlist.count>0{
                        for item in self.classDataSource.objectlist{
                            if item.classid == self.classid{
                                self.chooseClass.setTitle(item.classname, forState: UIControlState.Normal)
                            }
                        }
                    }
                    
                    
                }
            }
        }
    }
    func loadKaoQinHistroy(){
        //http://wxt.xiaocool.net/index.php?g=apps&m=teacher&a=GetStudentAttendanceDays&userid=605&begintime=1469980800&endtime=1472659199&classid=1
        let defalutid = NSUserDefaults.standardUserDefaults()
        let chid = defalutid.stringForKey("userid")

        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=teacher&a=GetStudentAttendanceDays"
        let param = [
            "userid":chid!,
            "classid":classid,
            "begintime":begintime,
            "endtime":endtime,
            ]
        Alamofire.request(.GET, url, parameters: param as! [String:String]).response { request, response, json, error in
            if(error != nil){
                
            }else{
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
                    
                    self.classHistroySource.objectlist.removeAll()
                    self.classHistroySource = ClassHistroy(status.data!)
                    self.tableView.reloadData()
                    
                }
            }
        }
    }
    //MARK: 加载布局
    func loadSubviews(){
        //班级，时间选择菜单栏的初始化
        addToolbar()
        //签到历史列表
        addtableView()
    }
    //添加菜单栏
    func addToolbar(){
        //承载view
        let toolView = UIView()
        toolView.frame = CGRectMake(0, 0, WIDTH, 50)
        toolView.backgroundColor = UIColor.grayColor()
        self.view.addSubview(toolView)
        
        
        //选择班级
        chooseClass.frame = CGRectMake(0, 0, 80, 50)
        chooseClass.setTitle("班级", forState: UIControlState.Normal)
        chooseClass.addTarget(self, action: #selector(self.chooseClass(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        toolView.addSubview(chooseClass)
        let im1 = UIImageView()
        im1.frame = CGRectMake(80, 20, 10, 10)
        im1.image = UIImage(named: "ic_xuanzebanji")
        toolView.addSubview(im1)
        
        //选择日期
        
        chooseDateBtn.frame = CGRectMake(WIDTH-100-30, 0 , 100, 50)
        chooseDateBtn.setTitle("时间", forState: UIControlState.Normal)
        chooseDateBtn.addTarget(self, action: #selector(self.chooseDate), forControlEvents: UIControlEvents.TouchUpInside)
        
        toolView.addSubview(chooseDateBtn)
        let im2 = UIImageView()
        im2.frame = CGRectMake(chooseDateBtn.frame.maxX, 20, 10, 10)
        im2.image = UIImage(named: "ic_xuanzebanji")
        toolView.addSubview(im2)
        
        
        
        chooseDateBtn.setTitle(changeTimeFour(begintime!), forState: UIControlState.Normal)
    }
    //添加tableview
    func addtableView(){
        tableView.frame = CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height-64-40)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .None
        tableView.rowHeight = 50
        tableView.backgroundColor = RGBA(242.0, g: 242.0, b: 242.0, a: 1)
        self.view.addSubview(tableView)

    }
    
    func initLoadDate(){
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //得到年月的1号
        let date = dateFormatter.dateFromString("\(nowDate.currentYear)-\(nowDate.currentMonth)-01 00:00:00")
        getOneweek = date!.toMonthOneDayWeek(date!)
        
        daycount = date!.TotaldaysInThisMonth(date!)
        
        //  获取当月开始时间戳
        let timeInterval:NSTimeInterval = date!.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        print("当前时间的时间戳：\(timeStamp)")
        daycount = date!.TotaldaysInThisMonth(date!)   //更新当前年月天数
        print("99999999999999999999999")
        print(daycount)
        endtime = String(timeStamp  + (daycount - 1) * 86400)
        print("最后一天：\(endtime)")
        begintime = String( timeStamp)
        
//        GET(endday, begindate: startday)
        
        
        
    }
    
    //MARK:tableview 代理方法
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return self.classHistroySource.objectlist.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("kaoqinhistroy")
        
        if cell==nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "kaoqinhistroy")
        }

    
        for item in (cell?.contentView.subviews)! {
            item.removeFromSuperview()
        }
    
        //初始化头像
        let avatarImg = UIImageView()
        avatarImg.frame = CGRectMake(10, 10, 30, 30)
        avatarImg.cornerRadius = 15
        avatarImg.yy_setImageWithURL(NSURL(string: imageUrl + self.classHistroySource.objectlist[indexPath.row].photo!), placeholder: UIImage(named: "图片默认加载"))
        cell?.contentView.addSubview(avatarImg)
        
        
        //初始化姓名
        let nameLabel = UILabel()
        nameLabel.frame = CGRectMake(avatarImg.frame.maxX+5, 0, 80, (cell?.frame.height)!)
        cell?.contentView.addSubview(nameLabel)
        nameLabel.text = self.classHistroySource.objectlist[indexPath.row].name
        
        //初始化签到天数
        let qiandaoDays = UILabel()
        qiandaoDays.frame = CGRectMake(WIDTH-100, 0, 100, 50)
        qiandaoDays.text = "签到\(self.classHistroySource.objectlist[indexPath.row].arrive_count!)天"
        cell?.contentView.addSubview(qiandaoDays)
        
        return cell!
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let vc = KaoQinViewController()
        vc.id = self.classHistroySource.objectlist[indexPath.row].id
        vc.titlename = self.classHistroySource.objectlist[indexPath.row].name
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    //MARK: 点击事件
    func chooseClass(sender:UIButton) {

        var  array = Array<String>()
       
        for item in self.classDataSource.objectlist {
            array.append(item.classname!)
        }
    
        
       FTPopOverMenu .showForSender(sender, withMenu: array, doneBlock: { a in
            sender.setTitle(array[a] , forState: UIControlState.Normal)
            self.classid = self.classDataSource.objectlist[a].classid
            self.loadKaoQinHistroy()
        }) {
            FTPopOverMenu.dismiss()
        }
        
        
    }
    func chooseDate() {
        picker = DatePickerView.getShareInstance()
        picker!.textColor = UIColor.redColor()
        picker!.showWithDate(NSDate())
        picker?.block = {
            (date:NSDate)->() in
            let formatter = NSDateFormatter()
            formatter.dateFormat = "yyyy-MM"
            let string = formatter.stringFromDate(date)
            self.reLoadDate(string)
            self.chooseDateBtn.setTitle(string, forState: UIControlState.Normal)
        }

    }
    
    func reLoadDate(string:String){
        
        let a = string.componentsSeparatedByString("-")
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //得到年月的1号
        let date = dateFormatter.dateFromString("\(a.first!)-\(a.last!)-01 00:00:00")
        getOneweek = date!.toMonthOneDayWeek(date!)
        
        daycount = date!.TotaldaysInThisMonth(date!)
        
        //  获取当月开始时间戳
        let timeInterval:NSTimeInterval = date!.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        print("当前时间的时间戳：\(timeStamp)")
        daycount = date!.TotaldaysInThisMonth(date!)   //更新当前年月天数
        print("99999999999999999999999")
        print(daycount)
        endtime = String(timeStamp  + (daycount - 1) * 86400)
        print("最后一天：\(endtime)")
        begintime = String( timeStamp)
        
        self.loadKaoQinHistroy()
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
