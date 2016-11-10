//
//  bbKaoQinViewController.swift
//  WXT_Teacher
//
//  Created by 李春波 on 16/3/13.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//


import UIKit
import Alamofire
import MBProgressHUD
class bbKaoQinViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    var dataSource = ClassKaoQinList()
    var selectedStu = NSMutableArray()
    var ids :String?
    var dateSelect:String?
    let selecBtn = UIButton()
    
    var avatorCollection : UICollectionView!
    var flowLayout = UICollectionViewFlowLayout()
    var timeView = UIView()
    let lastDayBtn = UIButton()
    let nextDayBtn = UIButton()
    let timeLabel = UILabel()
    let lastMonthBtn = UIButton()
    let nextMonthBtn = UIButton()
    let sumCount = UILabel()	
    let shiDaoCount = UILabel()
    let qingJiaCount = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "宝宝考勤"
        self.view.backgroundColor = UIColor.whiteColor()
        self.tabBarController?.tabBar.hidden = true
        flowLayout.scrollDirection = UICollectionViewScrollDirection.Vertical
        print(UIScreen.mainScreen().bounds.width)
        avatorCollection = UICollectionView(frame: CGRectMake(0, 60, UIScreen.mainScreen().bounds.width, self.view.bounds.height-50), collectionViewLayout: flowLayout)
        avatorCollection!.delegate = self
        avatorCollection!.dataSource = self
        avatorCollection!.alwaysBounceVertical = true
        timeView.frame = CGRectMake(0, 34, self.view.bounds.width, 20)
        timeView.backgroundColor = UIColor.whiteColor()
        avatorCollection!.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        avatorCollection.contentSize = CGSizeMake(100, 100)
        avatorCollection!.registerClass(AvatorCollectionViewCell.self, forCellWithReuseIdentifier: "AvatorCell")
        self.lastDayBtn.frame  = CGRectMake((WIDTH - 200) / 2, 10, 50, 30)
        self.lastDayBtn.setImage(UIImage(named: "左侧箭头"), forState: .Normal)
        self.lastDayBtn.addTarget(self, action: #selector(bbKaoQinViewController.LastDay), forControlEvents: .TouchUpInside)
        self.nextDayBtn.frame  = CGRectMake(WIDTH / 2 + 50, 10, 50, 30)
        self.nextDayBtn.setImage(UIImage(named: "右侧箭头"), forState: .Normal)
        self.nextDayBtn.addTarget(self, action: #selector(bbKaoQinViewController.NextDay), forControlEvents: .TouchUpInside)
//        self.lastMonthBtn.frame = CGRectMake(30, 10, 20, 20)
//        self.lastMonthBtn.setImage(UIImage(named: "上个月"), forState: .Normal)
//        self.lastMonthBtn.addTarget(self, action: #selector(bbKaoQinViewController.LastMonth), forControlEvents: .TouchUpInside)
//        self.nextMonthBtn.frame = CGRectMake(0, 10, 20, 20)
//        self.nextMonthBtn.setImage(UIImage(named: "下个月"), forState: .Normal)
//        self.nextMonthBtn.frame.origin.x = self.view.bounds.width - 50
//        self.nextMonthBtn.addTarget(self, action: #selector(bbKaoQinViewController.NextMonth), forControlEvents: .TouchUpInside)
        self.timeLabel.frame = CGRectMake(WIDTH / 2 - 150/2, 15, 150, 20)
        self.timeLabel.textColor = UIColor.grayColor()
        self.timeLabel.textAlignment = .Center
        self.timeLabel.center.x = self.view.center.x
        self.timeLabel.font = UIFont.systemFontOfSize(15)
        self.sumCount.frame = CGRectMake(0, 40, 69, 20)
        self.sumCount.textColor = UIColor.grayColor()
        self.sumCount.center.x = self.view.bounds.width/6
        self.sumCount.font = UIFont.systemFontOfSize(15)
        self.sumCount.text = "总人数:15"
        self.sumCount.textAlignment = .Center
        self.shiDaoCount.frame = CGRectMake(0, 40, 85, 20)
        self.shiDaoCount.textColor = UIColor.grayColor()
        self.shiDaoCount.center.x = self.view.center.x
        self.shiDaoCount.font = UIFont.systemFontOfSize(15)
        self.shiDaoCount.text = "实到人数:15"
        self.shiDaoCount.textAlignment = .Center
        self.qingJiaCount.frame = CGRectMake(0, 40, 75, 20)
        self.qingJiaCount.textColor = UIColor.grayColor()
        self.qingJiaCount.center.x = self.view.bounds.width/6*5
        self.qingJiaCount.font = UIFont.systemFontOfSize(15)
        self.qingJiaCount.text = "请假人数:0"
        self.qingJiaCount.textAlignment = .Center
        let today:NSDate = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateSelect = dateFormatter.stringFromDate(today)
        timeLabel.text = dateSelect
        self.view.addSubview(self.timeView)
        self.view.addSubview(self.timeLabel)
        self.view.addSubview(self.nextMonthBtn)
        self.view.addSubview(self.lastMonthBtn)
        self.view.addSubview(self.nextDayBtn)
        self.view.addSubview(self.lastDayBtn)
        self.view.addSubview(self.qingJiaCount)
        self.view.addSubview(self.shiDaoCount)
        self.view.addSubview(self.sumCount)
        self.view.addSubview(avatorCollection!)
        let sign_date = "\(dateSelect!)-00-00-00"
        //初始化下面全选布局
        setFooterView()
        loadData(stringToTimeStamp(sign_date))
    }
    
    func setFooterView() -> Void {
        let footerView = UIView()
        footerView.frame = CGRectMake(0, HEIGHT-60-40-50, WIDTH, 50)
        self.view.addSubview(footerView)
        
        
        //左边全选按钮和显示选中个数
        let label = UILabel()
        label.frame = CGRectMake(5, 0, 50, 50)
        label.textAlignment = .Center
        label.text = "全选"
        footerView.addSubview(label)
        
        
        selecBtn.frame = CGRectMake(50, 12.5, 25, 25)
        selecBtn.setImage(UIImage(named: "deseleted"), forState: UIControlState.Normal)
        selecBtn.setImage(UIImage(named: "selected"), forState: UIControlState.Selected)
        selecBtn.addTarget(self, action: #selector(self.selecAllBtnClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        footerView.addSubview(selecBtn)
        
        
        //初始化补签按钮
        let selectAllbtn = UIButton()
        selectAllbtn.cornerRadius = 10
        selectAllbtn.frame = CGRectMake(WIDTH - 75, 10, 70, 30)
        selectAllbtn.backgroundColor = UIColor(red: 155/255.0, green: 229 / 255.0, blue: 180 / 255.0, alpha: 1.0)
        selectAllbtn.setTitle("补签", forState: UIControlState.Normal)
        selectAllbtn.addTarget(self, action: #selector(self.footerSelectAllBtnClick), forControlEvents: UIControlEvents.TouchUpInside)
        footerView.addSubview(selectAllbtn)

        
    }
    //MARK: 加载数据
    func loadData(sign_date : String){
        
        //  http://wxt.xiaocool.net/index.php?g=apps&m=teacher&a=GetStudentAttendanceList&classid=1&sign_date=1469462400
        //
        //下面两hid句代码是从缓存中取出userid（入参）值
        let defalutid = NSUserDefaults.standardUserDefaults()
        let chid = defalutid.stringForKey("classid")
    
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=teacher&a=GetStudentAttendanceList"
        let param = [
            "classid":chid!,
            "sign_date":sign_date
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
                    
                    self.dataSource.objectlist.removeAll()
                    self.dataSource = ClassKaoQinList(status.data!)
                    
                    //判断人数
                    var dao = 0
                    var weidao = 0
                    for item in self.dataSource.objectlist{
                        if item.checkedType == "0"{
                            dao = dao + 1
                        }
                        if item.checkedType == "1" || item.checkedType == "2"{
                            weidao = weidao + 1
                        }
                    }
                    
                    self.sumCount.text = "总人数:\(self.dataSource.objectlist.count)"
                    self.shiDaoCount.text = "未到人数:\(weidao)"
                    self.qingJiaCount.text = "请假人数:\(self.dataSource.objectlist.count-dao-weidao)"
                    self.avatorCollection.reloadData()
                    self.avatorCollection.headerView?.endRefreshing()
                }
            }
        }
    }
    //MARK: collectionView代理
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.objectlist.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:AvatorCollectionViewCell  = avatorCollection!.dequeueReusableCellWithReuseIdentifier("AvatorCell", forIndexPath: indexPath) as! AvatorCollectionViewCell
        cell.photo.frame = CGRectMake(0,0,50,50)
        
        let imgUrl = imageUrl + self.dataSource.objectlist[indexPath.row].photo!;
        let url = NSURL(string: imgUrl)
        cell.photo.yy_setImageWithURL(url, placeholder: UIImage(named: "图片默认加载"))
        cell.photo.layer.cornerRadius = 25
        cell.photo.layer.masksToBounds = true
        cell.nameLabel.frame = CGRectMake(0, 50, 50, 15)
        cell.nameLabel.font = UIFont.systemFontOfSize(12)
        cell.nameLabel.textAlignment = .Center
        cell.nameLabel.text = self.dataSource.objectlist[indexPath.row].name
        cell.flag.frame = CGRectMake(30, 30, 20, 20)
        
        if (self.dataSource.objectlist[indexPath.row].checkedType=="0"){
            cell.flag.hidden = false
            cell.flag.image = UIImage(named: "")
        }else if(self.dataSource.objectlist[indexPath.row].checkedType=="1"){
            cell.flag.hidden = false
            cell.flag.image = UIImage(named: "ic_wei")
        }else if (self.dataSource.objectlist[indexPath.row].checkedType=="2"){
            cell.flag.hidden = false
            cell.flag.image = UIImage(named: "ic_qian")
        }else {
            cell.flag.hidden = false
            cell.flag.image = UIImage(named: "ic_jia-2")
        }

        cell.contentView.addSubview(cell.nameLabel)
        cell.contentView.addSubview(cell.photo)
        cell.contentView.addSubview(cell.flag)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        return CGSizeMake(50,65)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10, 10, 10, 10)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if(self.dataSource.objectlist[indexPath.row].checkedType=="1"){
           self.dataSource.objectlist[indexPath.row].checkedType="2"
        }else if (self.dataSource.objectlist[indexPath.row].checkedType=="2"){
           self.dataSource.objectlist[indexPath.row].checkedType="1"
        }
        
        getSelectedStedents()
        self.avatorCollection.reloadData()

    }
    func getSelectedStedents(){
        self.selectedStu.removeAllObjects()
        for model in self.dataSource.objectlist{
            if (model.checkedType=="2"){
               self.selectedStu.addObject(model.userid!)
            }
        }
       
        var flag = 0;
        for item in self.dataSource.objectlist {
            if item.checkedType == "1" {
                flag = 1
            }
        }
        if (flag==0){
            
            selecBtn.selected = true
        }else {
            selecBtn.selected = false
        }
        ids = self.selectedStu.componentsJoinedByString(",")
        
        self.avatorCollection.reloadData()
    }
    
    //MARK: 点击 事件
    func NextDay(){
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let stringday = dateFormatter.dateFromString(self.timeLabel.text!)
        let theDayAfterTomorrow = stringday!.dateByAddingTimeInterval(24*60*60)
        let tomorrow = dateFormatter.stringFromDate(theDayAfterTomorrow)
        
        let today:NSDate = NSDate()
        let todaydateFormatter = NSDateFormatter()
        todaydateFormatter.dateFormat = "yyyy-MM-dd"
        let todaydate = todaydateFormatter.stringFromDate(today)
        if  self.timeLabel.text == todaydate{
            let alert = UIAlertView(title: "提示", message: "选择日期不能大于当前日期", delegate: self, cancelButtonTitle: "确定")
            alert.show()
            
        }else{
            timeLabel.text = tomorrow
            dateSelect = tomorrow
            let sign_date = "\(dateSelect!)-00-00-00"
            loadData(stringToTimeStamp(sign_date))
        
        }
        
       
    }
    
    func LastDay(){
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let stringday = dateFormatter.dateFromString(self.timeLabel.text!)
        let theYesterday = stringday!.dateByAddingTimeInterval(-24*60*60)
        let yesterday = dateFormatter.stringFromDate(theYesterday)
        timeLabel.text = yesterday
        dateSelect = yesterday
        let sign_date = "\(dateSelect!)-00-00-00"
        loadData(stringToTimeStamp(sign_date))
    }
    
    func LastMonth(){
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let stringday = dateFormatter.dateFromString(self.timeLabel.text!)
        let theLastMonth = stringday!.dateByAddingTimeInterval(-24*60*60*30)
        let lastMonth = dateFormatter.stringFromDate(theLastMonth)
        timeLabel.text = lastMonth
        dateSelect = lastMonth
        let sign_date = "\(dateSelect!)-00-00-00"
        loadData(stringToTimeStamp(sign_date))
    }
    
    func NextMonth(){
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let stringday = dateFormatter.dateFromString(self.timeLabel.text!)
        let theNextMonth = stringday!.dateByAddingTimeInterval(24*60*60*30)
        let nextMonth = dateFormatter.stringFromDate(theNextMonth)
        timeLabel.text = nextMonth
        dateSelect = nextMonth
        let sign_date = "\(dateSelect!)-00-00-00"
       loadData(stringToTimeStamp(sign_date))
    }


    func selecAllBtnClick(sender:UIButton) -> Void {
    
        if sender.selected {
            sender.selected = false
            for item in self.dataSource.objectlist {
                if item.checkedType == "2" {
                    item.checkedType = "1"
                }
            }
          
        }else{
            sender.selected = true
            for item in self.dataSource.objectlist {
                if item.checkedType == "1" {
                    item.checkedType = "2"
                }
            }
        }
        
        self.avatorCollection.reloadData()
    }

    //补签
    func footerSelectAllBtnClick() -> Void {
    
        getSelectedStedents()
        let defalutid = NSUserDefaults.standardUserDefaults()
//        let chid = defalutid.stringForKey("userid")
        let schoolid = defalutid.stringForKey("schoolid")
        
        //http://wxt.xiaocool.net/index.php?g=apps&m=index&a=resign&userid=597,605&schoolid=1
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=index&a=resign"
        print(ids)
        let param = [
            "userid":ids!,
            "schoolid":schoolid!
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
         
                    let sign_date = "\(self.dateSelect!)-00-00-00"
                    self.loadData(stringToTimeStamp(sign_date))
                    
                    self.avatorCollection.headerView?.endRefreshing()
                }
            }
        }

        avatorCollection.reloadData()
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
