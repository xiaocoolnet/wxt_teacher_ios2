//
//  HomeworkViewController.swift
//  WXT_Parents
//
//  Created by zhang on 16/4/27.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import Alamofire
import YYWebImage
import XWSwiftRefresh
import MBProgressHUD

class HomeworkViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    let table = UITableView()
    var homeworkSource = HomeworkList()
    var dianzanSource = DianZanList()
    var commentSource = HCommentList()
    let arrayPeople = NSMutableArray()
    
    override func viewWillAppear(animated: Bool) {
        self.DropDownUpdate()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的作业"
        self.createTable()
        
    }
//MARK: -   开始刷新
    func DropDownUpdate(){
        self.table.headerView = XWRefreshNormalHeader(target: self, action: #selector(HomeworkViewController.loadData))
        self.table.reloadData()
        self.table.headerView?.beginRefreshing()
    }
//MARK: -    创建表
    func createTable(){
        table.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64)
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .None
        self.view.addSubview(table)
         let rightItem=UIBarButtonItem(image: UIImage(named: "add3"), landscapeImagePhone: UIImage(named: "add3"), style: .Done, target: self, action: #selector(addHomework))
        self.navigationItem.rightBarButtonItem = rightItem
//    注册cell
        table.registerNib(UINib.init(nibName: "HomeworkTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeworkCellID")
    }
//MARK: -   获取作业列表
    func loadData(){
//        http://wxt.xiaocool.net/index.php?g=apps&m=teacher&a=gethomeworklist&userid=597&classid=1
       
        //下面两句代码是从缓存中取出userid（入参）值
        let defalutid = NSUserDefaults.standardUserDefaults()
        let uid = defalutid.stringForKey("userid")
        let classid = defalutid.stringForKey("classid")
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=teacher&a=gethomeworklist"
        let param = [
            "userid":uid!,
            "classid":classid!
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
                    self.homeworkSource = HomeworkList(status.data!)
                    self.table.reloadData()
                    self.table.headerView?.endRefreshing()
                }
            }
        }
    }
//MARK: -  分区数
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
//MARK: -   行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeworkSource.count
    }
//MARK: -     单元格
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HomeworkCellID", forIndexPath: indexPath)
            as! HomeworkTableViewCell
        cell.selectionStyle = .None
        let homeworkInfo = self.homeworkSource.homeworkList[indexPath.row]
        let dateformate = NSDateFormatter()
        dateformate.dateFormat = "yyyy-MM-dd HH:mm"
        
        cell.titleLbl.text = homeworkInfo.title
        cell.contentLbl.text = homeworkInfo.content

        let imgUrl = imageUrl + homeworkInfo.photo!
        let photourl = NSURL(string: imgUrl)
        cell.bigImageView.yy_setImageWithURL(photourl, placeholder: UIImage(named: "4"))
        cell.senderLbl.text = homeworkInfo.username
//MARK: -  已读
        cell.readBtn.setTitle("已读\(String(homeworkInfo.readcount!)) 未读\(String(homeworkInfo.allreader!-homeworkInfo.readcount!))", forState: .Normal)
        cell.readBtn.addTarget(self, action: #selector(HomeworkViewController.readBtn(_:)), forControlEvents: .TouchUpInside)
        cell.readBtn.tag = indexPath.row

        cell.dianzanBtn.setBackgroundImage(UIImage(named: "已点赞.png"), forState:.Selected)
        cell.dianzanBtn.tag = indexPath.row

        cell.pinglunBtn.tag = indexPath.row
//MARK: -  时间
        let date = NSDate(timeIntervalSince1970: NSTimeInterval(homeworkInfo.create_time!)!)
        let str:String = dateformate.stringFromDate(date)
        cell.timeLbl.text = str
        
//MARK: -  自适应行高
        let options : NSStringDrawingOptions = NSStringDrawingOptions.UsesLineFragmentOrigin
        let screenBounds:CGRect = UIScreen.mainScreen().bounds
        let boundingRect = String(cell.contentLbl.text).boundingRectWithSize(CGSizeMake(screenBounds.width, 0), options: options, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(17)], context: nil)
       
            table.rowHeight = boundingRect.size.height + 391
        
        
        return cell
    }
//MARK: -  跳转页面
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = HomeWorkTwoViewController()
        let homeworkInfo = self.homeworkSource.homeworkList[indexPath.row]
        vc.HWcreate_time=homeworkInfo.create_time!
        vc.HWallreader=homeworkInfo.allreader!
        vc.HWreadcount=homeworkInfo.readcount!
        vc.HWUsername=homeworkInfo.username!
        vc.HWPhoto=homeworkInfo.photo!
        vc.HWContent=homeworkInfo.content!
        vc.HWTitle=homeworkInfo.title!
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    func addHomework(){
        let vc = AddHomeworkViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
//MARK: -    阅读
    func readBtn(sender:UIButton){
//        let btn:UIButton = sender
//        let vc = ReadViewController()
//        let newsInfo = self.homeworkSource.homeworkList[btn.tag]
//        vc.num1 = String(newsInfo.readcount!)
//        vc.num2 = String(newsInfo.allreader!-newsInfo.readcount!)
//        vc.id = String(btn.tag)
//        self.navigationController?.pushViewController(vc, animated: true)
    }
}
