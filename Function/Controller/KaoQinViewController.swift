//
//  KaoQinViewController.swift
//  WXT_Parents
//
//  Created by zhang on 16/5/12.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

class KaoQinViewController: UIViewController,UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDataSource{
    var scrol = UIScrollView()
    var table = UITableView()
    let signArray = NSMutableArray()
    var collection:UICollectionView?
    var flowLayout = UICollectionViewFlowLayout()
    
    private  var CalendarView=UIView()   //日历view
    private  var TopView=UIView()        //头顶view
    private var MainView=UIView()       //中间view
    private var BottomView=UIView()     //底部view
    
    private var btnleft=UIButton()      //上一月
    private  var btnriright=UIButton()   //下一月
    private  var btnyyyymmdd=UIButton()  //年月日
    
    private var btnSelected=UIButton()  //选中
    private  var btnCancel=UIButton()    //取消
    
    private  var nowDate: NSDate = NSDate()  //当前日期
    private  var getOneweek=0    //获取到年月的1号是周几
    private  var daycount=0        //获取到年月的总天数
    
    var dataSource = KaoqinList()
    var dataArray = NSMutableArray()
    var id : String?
    var titlename: String?
    
    var startday = Int()
    //  结束时间戳
    var endday = Int()
    var timeLabel = UILabel()
    //补签视图
    let invite = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationStyle = .Custom  //半透明
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = titlename ?? "老师考勤"
        
        scrol.frame = CGRectMake(0, 0, WIDTH, HEIGHT)
        scrol.contentSize = CGSizeMake(WIDTH, HEIGHT);
        self.view.addSubview(scrol)
        
        
        
