//
//  FoodMenuViewController.swift
//  WXT_Parents
//
//  Created by zhang on 16/6/2.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

class FoodMenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    var dateLbl=UILabel()
    let table = UITableView()
    //  数据源
    var dataSourse = FoodMenuModel()
    //  开始时间戳
    var Monday = Int()
    //  结束时间戳
    var Sunday = Int()
    var oneAry = NSMutableArray()
    var twoAry = NSMutableArray()
    var ThreeAry = NSMutableArray()
    var FourAry = NSMutableArray()
    var finveAry = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="每周食谱"
        self.view.backgroundColor=UIColor.whiteColor()
        dateLbl.frame=CGRectMake(frame.width/4, 0, frame.width/2, 40)
        dateLbl.textAlignment = .Center
        self.view.addSubview(dateLbl)
        let lastBT = UIButton(frame: CGRectMake(frame.width/5,10,20,20))
        lastBT.addTarget(self, action: #selector(LastWeekAction(_:)), forControlEvents: .TouchUpInside)
        lastBT.setImage(UIImage(named: "上一天"), forState: .Normal)
        self.view.addSubview(lastBT)
        let nextBT = UIButton(frame: CGRectMake(frame.width-(frame.width/5+20),10,20,20))
        nextBT.setImage(UIImage(named: "下一天"), forState:.Normal)
        nextBT.addTarget(self, action: #selector(nextWeekAction(_:)), forControlEvents: .TouchUpInside)
        self.view.addSubview(nextBT)
        
//      得到当前日期
        nowDate()
//      得到时间戳
        GETDate()
//      隐藏标签栏
        self.tabBarController?.tabBar.hidden = true
        self.createTable()
//      请求数据
        GET(Sunday, begindate:Monday)
        
    }
    func LastWeekAction(sender: AnyObject) {
        //  获取上一周食谱
//        GET(9999, begindate: 1111)
        //  先得到上周一的时间
        Monday -= 7 * 86400
        GETDateTime(Monday)
        let nSunday = Monday + 7 * 86400 - 1
        GET(nSunday, begindate: Monday)
        table.reloadData()
        //  变成日期
    }
    func nextWeekAction(sender: AnyObject) {
        //  获取下一周食谱
        //  先得到下周一的时间
        Monday += 7 * 86400
        GETDateTime(Monday)
        let nSunday = Monday + 7 * 86400 - 1
        GET(nSunday, begindate: Monday)
        table.reloadData()

    }

    func GETDateTime(seconds:Int){
        let mondayInterval:NSTimeInterval = NSTimeInterval(seconds)
        let mondayDate = NSDate(timeIntervalSince1970: mondayInterval)
    
        //格式话输出
        let dformatter = NSDateFormatter()
        dformatter.dateFormat = "yyyy-MM-dd"
        print("对应的日期时间：\(dformatter.stringFromDate(mondayDate))")
        dateLbl.text = dformatter.stringFromDate(mondayDate)

    }
    func nowDate(){
        let nowDate = NSDate()
        let dateformatter = NSDateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"
        dateLbl.text = dateformatter.stringFromDate(nowDate)
        
    }
    func GETDate(){
        //  获取当前时间
        let now = NSDate()
        //  获取日期
//        _ = now.day
        //  日期格式
        let dateformatter = NSDateFormatter()
        dateformatter.dateFormat = "HH:mm:ss"
        print("当前日期时间：\(dateformatter.stringFromDate(now))")
        
        //  获取当前时间戳
        let timeInterval:NSTimeInterval = now.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        print("当前时间的时间戳：\(timeStamp)")
        //  1468982524
        
        //  获取当前星期几
        let days = Int(timeStamp/86400) // 24*60*60
        let weekday = ((days + 4)%7+7)%7
        print( weekday == 0 ? 7 : weekday)
        
        let nowString = dateformatter.stringFromDate(now)
        //  获得小时 分 秒
        let hours:Int = Int((nowString as NSString).substringWithRange(NSMakeRange(0, 2)))!
        
        let points:Int = Int((nowString as NSString).substringWithRange(NSMakeRange(3, 2)))!
        let seconds:Int = Int((nowString as NSString).substringWithRange(NSMakeRange(6, 2)))!
        //  得到这个周的周一日期
        let mondaySeconds = (weekday - 1) * 86400 + hours * 60 * 60 + points * 60 + seconds
        print(mondaySeconds)
        
        //  时间戳1
        Monday = timeStamp - mondaySeconds
        //转换为时间
        let mondayInterval:NSTimeInterval = NSTimeInterval(Monday)
        let mondayDate = NSDate(timeIntervalSince1970: mondayInterval)
        
        //格式话输出
        let dformatter = NSDateFormatter()
        dformatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
        print("对应的日期时间：\(dformatter.stringFromDate(mondayDate))")
        
        //  得到这个周的周日(23:59:59)
        let SundaySeconds = 7 * 86400 - mondaySeconds - 1
        print(SundaySeconds)
        //  时间戳2
        Sunday = timeStamp + SundaySeconds
        
        //转换为时间
        let SundayInterval:NSTimeInterval = NSTimeInterval(Sunday)
        let SundayDate = NSDate(timeIntervalSince1970: SundayInterval)
        
        //格式话输出
        print("对应的日期时间：\(dformatter.stringFromDate(SundayDate))")

    }

//    创建表
    func GET(enddate:Int,begindate:Int){
//        http://wxt.xiaocool.net/index.php?g=apps&m=school&a=getCookbookContent&schoolid=1&begindate=111&enddate=99999999999
        //  得到url
        //
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=school&a=getCookbookContent"
        let school = NSUserDefaults.standardUserDefaults()
        let schoolid = school.stringForKey("schoolid")
        //  得到请求体
        let param = [
            
            "enddate":enddate,
            "begindate":begindate,
            "schoolid":schoolid!
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
                    }
                    if(status.status == "success"){
                        print("请求成功")
                        self.oneAry.removeAllObjects()
                        self.twoAry.removeAllObjects()
                        self.ThreeAry.removeAllObjects()
                        self.FourAry.removeAllObjects()
                        self.finveAry.removeAllObjects()
                        self.dataSourse = FoodMenuModel(status.data!)
                        print(self.dataSourse.count)
                        
                        if self.dataSourse.count != 0{
                        for item in 0...self.dataSourse.count-1{
                            let foodinfo=self.dataSourse.objectlist[item]
                            //  获取当前星期几
                            let days = Int(NSInteger(foodinfo.date!)!/86400) // 24*60*60
                            let weekday = ((days + 4)%7+7)%7
                            
                            if weekday==0{
                                self.oneAry.addObject(foodinfo)
                                
                            }else if weekday==1{
                                self.twoAry.addObject(foodinfo)
                            }else if weekday==2{
                                self.ThreeAry.addObject(foodinfo)
                            }else if weekday==3{
                                self.FourAry.addObject(foodinfo)
                            }else if weekday==4{
                                self.finveAry.addObject(foodinfo)
                            }
                          
                            }}
                        self.table.reloadData()
                    }
                }
        }
 
                
        
        
        //  请求成功
        //  请求失败
        
    }
    func createTable(){
        table.frame = CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height-64-50)
        table.delegate = self
        table.dataSource = self
        
