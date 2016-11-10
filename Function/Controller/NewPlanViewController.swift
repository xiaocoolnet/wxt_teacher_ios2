//
//  NewPlanViewController.swift
//  WXT_Teacher
//
//  Created by 李春波 on 16/3/31.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import MBProgressHUD
import Alamofire
class NewPlanViewController: UIViewController {
    
    var type :Int?
    var plan = planInfo()
    let titleView = UITextField()
    let timeLabel1 = UILabel()
    let ed1 = BRPlaceholderTextView()
    let ed2 = BRPlaceholderTextView()
    let ed3 = BRPlaceholderTextView()
    let ed4 = BRPlaceholderTextView()
    let ed5 = BRPlaceholderTextView()
    let ed6 = BRPlaceholderTextView()
    let ed7 = BRPlaceholderTextView()
    let ed8 = BRPlaceholderTextView()
    var begintime : String?
    var endtime : String?
    override func viewDidLoad() {
        super.viewDidLoad()

      self.view.backgroundColor = UIColor.whiteColor()
        loadSubviews()
        // Do any additional setup after loading the view.
    }

    func loadSubviews(){
        let scrolView = UIScrollView()
        scrolView.frame = CGRectMake(0, 0, WIDTH, HEIGHT)
        self.view.addSubview(scrolView)

        

        
        //titleview
        titleView.frame  = CGRectMake(0, 0, WIDTH, 50)
        titleView.placeholder = "请输入标题"
        titleView.textAlignment = NSTextAlignment.Center
        scrolView.addSubview(titleView)
        
        //时间
        let timeView = UIButton()
        timeView.frame = CGRectMake(0, titleView.frame.maxY, WIDTH, 50)
        scrolView.addSubview(timeView)
        
        
        timeLabel1.text = "开始时间 - 结束时间"
        timeLabel1.textAlignment = NSTextAlignment.Center
        timeLabel1.frame = CGRectMake(40, 0, WIDTH-80, 50)
        timeView.addSubview(timeLabel1)
        
        timeView.addTarget(self, action: #selector(NewPlanViewController.time), forControlEvents: UIControlEvents.TouchUpInside)
        
        //workpoint 
        let v1 = UIView()
        v1.frame = CGRectMake(5, timeView.frame.maxY, WIDTH-10, 100)
        scrolView.addSubview(v1)
        
        let v11 = UILabel()
        v11.frame = CGRectMake(0, 0, 80, 30)
        v11.text = "要点"
        v1.addSubview(v11)
        
 
        ed1.frame = CGRectMake(v11.frame.maxX, 0, WIDTH-v11.frame.width-10, 90)
        ed1.placeholder = "要点输入"
        v1.addSubview(ed1)
        

        
        //星期一
        let v2 = UIView()
        v2.frame = CGRectMake(5, v1.frame.maxY, WIDTH-10, 100)
        scrolView.addSubview(v2)
        
        let v21 = UILabel()
        v21.frame = CGRectMake(0, 0, 80, 30)
        v21.text = "星期一"
        v2.addSubview(v21)
        
   
        ed2.frame = CGRectMake(v11.frame.maxX, 0, WIDTH-v21.frame.width-10, 90)
        ed2.placeholder = "星期一输入"
        v2.addSubview(ed2)
        
        
        //星期二
        let v3 = UIView()
        v3.frame = CGRectMake(5, v2.frame.maxY, WIDTH-10, 100)
        scrolView.addSubview(v3)
        
        let v31 = UILabel()
        v31.frame = CGRectMake(0, 0, 80, 30)
        v31.text = "星期二"
        v3.addSubview(v31)
        
 
        ed3.frame = CGRectMake(v11.frame.maxX, 0, WIDTH-v31.frame.width-10, 90)
        ed3.placeholder = "星期二输入"
        v3.addSubview(ed3)
        
        
        //星期三
        let v4 = UIView()
        v4.frame = CGRectMake(5, v3.frame.maxY, WIDTH-10, 100)
        scrolView.addSubview(v4)
        
        let v41 = UILabel()
        v41.frame = CGRectMake(0, 0, 80, 30)
        v41.text = "星期三"
        v4.addSubview(v41)
        
        
        ed4.frame = CGRectMake(v11.frame.maxX, 0, WIDTH-v41.frame.width-10, 90)
        ed4.placeholder = "星期三输入"
        v4.addSubview(ed4)
        
        
        //星期四
        let v5 = UIView()
        v5.frame = CGRectMake(5, v4.frame.maxY, WIDTH-10, 100)
        scrolView.addSubview(v5)
        
        let v51 = UILabel()
        v51.frame = CGRectMake(0, 0, 80, 30)
        v51.text = "星期四"
        v5.addSubview(v51)
        
        
        ed5.frame = CGRectMake(v11.frame.maxX, 0, WIDTH-v51.frame.width-10, 90)
        ed5.placeholder = "星期四输入"
        v5.addSubview(ed5)
        
        
        //星期五
        let v6 = UIView()
        v6.frame = CGRectMake(5, v5.frame.maxY, WIDTH-10, 100)
        scrolView.addSubview(v6)
        
        let v61 = UILabel()
        v61.frame = CGRectMake(0, 0, 80, 30)
        v61.text = "星期五"
        v6.addSubview(v61)
        
       
        ed6.frame = CGRectMake(v11.frame.maxX, 0, WIDTH-v61.frame.width-10, 90)
        ed6.placeholder = "星期五输入"
        v6.addSubview(ed6)
        
        
        //星期六
        let v7 = UIView()
        v7.frame = CGRectMake(5, v6.frame.maxY, WIDTH-10, 100)
        scrolView.addSubview(v7)
        
        let v71 = UILabel()
        v71.frame = CGRectMake(0, 0, 80, 30)
        v71.text = "星期六"
        v7.addSubview(v71)
        
        ed7.frame = CGRectMake(v11.frame.maxX, 0, WIDTH-v71.frame.width-10, 90)
        ed7.placeholder = "星期六输入"
        v7.addSubview(ed7)
        
        //星期日
        let v8 = UIView()
        v8.frame = CGRectMake(5, v7.frame.maxY, WIDTH-10, 100)
        scrolView.addSubview(v8)
        
        let v81 = UILabel()
        v81.frame = CGRectMake(0, 0, 80, 30)
        v81.text = "星期日"
        v8.addSubview(v81)
        
        let ed8 = BRPlaceholderTextView()
        ed8.frame = CGRectMake(v11.frame.maxX, 0, WIDTH-v81.frame.width-10, 90)
        ed8.placeholder = "星期日输入"
        v8.addSubview(ed8)
        if type==1 {
            titleView.text = plan.title
            ed1.text = plan.workpoint
            ed2.text = plan.monday
            ed3.text = plan.tuesday
            ed4.text = plan.wednesday
            ed5.text = plan.thursday
            ed6.text = plan.friday
            ed7.text = plan.saturday
            ed8.text = plan.sunday
            timeLabel1.text = "\(changeTime(plan.begintime!))到\(changeTime(plan.endtime!))"
        }
       
       scrolView.contentSize = CGSizeMake(WIDTH, 100*8+50)
        
        let rightItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(NewPlanViewController.finish))
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    func finish(){
    
        if (self.titleView.text!.isEmpty)  {
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.mode = MBProgressHUDMode.Text
            hud.labelText = "标题不能为空"
            hud.margin = 10.0
            hud.removeFromSuperViewOnHide = true
            hud.hide(true, afterDelay: 3)
        }else if begintime==nil||endtime==nil{
        
        
        
        
        }else{
            var url = ""
            if type == 0 {
                url = "http://wxt.xiaocool.net/index.php?g=apps&m=school&a=publishschoolplan"
            }else{
                url = "http://wxt.xiaocool.net/index.php?g=apps&m=school&a=updataschoolplan"
            }
            
            let schoolid = NSUserDefaults.standardUserDefaults().stringForKey("schoolid")
            let classid = NSUserDefaults.standardUserDefaults().stringForKey("classid")
            let userid = NSUserDefaults.standardUserDefaults().stringForKey("userid")
            
            var param = [
                "schoolid":schoolid,
                "classid":classid,
                "userid":userid,
                "title":titleView.text ?? "",
                "monday":ed2.text ?? "",
                "tuesday":ed3.text ?? "",
                "wednesday":ed4.text ?? "",
                "thursday":ed5.text ?? "",
                "friday":ed6.text ?? "",
                "saturday":ed7.text ?? "",
                "sunday":ed8.text ?? "",
                "workpoint":ed1.text ?? "",
                "begintime":begintime ?? "",
                "endtime":endtime ?? ""
            ]
            
            if type == 1{
            
                param = [
                    "id":plan.id,
                    "schoolid":schoolid,
                    "classid":classid,
                    "userid":userid,
                    "title":titleView.text ?? "",
                    "monday":ed2.text ?? "",
                    "tuesday":ed3.text ?? "",
                    "wednesday":ed4.text ?? "",
                    "thursday":ed5.text ?? "",
                    "friday":ed6.text ?? "",
                    "saturday":ed7.text ?? "",
                    "sunday":ed8.text ?? "",
                    "workpoint":ed1.text ?? "",
                    "begintime":begintime ?? "",
                    "endtime":endtime ?? ""
                ]

            }
                
            Alamofire.request(.GET, url, parameters: param as! [String:String]).response { request, response, json, error in
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
                        print("0")
                    }
                    if(status.status == "success"){
                        print(status.data)
                        self.navigationController?.popViewControllerAnimated(true)
                    }
                }
            }

        
        
        }
    }
    
    func time(){
        let vc = CalendarFirstViewController()
        self.presentViewController(vc, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let chuanzhi = NSUserDefaults.standardUserDefaults()
        print(chuanzhi.valueForKey("startTime"))
        print(chuanzhi.valueForKey("endTime"))
        if chuanzhi.valueForKey("startTime")==nil||chuanzhi.valueForKey("endTime")==nil {
            
        }else{
            timeLabel1.text = "\(chuanzhi.valueForKey("startTime")!)到\(chuanzhi.valueForKey("endTime")!)"
            begintime = stringToTimeStamp("\(chuanzhi.valueForKey("startTime")!)-00-00-00")
            endtime = stringToTimeStamp("\(chuanzhi.valueForKey("endTime")!)-00-00-00")
        }
       
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSUserDefaults.standardUserDefaults().removeObjectForKey("startTime")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("endTime")
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
