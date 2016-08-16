//
//  YDaiJieViewController.swift
//  WXT_Teacher
//
//  Created by xiaocool on 16/7/29.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
import XWSwiftRefresh
class YDaiJieViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
        
        let dataTableView = UITableView()
        var DaijieSource = DaijieModel()
        var array = NSMutableArray()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            loadData()
            self.title = "代接确认"
            self.view.backgroundColor = UIColor.whiteColor()
            dataTableView.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height - 104)
            dataTableView.delegate = self
            dataTableView.dataSource = self
            self.automaticallyAdjustsScrollViewInsets = false
            self.tabBarController?.tabBar.hidden = true
            self.view.addSubview(dataTableView)
            
        }
        //MARK: -    获取数据
        func loadData(){
            
            //http://wxt.xiaocool.net/index.php?g=apps&m=teacher&a=gettransportconfirmation&teacherid=28
            
            //下面两句代码是从缓存中取出userid（入参）值
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
                        for item in 0...self.DaijieSource.count-1{
                            let daijieinfo=self.DaijieSource.parentsExhortList[item]
                            if  daijieinfo.delivery_status=="1" || daijieinfo.delivery_status=="2"{
                                self.array.addObject(daijieinfo)
                                
                            }
                            
                            }}
                        self.dataTableView.reloadData()
                        self.dataTableView.headerView?.endRefreshing()
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
            let imgUrl1 = imageUrl + daijieinfo.teacheravatar!
            let headImageurl = NSURL(string: imgUrl1)
            cell.headImageView.yy_setImageWithURL(headImageurl, placeholder: UIImage(named: "4"))
            
            cell.somebodyLabel.text = daijieinfo.studentname! + "家长，这个人可以接走孩子么？"

            cell.agreeBtn.userInteractionEnabled=false
            cell.disagreeBtn.userInteractionEnabled=false
            cell.agreeBtn.backgroundColor=UIColor.grayColor()
            cell.disagreeBtn.backgroundColor=UIColor.grayColor()
            
            //  cell 的高度
            tableView.rowHeight = 450
            return cell
        }
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }

        
}