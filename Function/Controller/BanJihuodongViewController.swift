//
//  BanJihuodongViewController.swift
//  WXT_Teacher
//
//  Created by 李春波 on 16/3/15.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import YYWebImage
import Alamofire
import MBProgressHUD
import XWSwiftRefresh


class BanJihuodongViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var activitySource = ActivityList()
    var activity_listSource = activity_listList()
    var apply_countSource = apply_countList()
    var picSource = picList()
    var user_Source = user_List()
    let arrayPeople = NSMutableArray()

    let huoDongTableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "班级活动"
        self.view.backgroundColor = UIColor.whiteColor()
        
        //增加班级活动按钮
        let addBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: #selector(BanJihuodongViewController.addHuodong))
        self.navigationItem.rightBarButtonItem = addBtn
        
        self.automaticallyAdjustsScrollViewInsets = false
        huoDongTableView.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height)
        self.huoDongTableView.tableFooterView = UIView(frame: CGRectZero)
        huoDongTableView.delegate = self
        huoDongTableView.dataSource = self
        self.tabBarController?.tabBar.hidden = true
        self.view.addSubview(huoDongTableView)
        
        self.DropDownUpdate()
        GetDate()
        
    }
    
    func DropDownUpdate(){
//        self.huoDongTableView.headerView = XWRefreshNormalHeader(target: self, action: #selector(NewsViewController.GetDate))
//        self.huoDongTableView.reloadData()
//        self.huoDongTableView.headerView?.beginRefreshing()
    }
    
    //    获取活动列表
    func GetDate(){
        
        //        http://wxt.xiaocool.net/index.php?g=apps&m=student&a=getactivitylist&receiverid=597
        
        let defalutid = NSUserDefaults.standardUserDefaults()
        let uid = defalutid.stringForKey("userid")
        
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=student&a=getactivitylist&receiverid="+uid!

        Alamofire.request(.GET, url, parameters: nil).response { request, response, json, error in
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
                    self.activitySource = ActivityList(status.data!)
                    self.huoDongTableView.reloadData()
//                    self.huoDongTableView.headerView?.endRefreshing()
                }
            }
        }
        
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.activitySource.count
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: String(indexPath.row))
        cell.selectionStyle = .None
        let activityInfo = self.activitySource.activityList[indexPath.row]
        self.activity_listSource = activity_listList(activityInfo.activity_list!)
        self.apply_countSource = apply_countList(activityInfo.apply_count!)
        self.picSource = picList(activityInfo.pic!)
        
        //  得到活动中的内容
        let activity_listModel = self.activity_listSource.activityList[0]
        
        //  活动标题
        let titleLbl = UILabel()
        titleLbl.frame = CGRectMake(10, 10, WIDTH - 20, 30)
        titleLbl.textAlignment = NSTextAlignment.Center
        titleLbl.text = activity_listModel.title
        cell.contentView.addSubview(titleLbl)
        //  活动内容
        let contentLbl = UILabel()
        contentLbl.frame = CGRectMake(10, 50, WIDTH - 20, 20)
        contentLbl.font = UIFont.systemFontOfSize(16)
        contentLbl.textColor = UIColor.lightGrayColor()
        contentLbl.text = activity_listModel.content
        cell.contentView.addSubview(contentLbl)
        
        //  活动图片
        
        let pic = self.picSource.activityList
        //        print(picModel.count)
        
        
        
        //  图片
        var image_h = CGFloat()
        var button:UIButton?
        
        
        //判断图片张数显示
        if pic.count == 1 {
            image_h=(WIDTH - 40)/3.0
            let pciInfo = pic[0]
            let imgUrl = pictureUrl+(pciInfo.picture_url)!
            let avatarUrl = NSURL(string: imgUrl)
            let request: NSURLRequest = NSURLRequest(URL: avatarUrl!)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?)-> Void in
                if(data != nil){
                    button = UIButton()
                    button!.frame = CGRectMake(12, 80, WIDTH - 24, (WIDTH - 40)/3.0)
                    let imgTmp = UIImage(data: data!)
                    
                    button!.setImage(imgTmp, forState: .Normal)
                    if button?.imageView?.image == nil{
                        //                        button!.setImage(UIImage(named: "园所公告背景.png"), forState: .Normal)
                        button?.setBackgroundImage(UIImage(named: "4"), forState: .Normal)
                    }
                    button?.tag = indexPath.row
                    button?.addTarget(self, action: #selector(self.clickBtn), forControlEvents: .TouchUpInside)
                    cell.contentView.addSubview(button!)
                    
                }
            })
            
        }
        if(pic.count>1&&pic.count<=3){
            image_h=(WIDTH - 40)/3.0
            for i in 1...pic.count{
                var x = 12
                let pciInfo = pic[i-1]
                let imgUrl = pictureUrl+(pciInfo.picture_url)!
                print(imgUrl)
                
                //let image = self.imageCache[imgUrl] as UIImage?
                let avatarUrl = NSURL(string: imgUrl)
                let request: NSURLRequest = NSURLRequest(URL: avatarUrl!)
                
                NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?)-> Void in
                    if(data != nil){
                        x = x+((i-1)*Int((WIDTH - 40)/3.0 + 10))
                        //                        blogimage = UIImageView(frame: CGRectMake(CGFloat(x), 150, 110, 80))
                        button = UIButton()
                        button!.frame = CGRectMake(CGFloat(x), 80, (WIDTH - 40)/3.0, (WIDTH - 40)/3.0)
                        let imgTmp = UIImage(data: data!)
                        
                        button!.setImage(imgTmp, forState: .Normal)
                        if button?.imageView?.image == nil{
                            //                            button!.setImage(UIImage(named: "Logo"), forState: .Normal)
                            button?.setBackgroundImage(UIImage(named: "4"), forState: .Normal)
                        }
                        button?.tag = indexPath.row
                        button?.addTarget(self, action: #selector(self.clickBtn), forControlEvents: .TouchUpInside)
                        cell.contentView.addSubview(button!)
                        
                    }
                })
                
            }
        }
        if(pic.count>3&&pic.count<=6){
            image_h=(WIDTH - 40)/3.0*2 + 10
            for i in 1...pic.count{
                if i <= 3 {
                    var x = 12
                    let pciInfo = pic[i-1]
                    if pciInfo.picture_url != "" {
                        
                        
                        let imgUrl = microblogImageUrl+(pciInfo.picture_url)!
                        
                        //let image = self.imageCache[imgUrl] as UIImage?
                        let avatarUrl = NSURL(string: imgUrl)
                        let request: NSURLRequest = NSURLRequest(URL: avatarUrl!)
                        
                        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?)-> Void in
                            if(data != nil){
                                x = x+((i-1)*Int((WIDTH - 40)/3.0 + 10))
                                button = UIButton()
                                button!.frame = CGRectMake(CGFloat(x), 80, (WIDTH - 40)/3.0, (WIDTH - 40)/3.0)
                                
                                let imgTmp = UIImage(data: data!)
                                
                                button!.setImage(imgTmp, forState: .Normal)
                                if button?.imageView?.image == nil{
                                    button!.setImage(UIImage(named: "4"), forState: .Normal)
                                }
                                button?.tag = indexPath.row
                                button?.addTarget(self, action: #selector(self.clickBtn), forControlEvents: .TouchUpInside)
                                cell.contentView.addSubview(button!)
                            }
                        })
                    }}else{
                    var x = 12
                    let pciInfo = pic[i-1]
                    if pciInfo.picture_url != "" {
                        let imgUrl = pictureUrl+(pciInfo.picture_url)!
                        
                        //let image = self.imageCache[imgUrl] as UIImage?
                        let avatarUrl = NSURL(string: imgUrl)
                        let request: NSURLRequest = NSURLRequest(URL: avatarUrl!)
                        
                        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?)-> Void in
                            if(data != nil){
                                x = x+((i-4)*Int((WIDTH - 40)/3.0 + 10))
                                button = UIButton()
                                button!.frame = CGRectMake(CGFloat(x), 80+(WIDTH - 40)/3.0 + 5, (WIDTH - 40)/3.0, (WIDTH - 40)/3.0)
                                let imgTmp = UIImage(data: data!)
                                
                                button!.setImage(imgTmp, forState: .Normal)
                                if button?.imageView?.image == nil{
                                    button!.setImage(UIImage(named: "4"), forState: .Normal)
                                }
                                button?.tag = indexPath.row
                                button?.addTarget(self, action: #selector(self.clickBtn), forControlEvents: .TouchUpInside)
                                cell.contentView.addSubview(button!)
                            }
                        })
                        
                    }
                }
            }}
        if(pic.count>6&&pic.count<=9){
            image_h=(WIDTH - 40)/3.0*3+20
            for i in 1...pic.count{
                if i <= 3 {
                    var x = 12
                    let pciInfo = pic[i-1]
                    if pciInfo.picture_url != "" {
                        let imgUrl = pictureUrl+(pciInfo.picture_url)!
                        
                        //let image = self.imageCache[imgUrl] as UIImage?
                        let avatarUrl = NSURL(string: imgUrl)
                        let request: NSURLRequest = NSURLRequest(URL: avatarUrl!)
                        
                        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?)-> Void in
                            if(data != nil){
                                x = x+((i-1)*Int((WIDTH - 40)/3.0 + 10))
                                button = UIButton()
                                button!.frame = CGRectMake(CGFloat(x), 80, (WIDTH - 40)/3.0, (WIDTH - 40)/3.0)
                                let imgTmp = UIImage(data: data!)
                                
                                button!.setImage(imgTmp, forState: .Normal)
                                if button?.imageView?.image == nil{
                                    button!.setImage(UIImage(named: "4"), forState: .Normal)
                                }
                                button?.tag = indexPath.row
                                button?.addTarget(self, action: #selector(self.clickBtn), forControlEvents: .TouchUpInside)
                                cell.contentView.addSubview(button!)
                            }
                        })
                        
                    }}else if (i>3&&i<=6){
                    var x = 12
                    let pciInfo = pic[i-1]
                    if pciInfo.picture_url != "" {
                        let imgUrl = pictureUrl+(pciInfo.picture_url)!
                        
                        //let image = self.imageCache[imgUrl] as UIImage?
                        let avatarUrl = NSURL(string: imgUrl)
                        let request: NSURLRequest = NSURLRequest(URL: avatarUrl!)
                        
                        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?)-> Void in
                            if(data != nil){
                                x = x+((i-4)*Int((WIDTH - 40)/3.0 + 10))
                                button = UIButton()
                                button!.frame = CGRectMake(CGFloat(x), 80+(WIDTH - 40)/3.0 + 5, (WIDTH - 40)/3.0, (WIDTH - 40)/3.0)
                                let imgTmp = UIImage(data: data!)
                                
                                button!.setImage(imgTmp, forState: .Normal)
                                if button?.imageView?.image == nil{
                                    button!.setImage(UIImage(named: "4"), forState: .Normal)
                                }
                                button?.tag = indexPath.row
                                button?.addTarget(self, action: #selector(self.clickBtn), forControlEvents: .TouchUpInside)
                                cell.contentView.addSubview(button!)
                            }
                        })
                        
                    } }else{
                    var x = 12
                    let pciInfo = pic[i-1]
                    if pciInfo.picture_url != "" {
                        let imgUrl = pictureUrl+(pciInfo.picture_url)!
                        
                        //let image = self.imageCache[imgUrl] as UIImage?
                        let avatarUrl = NSURL(string: imgUrl)
                        let request: NSURLRequest = NSURLRequest(URL: avatarUrl!)
                        
                        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?)-> Void in
                            if(data != nil){
                                x = x+((i-7)*Int((WIDTH - 40)/3.0 + 10))
                                button = UIButton()
                                button!.frame = CGRectMake(CGFloat(x), 80+(WIDTH - 40)/3.0 + 5+(WIDTH - 40)/3.0 + 5, (WIDTH - 40)/3.0, (WIDTH - 40)/3.0)
                                let imgTmp = UIImage(data: data!)
                                
                                button!.setImage(imgTmp, forState: .Normal)
                                if button?.imageView?.image == nil{
                                    button!.setImage(UIImage(named: "4"), forState: .Normal)
                                }
                                button?.tag = indexPath.row
                                button?.addTarget(self, action: #selector(self.clickBtn), forControlEvents: .TouchUpInside)
                                cell.contentView.addSubview(button!)
                            }
                        })
                        
                    }
                    
                }
                
            }}
        if pic.count > 9 {
            image_h=(WIDTH - 40)/3.0*3 + 20
            for i in 1...pic.count{
                if i <= 3 {
                    var x = 12
                    let pciInfo = pic[i-1]
                    if pciInfo.picture_url != "" {
                        let imgUrl = pictureUrl+(pciInfo.picture_url)!
                        
                        //let image = self.imageCache[imgUrl] as UIImage?
                        let avatarUrl = NSURL(string: imgUrl)
                        let request: NSURLRequest = NSURLRequest(URL: avatarUrl!)
                        
                        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?)-> Void in
                            if(data != nil){
                                x = x+((i-1)*Int((WIDTH - 40)/3.0 + 10))
                                print(x)
                                button = UIButton()
                                button!.frame = CGRectMake(CGFloat(x), 80, (WIDTH - 40)/3.0, (WIDTH - 40)/3.0)
                                let imgTmp = UIImage(data: data!)
                                
                                button!.setImage(imgTmp, forState: .Normal)
                                if button?.imageView?.image == nil{
                                    button!.setImage(UIImage(named: "4"), forState: .Normal)
                                }
                                button?.tag = indexPath.row
                                button?.addTarget(self, action: #selector(self.clickBtn), forControlEvents: .TouchUpInside)
                                cell.contentView.addSubview(button!)
                            }
                        })
                        
                    }}else if (i>3&&i<=6){
                    var x = 12
                    let pciInfo = pic[i-1]
                    if pciInfo.picture_url != "" {
                        let imgUrl = pictureUrl+(pciInfo.picture_url)!
                        
                        //let image = self.imageCache[imgUrl] as UIImage?
                        let avatarUrl = NSURL(string: imgUrl)
                        let request: NSURLRequest = NSURLRequest(URL: avatarUrl!)
                        
                        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?)-> Void in
                            if(data != nil){
                                x = x+((i-4)*Int((WIDTH - 40)/3.0 + 10))
                                button = UIButton()
                                button!.frame = CGRectMake(CGFloat(x), 80+(WIDTH - 40)/3.0 + 5, (WIDTH - 40)/3.0, (WIDTH - 40)/3.0)
                                let imgTmp = UIImage(data: data!)
                                
                                button!.setImage(imgTmp, forState: .Normal)
                                if button?.imageView?.image == nil{
                                    button!.setImage(UIImage(named: "4"), forState: .Normal)
                                }
                                button?.tag = indexPath.row
                                button?.addTarget(self, action: #selector(self.clickBtn), forControlEvents: .TouchUpInside)
                                cell.contentView.addSubview(button!)
                            }
                        })
                        
                    } }else{
                    var x = 12
                    let pciInfo = pic[i-1]
                    if pciInfo.picture_url != "" {
                        let imgUrl = pictureUrl+(pciInfo.picture_url)!
                        
                        //let image = self.imageCache[imgUrl] as UIImage?
                        let avatarUrl = NSURL(string: imgUrl)
                        let request: NSURLRequest = NSURLRequest(URL: avatarUrl!)
                        
                        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?)-> Void in
                            if(data != nil){
                                x = x+((i-7)*Int((WIDTH - 40)/3.0 + 10))
                                button = UIButton()
                                button!.frame = CGRectMake(CGFloat(x), 80+(WIDTH - 40)/3.0 + 5+(WIDTH - 40)/3.0 + 5, (WIDTH - 40)/3.0, (WIDTH - 40)/3.0)
                                let imgTmp = UIImage(data: data!)
                                
                                button!.setImage(imgTmp, forState: .Normal)
                                if button?.imageView?.image == nil{
                                    button!.setImage(UIImage(named: "4"), forState: .Normal)
                                }
                                button?.tag = indexPath.row
                                button?.addTarget(self, action: #selector(self.clickBtn(_:)), forControlEvents: .TouchUpInside)
                                cell.contentView.addSubview(button!)
                            }
                        })
                        
                    }
                    
                }
                
            }}
        tableView.rowHeight = 80 + image_h + 100
        
        let imageView = UIImageView()
        imageView.frame = CGRectMake(10, 80 + image_h + 10, 21, 21)
        imageView.image = UIImage.init(named: "ic_fasong")
        cell.contentView.addSubview(imageView)
        
        let senderLbl = UILabel()
        senderLbl.frame = CGRectMake(40, 80 + image_h + 10, 60, 20)
        senderLbl.font = UIFont.systemFontOfSize(16)
        self.user_Source = user_List(activity_listModel.user_info!)
        if self.user_Source.activityList.count != 0 {
            let userModel = self.user_Source.activityList[0]
            senderLbl.textColor = UIColor.lightGrayColor()
            senderLbl.text = userModel.name
            cell.contentView.addSubview(senderLbl)
            print("aaaaaaaaaaa")
            print(senderLbl.text)
        }
  


        //  活动时间
        let dateformate = NSDateFormatter()
        dateformate.dateFormat = "yyyy-MM-dd HH:mm"
        let date = NSDate(timeIntervalSince1970: NSTimeInterval(activity_listModel.create_time!)!)
        let str:String = dateformate.stringFromDate(date)
        let timeLbl = UILabel()
        timeLbl.frame = CGRectMake(110, 80+image_h+10, WIDTH - 120, 20)
        timeLbl.textAlignment = NSTextAlignment.Right
        timeLbl.font = UIFont.systemFontOfSize(15)
        timeLbl.textColor = UIColor.lightGrayColor()
        timeLbl.text = str
        cell.contentView.addSubview(timeLbl)
        
        let line = UILabel()
        line.frame = CGRectMake(1, 119.5 + image_h, WIDTH - 2, 0.5)
        line.backgroundColor = UIColor.lightGrayColor()
        cell.addSubview(line)
        
        let baoming = UILabel()
        baoming.frame = CGRectMake(15, 130 + image_h, WIDTH - 30, 20)
        baoming.text = "已报名\(self.apply_countSource.activityList.count)"
        baoming.textColor = UIColor.orangeColor()
        cell.addSubview(baoming)
        
        let view = UIView()
        view.frame = CGRectMake(0, 160 + image_h, WIDTH, 20)
        view.backgroundColor = RGBA(242.0, g: 242.0, b: 242.0, a: 1)
        cell.addSubview(view)
        
        
        
        //  已报名
        //        cell.signUpLbl.text = "已报名\(activityInfo.readcount!)"
        
        return cell
    }

    func clickBtn(sender:UIButton){
        //            let activityInfo = self.activitySource.activityList[sender.tag]
        //            let detailsVC = PicDetailViewController()
        //
        //            detailsVC.activitySource = activityInfo
        //            detailsVC.activity_listSource = activity_listList(activityInfo.activity_list!)
        //            detailsVC.apply_countSource = apply_countList(activityInfo.apply_count!)
        //            detailsVC.picSource = picList(activityInfo.pic!)
        //            self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let activityInfo = self.activitySource.activityList[indexPath.row]
        //  进行传值
        let detailsVC = QCDetailsClassActiveVC()
        detailsVC.id = activityInfo.activity_id
        detailsVC.activitySource = activityInfo
        detailsVC.activity_listSource = activity_listList(activityInfo.activity_list!)
        detailsVC.apply_countSource = apply_countList(activityInfo.apply_count!)
        detailsVC.picSource = picList(activityInfo.pic!)
        //        detailsVC.user_Source = user_List(activity_listModel.user_info!)
        self.navigationController?.pushViewController(detailsVC, animated: true)
        

    }

    //MARK: - 增加班级活动事件
    func addHuodong() {
        let huodongVC = HuoDongXqViewController()
        self.navigationController?.pushViewController(huodongVC, animated: true)
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
