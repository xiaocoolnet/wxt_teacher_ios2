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
    var startday = Int()
    //  结束时间戳
    var endday = Int()
    
    var nowDate: NSDate = NSDate()  //当前日期
    var getOneweek=0    //获取到年月的1号是周几
    var daycount=0        //获取到年月的总天数
    var timeLabel = UILabel()

    var dianPingSource = DianPingList()

    let DianPingView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "点评记录"
        self.view.backgroundColor = UIColor.whiteColor()
        self.tabBarController?.tabBar.hidden = true
        DianPingView.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height-64)
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
        createView()
        // Do any additional setup after loading the view.
        self.DropDownUpdate()
    }
    
    
    func createView(){
        let view = UIView()
        view.frame = CGRectMake(0, 60, WIDTH, 60)
        view.backgroundColor = UIColor.whiteColor()
        DianPingView.tableHeaderView = view
        //  添加button
        let leftBtn = UIButton()
        leftBtn.frame  = CGRectMake((WIDTH - 200) / 2, 10, 50, 30)
        leftBtn.setImage(UIImage(named: "左侧箭头"), forState: .Normal)
        leftBtn.addTarget(self, action: #selector(self.leftClickBtn), forControlEvents: .TouchUpInside)
        view.addSubview(leftBtn)
        
        let rightBtn = UIButton()
        rightBtn.frame  = CGRectMake(WIDTH / 2 + 50, 10, 50, 30)
        rightBtn.setImage(UIImage(named: "右侧箭头"), forState: .Normal)
        rightBtn.addTarget(self, action: #selector(self.rightClickBtn), forControlEvents: .TouchUpInside)
        view.addSubview(rightBtn)
        
        let nowDate = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM"
        let dateString = formatter.stringFromDate(nowDate)
        
        timeLabel = UILabel()
        timeLabel.frame = CGRectMake(WIDTH / 2 - 50, 10, 100, 30)
        timeLabel.textAlignment = NSTextAlignment.Center
        //      需要得到数据
        timeLabel.text = dateString
        view.addSubview(timeLabel)
        
        //  获取当月的开始时间和最终时间
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //得到年月的1号
        let date = dateFormatter.dateFromString("\(nowDate.currentYear)-\(nowDate.currentMonth)-01 23:59:59")
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
        
         GetDate()
    }
    
    func rightClickBtn() {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var date = NSDate()
        
        //得到年月的1号
        if((nowDate.currentMonth+1)==13){
            date = dateFormatter.dateFromString("\(nowDate.currentYear+1)-\(01)-01 23:59:59")!
            print("#############")
            print(date)
        }
        else{
            date = dateFormatter.dateFromString("\(nowDate.currentYear)-\(nowDate.currentMonth+1)-01 23:59:59")!
            print("$$$$$$$$$$")
            print(date)
            
        }
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
        GetDate()
        
    }
    func leftClickBtn() {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var date = NSDate()
        //得到年月的1号
        if((nowDate.currentMonth-1)==0){
            let str:String="\(nowDate.currentYear-1)-\(12)-01 23:59:59"
            date = dateFormatter.dateFromString(str)!
            print("++++++++++")
            print(date)
        }
        else{
            let str:String="\(nowDate.currentYear)-\(nowDate.currentMonth-1)-01 23:59:59"
            date = dateFormatter.dateFromString(str)!
            print("***************")
            print(date)
            
        }
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
        
        
        GetDate()
        
    }
    func DropDownUpdate(){
        self.DianPingView.headerView = XWRefreshNormalHeader(target: self, action: #selector(TeacherDianPingViewController.GetDate))
        self.DianPingView.reloadData()
        self.DianPingView.headerView?.beginRefreshing()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        DropDownUpdate()
    }
    func GetDate(){
        
        //http://wxt.xiaocool.net/index.php?g=apps&m=teacher&a=GetTeacherComment&teacherid=605&begintime=1469980800&endtime=1472659199
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=teacher&a=GetTeacherComment"
        let user = NSUserDefaults.standardUserDefaults()
        let uid = user.stringForKey("userid")
        let param = [
            "teacherid":uid,
            "begintime":String(startday),
            "endtime":String(endday),
        ]
        Alamofire.request(.GET, url, parameters: param as! [String : String]).response { request, response, json, error in
            if(error != nil){
                  self.DianPingView.headerView?.endRefreshing()
            }else{
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
                    self.DianPingView.headerView?.endRefreshing()
                    print("0")
                }
                if(status.status == "success"){
                    self.dianPingSource.objectlist.removeAll()
                    self.dianPingSource = DianPingList(status.data!)
                    self.DianPingView.reloadData()
                    self.DianPingView.headerView?.endRefreshing()
                    print("1")
                }
            }
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return dianPingSource.objectlist.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dianPingSource.objectlist[section].studentlist.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TDP", forIndexPath: indexPath) as! TeacherDianPingTableViewCell
        cell.avatorImage.yy_setImageWithURL(NSURL(string:imageUrl+self.dianPingSource.objectlist[indexPath.section].studentlist[indexPath.row].photo!), placeholder: UIImage(named: "图片默认加载"))
        cell.nameLabel.text = self.dianPingSource.objectlist[indexPath.section].studentlist[indexPath.row].name
        cell.contentLabel.text = "本月已经点评\(self.dianPingSource.objectlist[indexPath.section].studentlist[indexPath.row].comments.count)条"
        
        cell.selectionStyle = .None
        
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = TeacherCommentsTableViewController()
        vc.startday = startday
        vc.endday = endday
        vc.id = self.dianPingSource.objectlist[indexPath.section].studentlist[indexPath.row].id
        vc.name = self.dianPingSource.objectlist[indexPath.section].studentlist[indexPath.row].name
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    func FaBiao(){
        print("发表")
        let dianpingList = FaBiaoDianpingViewController()
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
