//
//  QKClassAblumTableViewController.swift
//  WXT_Teacher
//
//  Created by xiaocool on 16/9/4.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
class QKClassAblumTableViewController: UITableViewController {
    private  var TopView=UIView()        //头顶view
    private var btnleft=UIButton()      //上一月
    private  var btnriright=UIButton()   //下一月
    private  var btnyyyymmdd=UIButton()  //年月日
    
    private var btnSelected=UIButton()  //选中
    private  var btnCancel=UIButton()    //取消
    
    private  var nowDate: NSDate = NSDate()  //当前日期
    private  var getOneweek=0    //获取到年月的1号是周几
    private  var daycount=0        //获取到年月的总天数
    var startday = Int()
    //  结束时间戳
    var endday = Int()
    
    
    
    var dataSource = ClassAlbumList()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        TopView.frame=CGRect(x:0, y: 0, width: WIDTH, height: 70)
        TopView.backgroundColor=UIColor.whiteColor()
   
        let  _width1 = (TopView.frame.width*(1+1)-TopView.frame.width) / CGFloat(3) //整个TopView宽度的100% / 3
        for (var i:Int=0 ; i<3 ; i++){
            
            var str=""
            switch(i){
            case 0: str="◀"
            btnleft.frame=CGRect(x: CGFloat(i)*_width1, y: TopView.frame.height-60, width: _width1, height: 30)
            btnleft.titleLabel?.font=UIFont.systemFontOfSize(20)
            btnleft.setTitleColor(UIColor.blueColor(), forState: .Normal)
            btnleft.setTitle(str, forState: .Normal)
            TopView.addSubview(btnleft)
                break
            case 1: str="nyyyymmdd"
            btnyyyymmdd.frame=CGRect(x: CGFloat(i)*_width1, y: TopView.frame.height-60, width: _width1, height: 30)
            btnyyyymmdd.titleLabel?.font=UIFont.boldSystemFontOfSize(15)
            btnyyyymmdd.setTitleColor(UIColor(red: 50/255, green: 205/255, blue: 50/255, alpha: 1), forState: .Normal)
             btnyyyymmdd.setTitle("\(nowDate.currentYear)年\(nowDate.currentMonth)月", forState: .Normal) //更改年月
            TopView.addSubview(btnyyyymmdd)
                break
            case 2: str="▶"
            btnriright.frame=CGRect(x: CGFloat(i)*_width1, y: TopView.frame.height-60, width: _width1, height: 30)
            btnriright.titleLabel?.font=UIFont.systemFontOfSize(20)
            btnriright.setTitleColor(UIColor.blueColor(), forState: .Normal)
            btnriright.setTitle(str, forState: .Normal)
            
            TopView.addSubview(btnriright)
                break
            default:
                break
            }
            
        }
        btnleft.addTarget(self, action: #selector(self.btnleft_Click), forControlEvents: .TouchUpInside)
        btnriright.addTarget(self, action: #selector(self.btnriright_Click), forControlEvents: .TouchUpInside)
        self.tableView.tableHeaderView =  TopView

      initLoadDate()
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
        btnyyyymmdd.setTitle((string as NSString).substringToIndex(7), forState: UIControlState.Normal)
       
        print("888888888888")
        print(string)
        
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
        btnyyyymmdd.setTitle((string as NSString).substringToIndex(7), forState: UIControlState.Normal)
        
        print("888888888888")
        print(string)
        GET(endday, begindate: startday)
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
    
    func GET(enddate:Int,begindate:Int){
        //        http://wxt.xiaocool.net/index.php?g=apps&m=student&a=GetTeacherComment&studentid=661&begintime=0&endtime=1469863987
        //  得到url
        
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=school&a=ClassPicInfo"
        let student = NSUserDefaults.standardUserDefaults()
        let schoolid =  student.stringForKey("schoolid")
        print(schoolid)
        //  得到请求体
        let param = [
            "schoolid":schoolid!
        ]
        
        Alamofire.request(.GET, url, parameters: param).response
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
                        self.dataSource = ClassAlbumList(status.data!)
                        self.tableView.reloadData()
                    }
                }
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

  

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.dataSource.objectlist.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("ablumQinkuang")
        var contentLabel : UILabel?
        
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "ablumQinkuang")
            contentLabel = UILabel()
            contentLabel!.frame = CGRectMake(WIDTH-70, 5, 50, 40)
            contentLabel!.font = UIFont.systemFontOfSize(15)
            cell?.contentView.addSubview(contentLabel!)
        }
        
        cell?.textLabel?.text = self.dataSource.objectlist[indexPath.row].classname
        contentLabel?.text = "\(self.dataSource.objectlist[indexPath.row].class_count!)条"

        cell?.accessoryType = .DisclosureIndicator
        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = QKAblumDetailTableViewController()
        vc.ablumInfo = self.dataSource.objectlist[indexPath.row].teacher_info
        vc.tableView.reloadData()
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