        CalendarView.frame=CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height/2+50)
        CalendarView.backgroundColor=UIColor.whiteColor()
        
        TopView.frame=CGRect(x:0, y: 0, width: CalendarView.frame.width, height: 70)
        TopView.backgroundColor=UIColor.whiteColor()
        CalendarView.addSubview(TopView)
        
        self.createCollection()
        
        
        scrol.addSubview(CalendarView)
        //初始化日期
        initLoadDate()
        //添加头部试图信息
        AddTop()
        //添加日历内容
        AddMain()
        
        table.frame = CGRectMake(0, self.view.frame.height/2+50, WIDTH, HEIGHT - self.view.frame.height/2 - 64 - 44)
        table.delegate = self
        table.dataSource = self
        table.scrollEnabled = false
        scrol.addSubview(table)
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
        endday = timeStamp  + (daycount - 1) * 86400
        print("最后一天：\(endday)")
        startday = timeStamp

        GET(endday, begindate: startday)

        
        
    }
    
    
    func AddTop(){
        
        let  _width = (TopView.frame.width*(1+1)-TopView.frame.width) / CGFloat(7) //整个TopView宽度的100% / 7
        for (var i:Int=0 ; i<7 ; i++){
            let lb  = UILabel(frame: CGRect(x: CGFloat(i)*_width, y: TopView.frame.height-30, width: _width, height: 30))
            lb.textColor=UIColor.blackColor()
            var str=""
            switch(i){
            case 0: str="日";lb.textColor=UIColor.redColor();break
            case 1: str="一";break
            case 2: str="二";break
            case 3: str="三";break
            case 4: str="四";break
            case 5: str="五";break
            case 6: str="六";lb.textColor=UIColor.redColor();break
            default:
                break
            }
            
            lb.text=str
            lb.font=UIFont.systemFontOfSize(13)
            lb.textAlignment = .Center
            
            TopView.addSubview(lb)
        }
        let  _width1 = (TopView.frame.width*(1+1)-TopView.frame.width) / CGFloat(3) //整个TopView宽度的100% / 3
        for (var i:Int=0 ; i<3 ; i++){
            
            var str=""
            switch(i){
            case 0: str="<"
            btnleft.frame=CGRect(x: CGFloat(i)*_width1, y: TopView.frame.height-60, width: _width1, height: 30)
            btnleft.titleLabel?.font=UIFont.systemFontOfSize(20)
            btnleft.setTitleColor(UIColor(red: 155/255.0, green: 229 / 255.0, blue: 180 / 255.0, alpha: 1.0), forState: .Normal)
            btnleft.setTitle(str, forState: .Normal)
            TopView.addSubview(btnleft)
                break
            case 1: str="nyyyymmdd"
            btnyyyymmdd.frame=CGRect(x: CGFloat(i)*_width1, y: TopView.frame.height-60, width: _width1, height: 30)
            btnyyyymmdd.titleLabel?.font=UIFont.boldSystemFontOfSize(15)
            btnyyyymmdd.setTitleColor(UIColor(red: 50/255, green: 205/255, blue: 50/255, alpha: 1), forState: .Normal)
            TopView.addSubview(btnyyyymmdd)
                break
            case 2: str=">"
            btnriright.frame=CGRect(x: CGFloat(i)*_width1, y: TopView.frame.height-60, width: _width1, height: 30)
            btnriright.titleLabel?.font=UIFont.systemFontOfSize(20)
            btnriright.setTitleColor(UIColor(red: 155/255.0, green: 229 / 255.0, blue: 180 / 255.0, alpha: 1.0), forState: .Normal)
            btnriright.setTitle(str, forState: .Normal)
            
            TopView.addSubview(btnriright)
                break
            default:
                break
            }
            
        }
        btnleft.addTarget(self, action: #selector(KaoQinViewController.btnleft_Click), forControlEvents: .TouchUpInside)
        btnriright.addTarget(self, action: #selector(KaoQinViewController.btnriright_Click), forControlEvents: .TouchUpInside)
    }
    
    
    func AddMain(){
        
        btnyyyymmdd.setTitle("\(nowDate.currentYear)年\(nowDate.currentMonth)月", forState: .Normal) //更改年月
        
        for sub in MainView.subviews{   //如果存在子项先清空当前子项的内容
            sub.removeFromSuperview()
        }
        let toYear=NSDate().currentYear //当前日期的年
        let toMonth=NSDate().currentMonth   //当前月
        let today=NSDate().currentDay       //当前日
        let  _width = (MainView.frame.width*(1+1)-MainView.frame.width) / CGFloat(7) //整个MainView宽度的100% / 7
        
        let _heigth=MainView.frame.height/6
        var indexday=0  //第0位开始
//        var btn = UIButton()
        for index in  0...5 {
            for (var i:Int=0 ; i<7 ; i++){
                let btn  = UIButton(frame: CGRect(x: CGFloat(i)*_width + 1, y: CGFloat(index)*_heigth, width: _width - 5, height: _heigth - 5))
                btn.titleLabel?.font=UIFont.systemFontOfSize(14)
                btn.backgroundColor = UIColor.redColor()
                btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
                btn.tag=indexday
                btn.layer.cornerRadius=0
                btn.layer.borderColor=UIColor(red: 51/255, green: 161/255, blue: 202/255, alpha: 1).CGColor
                btn.layer.borderWidth=0.5
                btn.titleLabel?.textAlignment = NSTextAlignment.Right
                //创建一个点击的时候有勾选的lable
                let check_lb  = UILabel(frame:CGRect( x:0,y: btn.frame.height/2,width: btn.frame.width,height: btn.frame.height/2))
                //                check_lb.backgroundColor = UIColor.whiteColor()
                check_lb.font=UIFont.boldSystemFontOfSize(14)
                check_lb.tag = btn.tag
                btn.addSubview(check_lb)
                if(indexday==today){  //因为是第0开始的  索引天数后面需要+1
                    if(toYear==nowDate.currentYear&&toMonth==nowDate.currentMonth){ //判断是否是今年今月
                        
                        btn.titleLabel?.font=UIFont.boldSystemFontOfSize(15)
                        btn.setTitleColor(UIColor(red: 227/255, green:23/255, blue: 13/255, alpha: 1), forState: .Normal)
                    }
                }
                if indexday > today {
                    if(toYear==nowDate.currentYear&&toMonth==nowDate.currentMonth){
                        btn.backgroundColor = UIColor.blueColor()
                        
                    }
                }
                MainView.addSubview(btn)
                indexday += 1
            }
        }
        indexday=1
        for sub in MainView.subviews{
            let btn =  sub as!  UIButton
            if(btn.tag==getOneweek){
                btn.setTitle(indexday.description, forState: .Normal)
                for label in btn.subviews {
                    if label.tag == btn.tag {
                        if self.dataArray.count > 0 {
                            for i in 0...self.dataArray.count - 1 {
                                let str = self.dataArray[i] as! KaoqinInfo
                                let st = str.arrivetime
                                if st != "" && st != nil{
                                    let dateformat = NSDateFormatter()
                                    dateformat.dateFormat = "yyyy-MM-dd HH:mm"
                                    let date = NSDate(timeIntervalSince1970: NSTimeInterval(st!)!)
                                    let string:String = dateformat.stringFromDate(date)
                                    let ns3=(string as NSString).substringWithRange(NSMakeRange(8, 2))
                                    let a = Int(ns3)
                                    if a == indexday {
                                        (label as! UILabel).text = "已签到"
                                        let btn =  sub as!  UIButton
                                        btn.backgroundColor = UIColor.greenColor()
                                    }else{
                                        (label as! UILabel).text = "未签到"
                                    }

                                    (label as! UILabel).text = "已签到"
                                }else{
                                    (label as! UILabel).text = "未签到"
                                }
                            }
                        }
                        (label as! UILabel).text = "未签到"
                    }
                }
                indexday += 1
                
                continue
            }
            if(indexday>1){
                if(indexday<=daycount){ //当前的天数如果小于等于当总天数
                    btn.setTitle(indexday.description, forState: .Normal)
                    let arra = NSMutableArray()
                    for label in btn.subviews {
                        if label.tag == btn.tag {
                            if self.dataArray.count > 0 {
                                
                                for i in 0...self.dataArray.count - 1 {
                                    let str = self.dataArray[i] as! KaoqinInfo
                                    let st = str.arrivetime
                                    if st != "" && st != nil{
                                        let dateformat = NSDateFormatter()
                                        dateformat.dateFormat = "yyyy-MM-dd HH:mm"
                                        let date = NSDate(timeIntervalSince1970: NSTimeInterval(st!)!)
                                        let string:String = dateformat.stringFromDate(date)
                                        let ns3=(string as NSString).substringWithRange(NSMakeRange(8, 2))
                                        let a = Int(ns3)
                                        arra.addObject(a!)
                                        (label as! UILabel).text = "未签到"
                                        for j in 0...arra.count - 1 {
                                            if Int(arra[j] as! NSNumber) == indexday {
                                                (label as! UILabel).text = "已签到"
                                                let btn =  sub as!  UIButton
                                                btn.backgroundColor = UIColor.greenColor()
//                                            }else{
//                                                (label as! UILabel).text = "未签到"
                                            }
                                        }

                                    }else{
                                        (label as! UILabel).text = "未签到"
                                    }
                                }

                            }else{
                                (label as! UILabel).text = "未签到"
                            }
                        }
                    }
                    indexday += 1
                }
            }
            
        }
    }
    

    func btnleft_Click(){
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var date = NSDate()
        //得到年月的1号
        if((nowDate.currentMonth-1)==0){
            let str:String="\(nowDate.currentYear-1)-\(12)-01 00:00:00"
            date = dateFormatter.dateFromString(str)!
        }
        else{
            let str:String="\(nowDate.currentYear)-\(nowDate.currentMonth-1)-01 23:59:59"
            date = dateFormatter.dateFromString(str)!
        }
        nowDate=date    //更新当前的年月
        getOneweek = date.toMonthOneDayWeek(date)   //更新当前年月周
        daycount = date.TotaldaysInThisMonth(date)  //更新当前年月天数
        AddMain()
        //  获取当前时间戳
        let timeInterval:NSTimeInterval = date.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        print("当前时间的时间戳：\(timeStamp)")
        nowDate=date    //更新当前的年月
        daycount = date.TotaldaysInThisMonth(date)  //更新当前年月天数
        print("99999999999999999999999")
        print(daycount)
        endday = timeStamp  + (daycount - 1) * 86400
        print("最后一天：\(endday)")
        startday = timeStamp
        
        let string = String(date)
        timeLabel.text = (string as NSString).substringToIndex(7)
        print("888888888888")
        print(timeLabel.text)

        GET(endday, begindate: startday)
    }
    
    func btnriright_Click(){
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var date = NSDate()
        //得到年月的1号
        if((nowDate.currentMonth+1)==13){
            date = dateFormatter.dateFromString("\(nowDate.currentYear+1)-\(01)-01 00:00:00")!
        }
        else{
            date = dateFormatter.dateFromString("\(nowDate.currentYear)-\(nowDate.currentMonth+1)-01 23:59:59")!
        }
        nowDate=date    //更新当前的年月
        getOneweek = date.toMonthOneDayWeek(date)    //更新当前年月周
        daycount = date.TotaldaysInThisMonth(date)   //更新当前年月天数
        AddMain()
        //  获取当前时间戳
        let timeInterval:NSTimeInterval = date.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        print("当前时间的时间戳：\(timeStamp)")
        nowDate=date    //更新当前的年月
        getOneweek = date.toMonthOneDayWeek(date)    //更新当前年月是第一周的周几
        daycount = date.TotaldaysInThisMonth(date)   //更新当前年月天数
        print("99999999999999999999999")
        print(daycount)
        print(getOneweek)
        endday = timeStamp  + (daycount - 1) * 86400
        print("最后一天：\(endday)")
        startday = timeStamp
        let string = String(date)
        timeLabel.text = (string as NSString).substringToIndex(7)
        print("888888888888")
        print(timeLabel.text)
        GET(endday, begindate: startday)
    }
    
    
        //即将出现
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = true
         initLoadDate()
        
        
    }
    
    //    创建表
    func GET(enddate:Int,begindate:Int){
        //        http://wxt.xiaocool.net/index.php?g=apps&m=student&a=GetTeacherComment&studentid=661&begintime=0&endtime=1469863987
        //  得到url
        
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=teacher&a=GetTeacherAttendanceList"
        let student = NSUserDefaults.standardUserDefaults()
        let studentid = id ?? student.stringForKey("userid")
        print(studentid)
        //  得到请求体
        let param = [
            "begintime":begindate,
            "endtime":enddate,
            "userid":studentid!
        ]
        
        Alamofire.request(.GET, url, parameters: param as? [String : AnyObject]).response
            {   request,  response, json, error in
                if(error != nil){
                    print(error)
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
                        self.dataArray = []
                        self.collection!.reloadData()
                        self.table.hidden = true
                        let dateformat = NSDateFormatter()
                        dateformat.dateFormat = "yyyy-MM-dd HH:mm"
                        let date = NSDate(timeIntervalSince1970: NSTimeInterval(enddate))
                        let string:String = dateformat.stringFromDate(date)
                        let ns2=(string as NSString).substringToIndex(7)
                        
                        //获取当前时间
                        let now = NSDate()
                        // 创建一个日期格式器
                        let dformatter = NSDateFormatter()
                        dformatter.dateFormat = "yyyy-MM-dd"
                        let s = String(dformatter.stringFromDate(now))
                        let ns3=(s as NSString).substringToIndex(7)
                        if ns2 == ns3{
                            if self.id == nil{
                                self.createView()
                            }
                            
                        }

                    }
                    if(status.status == "success"){
                        print("请求成功")
                        self.dataArray.removeAllObjects()
                        self.dataSource = KaoqinList(status.data!)
                        //获取当前时间
                        let now = NSDate()
                        // 创建一个日期格式器
                        let dformatter = NSDateFormatter()
                        dformatter.dateFormat = "yyyy-MM-dd"
                        let s = String(dformatter.stringFromDate(now))
                        let ns2=(s as NSString).substringToIndex(7)
                        print("wdwdw\(ns2)")
                        var string = String()
                        var ns3 = String()
                        if self.dataSource.count != 0{
                            for item in 0...self.dataSource.count-1{
                                let comment=self.dataSource.objectlist[item]
                                self.dataArray.addObject(comment)
                                let str = self.dataArray[item] as! KaoqinInfo
                                let st = str.arrivetime ?? str.leavetime
                                let dateformat = NSDateFormatter()
                                dateformat.dateFormat = "yyyy-MM-dd"
                                let date = NSDate(timeIntervalSince1970: NSTimeInterval(st!)!)
                                string = dateformat.stringFromDate(date)
                                ns3=(string as NSString).substringToIndex(7)
                                 print("wdwdwewefdw\(ns3)")
                            }
                            if s != string && ns2 == ns3{
                                if self.id == nil{
                                    self.createView()
                                }
                            }
                        }
                        self.table.hidden = false
                        self.collection?.reloadData()
                        self.table.reloadData()
                        let count = CGFloat(Float(self.dataSource.count))
                        self.scrol.contentSize = CGSizeMake(WIDTH, self.CalendarView.frame.height + 140.0*count)
                        self.table.frame = CGRectMake(0, self.CalendarView.frame.maxY, WIDTH, HEIGHT - self.view.frame.height/2 - 64 - 44 + self.CalendarView.frame.height + 140.0*count)
                    }
                }
        }
        
        
    }
    
    func createView() {
        
        invite.frame = CGRectMake(0, 0, WIDTH, HEIGHT)
        invite.backgroundColor = UIColor.init(white: 0, alpha: 0.6)
        //        invite.alpha = 0.6
        self.view.window!.addSubview(invite)
        
        let view = UIView()
        view.frame = CGRectMake(60, HEIGHT/2 - 100, WIDTH - 120, 200)
        view.backgroundColor = UIColor.whiteColor()
        invite.addSubview(view)
        let width = view.frame.size.width
        
        let content = UILabel()
        content.frame = CGRectMake(10, 10, width - 20, 100)
        content.text = "今天还未签到！是否补签"
        content.font = UIFont.systemFontOfSize(19)
        content.numberOfLines = 0
        view.addSubview(content)
        
        let noBtn = UIButton()
        noBtn.frame = CGRectMake(10, 120, width/2 - 10, 80)
        noBtn.setTitle("取消", forState: .Normal)
        noBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        noBtn.addTarget(self, action: #selector(self.clickNoBtn), forControlEvents: .TouchUpInside)
//        noBtn.layer.borderColor = UIColor.blackColor().CGColor
//        noBtn.layer.borderWidth = 0.5
        view.addSubview(noBtn)
        
        let yesBtn = UIButton()
        yesBtn.frame = CGRectMake(width/2, 120, width/2 - 10, 80)
        yesBtn.setTitle("补签", forState: .Normal)
//        yesBtn.layer.borderColor = UIColor.blackColor().CGColor
        yesBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
//        yesBtn.layer.borderWidth = 0.5
        yesBtn.addTarget(self, action: #selector(self.clickYesBtn), forControlEvents: .TouchUpInside)
        view.addSubview(yesBtn)
        
    }
    
    func clickNoBtn(){
        self.invite.removeFromSuperview()
    }
    
    func clickYesBtn(){
        let user = NSUserDefaults.standardUserDefaults()
        let uid = id ?? user.stringForKey("userid")
        let schoolid = user.stringForKey("schoolid")
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=index&a=resign"
        let param = [
            "userid":uid!,
            "schoolid":schoolid
        ]
        Alamofire.request(.GET, url, parameters: param as? [String:String] ).response { request, response, json, error in
            print(request)
            if(error != nil){
                    
            }else{
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
                    
                    let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                    hud.mode = MBProgressHUDMode.Text;
                    hud.labelText = "补签成功"
                    hud.margin = 10.0
                    hud.removeFromSuperViewOnHide = true
                    hud.hide(true, afterDelay: 1)
                    self.invite.removeFromSuperview()
                    self.initLoadDate()
                    self.collection?.reloadData()
                    self.table.reloadData()
                }
            }
        }

    }
    
    
    func createCollection(){
        flowLayout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        flowLayout.itemSize = CGSizeMake(CalendarView.frame.width, CalendarView.frame.height-70)
        self.collection = UICollectionView(frame:CGRectMake( 0, 70, CalendarView.frame.width, CalendarView.frame.height-70), collectionViewLayout: flowLayout)
        //        注册
        self.collection!.registerClass(KaoqinCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        self.collection!.delegate = self
        self.collection!.dataSource = self
        self.CalendarView.addSubview(collection!)
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
       return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! KaoqinCollectionViewCell
        MainView.frame=CGRect(x:0, y: 0, width: CalendarView.frame.width, height: CalendarView.frame.height-70)
        MainView.backgroundColor=UIColor.grayColor()
        cell.addSubview(MainView)
        
        self.AddMain()
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(self.dataSource.objectlist.count)
        return self.dataSource.objectlist.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: String(indexPath.row))
        cell.selectionStyle = .None
        table.separatorStyle = .None
        
        let model = self.dataSource.objectlist[indexPath.row]
        
        
        let qian = UILabel()
        qian.frame = CGRectMake(10, 50, 50, 40)
        qian.text = "签到"
        cell.contentView.addSubview(qian)
        
        let dateformate = NSDateFormatter()
        dateformate.dateFormat = "yyyy-MM-dd HH:mm"
       
        let qianTime = UILabel()
        qianTime.frame = CGRectMake(70, 50, 100, 40)
        var s = ""
        var str:String
        if model.arrivetime==nil {
            
        }else{
            let date = NSDate(timeIntervalSince1970: NSTimeInterval(model.arrivetime!)!)
             str = dateformate.stringFromDate(date)
            s = (str as NSString).substringWithRange(NSMakeRange(11, 5))
        }
        qianTime.text = s
        cell.addSubview(qianTime)
        let mon = UILabel()
        mon.frame = CGRectMake(0, 0, WIDTH, 40)
        mon.backgroundColor = UIColor.lightGrayColor()
        let date = NSDate(timeIntervalSince1970: NSTimeInterval(model.create_time!)!)
        str = dateformate.stringFromDate(date)
        mon.text = (str as NSString).substringWithRange(NSMakeRange(5, 5))
        cell.addSubview(mon)
        
        let tui = UILabel()
        tui.frame = CGRectMake(10, 100, 50, 40)
        tui.text = "签退"
        cell.contentView.addSubview(tui)
        
        let dateformat = NSDateFormatter()
        dateformat.dateFormat = "yyyy-MM-dd HH:mm"
        
        let tuiTime = UILabel()
        tuiTime.frame = CGRectMake(70, 100, 100, 40)
        if model.leavetime==nil {
            
        }else{
            let dat = NSDate(timeIntervalSince1970: NSTimeInterval(model.leavetime!)!)
            let st:String = dateformate.stringFromDate(dat)
             tuiTime.text = (st as NSString).substringWithRange(NSMakeRange(11, 4))
        }
       
        cell.addSubview(tuiTime)
        
        table.rowHeight = 140
        
        return cell
    }




    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
//// MARK: - 拓展日期类
//extension NSDate {
//    /**
//     这个月有几天
//     
//     - parameter date: nsdate
//     
//     - returns: 天数
//     */
//    func TotaldaysInThisMonth(date : NSDate ) -> Int {
//        let totaldaysInMonth: NSRange = NSCalendar.currentCalendar().rangeOfUnit(.Day, inUnit: .Month, forDate: date)
//        print("&&&&&&&&&&&&")
//        print(totaldaysInMonth.length)
//        
//        return totaldaysInMonth.length
//    }
//    
//    /**
//     得到本月的第一天的是第几周
//     
//     - parameter date: nsdate
//     
//     - returns: 第几周
//     */
//    func toMonthOneDayWeek (date:NSDate) ->Int {
//        let Week: NSInteger = NSCalendar.currentCalendar().ordinalityOfUnit(.Day, inUnit: NSCalendarUnit.WeekOfMonth, forDate: date)
//        return Week-1
//    }
//    
//    
//    /// 返回当前日期 年份
//    var currentYear:Int{
//        
//        get{
//            
//            return GetFormatDate("yyyy")
//        }
//        
//    }
//    /// 返回当前日期 月份
//    var currentMonth:Int{
//        
//        get{
//            
//            return GetFormatDate("MM")
//        }
//        
//    }
//    /// 返回当前日期 天
//    var currentDay:Int{
//        
//        get{
//            
//            return GetFormatDate("dd")
//        }
//        
//    }
//    /// 返回当前日期 小时
//    var currentHour:Int{
//        
//        get{
//            
//            return GetFormatDate("HH")
//        }
//        
//    }
//    /// 返回当前日期 分钟
//    var currentMinute:Int{
//        
//        get{
//            
//            return GetFormatDate("mm")
//        }
//        
//    }
//    /// 返回当前日期 秒数
//    var currentSecond:Int{
//        
//        get{
//            
//            return GetFormatDate("ss")
//        }
//        
//    }
//    
//    /**
//     获取yyyy  MM  dd  HH mm ss
//     
//     - parameter format: 比如 GetFormatDate(yyyy) 返回当前日期年份
//     
//     - returns: 返回值
//     */
//    func GetFormatDate(format:String)->Int{
//        let dateFormatter:NSDateFormatter = NSDateFormatter();
//        dateFormatter.dateFormat = format;
//        let dateString:String = dateFormatter.stringFromDate(self);
//        var dates:[String] = dateString.componentsSeparatedByString("")
//        let Value  = dates[0]
//        if(Value==""){
//            return 0
//        }
//        return Int(Value)!
//    }
//}
