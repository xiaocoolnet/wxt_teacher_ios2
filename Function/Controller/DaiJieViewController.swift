//
//  DaiJieViewController.swift
//  WXT_Teacher
//
//  Created by 李春波 on 16/3/9.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
import MJRefresh
class DaiJieViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    let dataTableView = UITableView()
    var DaijieSource = DaijieModel()
    var array = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "代接确认"
        self.view.backgroundColor = UIColor.whiteColor()
        dataTableView.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height - 104)
        dataTableView.delegate = self
        dataTableView.dataSource = self
        self.automaticallyAdjustsScrollViewInsets = false
        self.tabBarController?.tabBar.hidden = true
        self.view.addSubview(dataTableView)
        self.dataTableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { 
            self.loadData()
            self.dataTableView.mj_header.endRefreshing()
        })
        self.dataTableView.mj_header.beginRefreshing()
    }
    //MARK: -    获取数据
    func loadData(){

        let defalutid = NSUserDefaults.standardUserDefaults()
        
        let userid = defalutid.stringForKey("userid")
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=teacher&a=gettransportconfirmation"
        let param = [
            "teacherid":userid
        ]
        Alamofire.request(.GET, url, parameters: param as?[String:String]).response { request, response, json, error in
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
                    self.DaijieSource=DaijieModel(status.data!)
                    if self.DaijieSource.count != 0{
                    for item in 1...self.DaijieSource.count{
                    let daijieinfo=self.DaijieSource.parentsExhortList[item-1]
                      if  daijieinfo.delivery_status=="0"{
                        self.array.addObject(daijieinfo)
                        
                        }
               
                        }}
                    self.dataTableView.reloadData()
    
                }
            }
        }
    }
    

    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  
                return self.array.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = QCTakeBabyCell(style: .Default, reuseIdentifier: String(indexPath.row))
       
        cell.selectionStyle = .None
        let daijieinfo = self.array[indexPath.row] as! DaijieInfo
        
        
        //        赋值
       
        //        时间戳转换

            let dateformate = NSDateFormatter()
            dateformate.dateFormat = "yyyy-MM-dd HH:mm"
            let date = NSDate(timeIntervalSince1970: NSTimeInterval(daijieinfo.delivery_time!)!)
            let str:String = dateformate.stringFromDate(date)
            cell.timeLabel.text = str
            
            cell.nameLabel
                .text = daijieinfo.studentname
        
        
            //        图片
            let imgUrl = pictureUrl + daijieinfo.photo!
            let photourl = NSURL(string: imgUrl)
            cell.bigImageView.yy_setImageWithURL(photourl, placeholder: UIImage(named: "4"))
           //        头像
            let imgUrl1 = imageUrl + daijieinfo.parentavatar!
            let headImageurl = NSURL(string: imgUrl1)
            cell.headImageView.yy_setImageWithURL(headImageurl, placeholder: UIImage(named: "4"))
        
           cell.banjiLable.text=daijieinfo.classname!
            cell.somebodyLabel.text = daijieinfo.content
        //        同意按钮
            cell.agreeBtn.addTarget(self, action: #selector(agreePress(_:)), forControlEvents: .TouchUpInside)
            cell.agreeBtn.tag = indexPath.row
            //        不同意按钮
            cell.disagreeBtn.addTarget(self, action: #selector(disagreePress(_:)), forControlEvents: .TouchUpInside)
        if daijieinfo.parentphone != nil {
            cell.disagreeBtn.tag = Int(daijieinfo.parentphone!)!
        }
        
            //  cell 的高度
            tableView.rowHeight = 450
        return cell
    }
    //MARK: - 提醒事件
    func agreePress(sender:UIButton){
        
    }
    //MARK: - 呼叫事件
    func disagreePress(sender:UIButton){
        if sender.tag == 0 {
            
        }else{
            let alertController=UIAlertController(title: "", message: "呼叫\(sender.tag)", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "确定", style: .Default,
                                         handler: {
                                            action in
                                            UIApplication.sharedApplication().openURL(NSURL(string :"tel://\(sender.tag)")!)
                                            
                                            
            })
            let cancelAction = UIAlertAction(title: "取消", style: .Default, handler: nil)
            alertController.addAction(cancelAction)
            
            alertController.addAction(okAction)
            
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }

    }
    func TiXingJiaZhang(){
        let tixingjiazhang = TiXingJiaZhangViewController()
        self.navigationController?.pushViewController(tixingjiazhang, animated: true)
    }
    func TiXing(){
        let tixing = TiXingViewController()
        self.navigationController?.pushViewController(tixing, animated: true)
        let url = apiUrl+"DeliveryVerify"
        let defalutid = NSUserDefaults.standardUserDefaults()
        
        let userid = defalutid.stringForKey("userid")
        let param = [
            "userid" : userid
        ]
        Alamofire.request(.GET, url, parameters: param as? [String:String]).response { request, response, json, error in
            if(error != nil){
            }
            else{
                print("request是")
                print(request!)
                print("====================")
                let status = MineModel(JSONDecoder(json!))
                print("状态是")
                print(status.status)
                if(status.status == "error"){
                    let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                    hud.mode = MBProgressHUDMode.Text;
                    hud.labelText = status.errorData
                    hud.margin = 10.0
                    hud.removeFromSuperViewOnHide = true
                    hud.hide(true, afterDelay: 1)
                }
                if(status.status == "success"){
                    print("Success")

                }
            }
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.loadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