//        table.separatorStyle = .None//分割线
        self.view.addSubview(table)
//        注册cell
        table.registerNib(UINib.init(nibName: "FoodMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "FoodMenuCell")
    }
//    分区数
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 5
    }
//    分区标题
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "星期一"
        }
        if section == 1 {
            return "星期二"
        }
        if section == 2 {
            return "星期三"
        }
        if section == 3 {
            return "星期四"
        }
        if section == 4 {
            return "星期五"
        }
        return ""
    }
//    行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if section==0 {
            return oneAry.count
            
        }else if section==1{
            return twoAry.count
        }else if section==2{
            return ThreeAry.count
        }
        else if section==3{
            return FourAry.count
        }
        else {
            return finveAry.count
        }

    }
//    单元格
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var info = FoodMenuInfo()
        //从数组中拿出数据
        if indexPath.section==0 {
            info = (oneAry.objectAtIndex(indexPath.row) as? FoodMenuInfo)!
        }else if indexPath.section==1 {
            info = (twoAry.objectAtIndex(indexPath.row) as? FoodMenuInfo)!
        }else if indexPath.section==2 {
            info = (ThreeAry.objectAtIndex(indexPath.row) as? FoodMenuInfo)!
        }else if indexPath.section==3 {
            info = (FourAry.objectAtIndex(indexPath.row) as? FoodMenuInfo)!
        }else if indexPath.section==4 {
            info = (finveAry.objectAtIndex(indexPath.row) as? FoodMenuInfo)!
        }
        //cell的自定义
        let zaowucanL = UILabel(frame: CGRectMake(10,10,70,20))
        zaowucanL.textColor=UIColor.grayColor()
        zaowucanL.font=UIFont.systemFontOfSize(15)
        zaowucanL.text=info.title
        cell.contentView.addSubview(zaowucanL)
        let foodnameL = UILabel(frame: CGRectMake(90,10,frame.width-110,20))
        foodnameL.text=info.content
        cell.contentView.addSubview(foodnameL)
        var image_h = 0
        //添加图片
        if info.photo != nil {
            image_h=100
            let foodIV = UIImageView(frame: CGRectMake(90, 40, 80, 80))
            let str = pictureUrl+info.photo!
            let url = NSURL(string: str)
            foodIV.yy_setImageWithURL(url, placeholder: UIImage(named: "Logo"))
            cell.contentView.addSubview(foodIV)
        }
        tableView.rowHeight=40+CGFloat(image_h)
        return cell
    }
}
