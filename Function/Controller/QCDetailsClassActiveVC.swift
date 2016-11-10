//
//  QCDetailsClassActiveVC.swift
//  WXT_Parents
//
//  Created by 沈晓龙 on 16/7/19.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import Alamofire
import YYWebImage
import XWSwiftRefresh
import MBProgressHUD

class QCDetailsClassActiveVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var id:String!
    //  数据源
    var activitySource = ActivityInfo()
 
    //  创建tableview
    var tableView = UITableView()
    var isCollect:Bool = false
    var likeNum  = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        createTableView()
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    func initUI(){
        self.title = "活动详情"
        self.tabBarController?.tabBar.hidden = true
        self.view.backgroundColor = RGBA(239, g: 239, b: 244, a: 1)
    }
    
    
    func createTableView(){
        tableView.frame = CGRectMake(0, 0, frame.width, frame.height-44)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(QCDetailsClassActiveCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
    }
    
    func GETData(){
    
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section==0 {
            
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as? QCDetailsClassActiveCell
        cell?.selectionStyle = .None
    
    
        cell?.teacherLabel.text = self.activitySource.teacher_name
        
        
        cell?.titleLabel.text = self.activitySource.title
        //  活动时间
        let dateformate = NSDateFormatter()
        dateformate.dateFormat = "MM-dd HH:mm"
        let date = NSDate(timeIntervalSince1970: NSTimeInterval(self.activitySource.create_time!)!)
        let str:String = dateformate.stringFromDate(date)
        cell?.timeLabel.text = str
        
        cell?.contentLabel.text = self.activitySource.content
        cell?.contentLabel.numberOfLines = 0
        cell?.contentLabel.sizeToFit()
        
        let dateformate1 = NSDateFormatter()
        dateformate1.dateFormat = "yy-MM-dd"
        let data1 = NSDate(timeIntervalSince1970: NSTimeInterval(self.activitySource.begintime!)!)
        cell?.startTime.frame = CGRectMake(10, (cell?.contentLabel.frame.size.height)!+cell!.contentLabel.frame.origin.y + 20, WIDTH - 20, 30)
        cell?.startTime.text = "大赛举办时间\(dateformate.stringFromDate(data1))"
        cell?.startTime.sizeToFit()
        
        let dateformate2 = NSDateFormatter()
        dateformate2.dateFormat = "MM-dd"
        let data2 = NSDate(timeIntervalSince1970: NSTimeInterval(self.activitySource.starttime!)!)
        let data3 = NSDate(timeIntervalSince1970: NSTimeInterval(self.activitySource.finishtime!)!)
        cell?.activeTimes.frame = CGRectMake(10, (cell?.startTime.frame.size.height)!+cell!.contentLabel.frame.origin.y + 50, WIDTH - 20, 30)
        cell?.activeTimes.text = "报名截止日期\(dateformate.stringFromDate(data2))到\(dateformate.stringFromDate(data3))"
    
        
        let pic = self.activitySource.pic

        //        print(picModel.count)
        
        
        
        //  图片
        var image_h = CGFloat()
        var button:UIButton?
        
        let height = (cell?.activeTimes.frame.size.height)!+cell!.activeTimes.frame.origin.y + 30
        
        
        //判断图片张数显示
        if pic.count == 1 {
            image_h=(WIDTH - 40)/3.0
            let pciInfo = pic[0]
            let imgUrl = pictureUrl+(pciInfo.pictureurl)!
            let avatarUrl = NSURL(string: imgUrl)
            let request: NSURLRequest = NSURLRequest(URL: avatarUrl!)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?)-> Void in
                if(data != nil){
                    button = UIButton()
                    button!.frame = CGRectMake(12, height, WIDTH - 24, (WIDTH - 40)/3.0)
                    let imgTmp = UIImage(data: data!)
                    
                    button!.setImage(imgTmp, forState: .Normal)
                    if button?.imageView?.image == nil{
                        //                        button!.setImage(UIImage(named: "园所公告背景.png"), forState: .Normal)
                        button?.setBackgroundImage(UIImage(named: "园所公告背景.png"), forState: .Normal)
                    }
                    button?.tag = indexPath.row
                    button?.addTarget(self, action: #selector(self.clickBtn), forControlEvents: .TouchUpInside)
                    cell!.contentView.addSubview(button!)
                    
                }
            })
            
        }
        if(pic.count>1&&pic.count<=3){
            image_h=(WIDTH - 40)/3.0
            for i in 1...pic.count{
                var x = 12
                let pciInfo = pic[i-1]
                let imgUrl = pictureUrl+(pciInfo.pictureurl)!
                print(imgUrl)
                
                //let image = self.imageCache[imgUrl] as UIImage?
                let avatarUrl = NSURL(string: imgUrl)
                let request: NSURLRequest = NSURLRequest(URL: avatarUrl!)
                
                NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?)-> Void in
                    if(data != nil){
                        x = x+((i-1)*Int((WIDTH - 40)/3.0 + 10))
                        //                        blogimage = UIImageView(frame: CGRectMake(CGFloat(x), 150, 110, 80))
                        button = UIButton()
                        button!.frame = CGRectMake(CGFloat(x), height, (WIDTH - 40)/3.0, (WIDTH - 40)/3.0)
                        let imgTmp = UIImage(data: data!)
                        
                        button!.setImage(imgTmp, forState: .Normal)
                        if button?.imageView?.image == nil{
                            //                            button!.setImage(UIImage(named: "Logo"), forState: .Normal)
                            button?.setBackgroundImage(UIImage(named: "Logo"), forState: .Normal)
                        }
                        button?.tag = indexPath.row
                        button?.addTarget(self, action: #selector(self.clickBtn), forControlEvents: .TouchUpInside)
                        cell!.contentView.addSubview(button!)
                        
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
                    if pciInfo.pictureurl != "" {
                        
                        
                        let imgUrl = pictureUrl+(pciInfo.pictureurl)!
                        
                        //let image = self.imageCache[imgUrl] as UIImage?
                        let avatarUrl = NSURL(string: imgUrl)
                        let request: NSURLRequest = NSURLRequest(URL: avatarUrl!)
                        
                        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?)-> Void in
                            if(data != nil){
                                x = x+((i-1)*Int((WIDTH - 40)/3.0 + 10))
                                button = UIButton()
                                button!.frame = CGRectMake(CGFloat(x), height, (WIDTH - 40)/3.0, (WIDTH - 40)/3.0)
                                
                                let imgTmp = UIImage(data: data!)
                                
                                button!.setImage(imgTmp, forState: .Normal)
                                if button?.imageView?.image == nil{
                                    button!.setImage(UIImage(named: "Logo"), forState: .Normal)
                                }
                                button?.tag = indexPath.row
                                button?.addTarget(self, action: #selector(self.clickBtn), forControlEvents: .TouchUpInside)
                                cell!.contentView.addSubview(button!)
                            }
                        })
                    }}else{
                    var x = 12
                    let pciInfo = pic[i-1]
                    if pciInfo.pictureurl != "" {
                        let imgUrl = pictureUrl+(pciInfo.pictureurl)!
                        
                        //let image = self.imageCache[imgUrl] as UIImage?
                        let avatarUrl = NSURL(string: imgUrl)
                        let request: NSURLRequest = NSURLRequest(URL: avatarUrl!)
                        
                        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?)-> Void in
                            if(data != nil){
                                x = x+((i-4)*Int((WIDTH - 40)/3.0 + 10))
                                button = UIButton()
                                button!.frame = CGRectMake(CGFloat(x), height+(WIDTH - 40)/3.0 + 5, (WIDTH - 40)/3.0, (WIDTH - 40)/3.0)
                                let imgTmp = UIImage(data: data!)
                                
                                button!.setImage(imgTmp, forState: .Normal)
                                if button?.imageView?.image == nil{
                                    button!.setImage(UIImage(named: "Logo"), forState: .Normal)
                                }
                                button?.tag = indexPath.row
                                button?.addTarget(self, action: #selector(self.clickBtn), forControlEvents: .TouchUpInside)
                                cell!.contentView.addSubview(button!)
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
                    if pciInfo.pictureurl != "" {
                        let imgUrl = pictureUrl+(pciInfo.pictureurl)!
                        
                        //let image = self.imageCache[imgUrl] as UIImage?
                        let avatarUrl = NSURL(string: imgUrl)
                        let request: NSURLRequest = NSURLRequest(URL: avatarUrl!)
                        
                        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?)-> Void in
                            if(data != nil){
                                x = x+((i-1)*Int((WIDTH - 40)/3.0 + 10))
                                button = UIButton()
                                button!.frame = CGRectMake(CGFloat(x), height, (WIDTH - 40)/3.0, (WIDTH - 40)/3.0)
                                let imgTmp = UIImage(data: data!)
                                
                                button!.setImage(imgTmp, forState: .Normal)
                                if button?.imageView?.image == nil{
                                    button!.setImage(UIImage(named: "Logo"), forState: .Normal)
                                }
                                button?.tag = indexPath.row
                                button?.addTarget(self, action: #selector(self.clickBtn), forControlEvents: .TouchUpInside)
                                cell!.contentView.addSubview(button!)
                            }
                        })
                        
                    }}else if (i>3&&i<=6){
                    var x = 12
                    let pciInfo = pic[i-1]
                    if pciInfo.pictureurl != "" {
                        let imgUrl = pictureUrl+(pciInfo.pictureurl)!
                        
                        //let image = self.imageCache[imgUrl] as UIImage?
                        let avatarUrl = NSURL(string: imgUrl)
                        let request: NSURLRequest = NSURLRequest(URL: avatarUrl!)
                        
                        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?)-> Void in
                            if(data != nil){
                                x = x+((i-4)*Int((WIDTH - 40)/3.0 + 10))
                                button = UIButton()
                                button!.frame = CGRectMake(CGFloat(x), height+(WIDTH - 40)/3.0 + 5, (WIDTH - 40)/3.0, (WIDTH - 40)/3.0)
                                let imgTmp = UIImage(data: data!)
                                
                                button!.setImage(imgTmp, forState: .Normal)
                                if button?.imageView?.image == nil{
                                    button!.setImage(UIImage(named: "Logo"), forState: .Normal)
                                }
                                button?.tag = indexPath.row
                                button?.addTarget(self, action: #selector(self.clickBtn), forControlEvents: .TouchUpInside)
                                cell!.contentView.addSubview(button!)
                            }
                        })
                        
                    } }else{
                    var x = 12
                    let pciInfo = pic[i-1]
                    if pciInfo.pictureurl != "" {
                        let imgUrl = pictureUrl+(pciInfo.pictureurl)!
                        
                        //let image = self.imageCache[imgUrl] as UIImage?
                        let avatarUrl = NSURL(string: imgUrl)
                        let request: NSURLRequest = NSURLRequest(URL: avatarUrl!)
                        
                        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?)-> Void in
                            if(data != nil){
                                x = x+((i-7)*Int((WIDTH - 40)/3.0 + 10))
                                button = UIButton()
                                button!.frame = CGRectMake(CGFloat(x), height+(WIDTH - 40)/3.0 + 5+(WIDTH - 40)/3.0 + 5, (WIDTH - 40)/3.0, (WIDTH - 40)/3.0)
                                let imgTmp = UIImage(data: data!)
                                
                                button!.setImage(imgTmp, forState: .Normal)
                                if button?.imageView?.image == nil{
                                    button!.setImage(UIImage(named: "Logo"), forState: .Normal)
                                }
                                button?.tag = indexPath.row
                                button?.addTarget(self, action: #selector(self.clickBtn), forControlEvents: .TouchUpInside)
                                cell!.contentView.addSubview(button!)
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
                    if pciInfo.pictureurl != "" {
                        let imgUrl = pictureUrl+(pciInfo.pictureurl)!
                        
                        //let image = self.imageCache[imgUrl] as UIImage?
                        let avatarUrl = NSURL(string: imgUrl)
                        let request: NSURLRequest = NSURLRequest(URL: avatarUrl!)
                        
                        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?)-> Void in
                            if(data != nil){
                                x = x+((i-1)*Int((WIDTH - 40)/3.0 + 10))
                                print(x)
                                button = UIButton()
                                button!.frame = CGRectMake(CGFloat(x), height, (WIDTH - 40)/3.0, (WIDTH - 40)/3.0)
                                let imgTmp = UIImage(data: data!)
                                
                                button!.setImage(imgTmp, forState: .Normal)
                                if button?.imageView?.image == nil{
                                    button!.setImage(UIImage(named: "Logo"), forState: .Normal)
                                }
                                button?.tag = indexPath.row
                                button?.addTarget(self, action: #selector(self.clickBtn), forControlEvents: .TouchUpInside)
                                cell!.contentView.addSubview(button!)
                            }
                        })
                        
                    }}else if (i>3&&i<=6){
                    var x = 12
                    let pciInfo = pic[i-1]
                    if pciInfo.pictureurl != "" {
                        let imgUrl = pictureUrl+(pciInfo.pictureurl)!
                        
                        //let image = self.imageCache[imgUrl] as UIImage?
                        let avatarUrl = NSURL(string: imgUrl)
                        let request: NSURLRequest = NSURLRequest(URL: avatarUrl!)
                        
                        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?)-> Void in
                            if(data != nil){
                                x = x+((i-4)*Int((WIDTH - 40)/3.0 + 10))
                                button = UIButton()
                                button!.frame = CGRectMake(CGFloat(x), height+(WIDTH - 40)/3.0 + 5, (WIDTH - 40)/3.0, (WIDTH - 40)/3.0)
                                let imgTmp = UIImage(data: data!)
                                
                                button!.setImage(imgTmp, forState: .Normal)
                                if button?.imageView?.image == nil{
                                    button!.setImage(UIImage(named: "Logo"), forState: .Normal)
                                }
                                button?.tag = indexPath.row
                                button?.addTarget(self, action: #selector(self.clickBtn), forControlEvents: .TouchUpInside)
                                cell!.contentView.addSubview(button!)
                            }
                        })
                        
                    } }else{
                    var x = 12
                    let pciInfo = pic[i-1]
                    if pciInfo.pictureurl != "" {
                        let imgUrl = pictureUrl+(pciInfo.pictureurl)!
                        
                        //let image = self.imageCache[imgUrl] as UIImage?
                        let avatarUrl = NSURL(string: imgUrl)
                        let request: NSURLRequest = NSURLRequest(URL: avatarUrl!)
                        
                        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?)-> Void in
                            if(data != nil){
                                x = x+((i-7)*Int((WIDTH - 40)/3.0 + 10))
                                button = UIButton()
                                button!.frame = CGRectMake(CGFloat(x), height+(WIDTH - 40)/3.0 + 5+(WIDTH - 40)/3.0 + 5, (WIDTH - 40)/3.0, (WIDTH - 40)/3.0)
                                let imgTmp = UIImage(data: data!)
                                
                                button!.setImage(imgTmp, forState: .Normal)
                                if button?.imageView?.image == nil{
                                    button!.setImage(UIImage(named: "Logo"), forState: .Normal)
                                }
                                button?.tag = indexPath.row
                                button?.addTarget(self, action: #selector(self.clickBtn(_:)), forControlEvents: .TouchUpInside)
                                cell!.contentView.addSubview(button!)
                            }
                        })
                        
                    }
                    
                }
                
            }}
        tableView.rowHeight = height + image_h
        return cell!
        }else if indexPath.section==1{
            let cell = UITableViewCell()
            let lable = UILabel(frame: CGRectMake(150,10,frame.width-160,20))
        
            lable.textColor=wenziColor
            
            if indexPath.row==0 {
                cell.textLabel?.text="活动开始时间"
                cell.textLabel?.textColor=wenziColor
                lable.text=changeTimeTwo(self.activitySource.begintime!)
                cell.contentView.addSubview(lable)
                
                
            }else if indexPath.row==1{
                cell.textLabel?.text="活动结束时间"
                cell.textLabel?.textColor=wenziColor
                lable.text=changeTimeTwo(self.activitySource.endtime!)
                cell.contentView.addSubview(lable)
            }else if indexPath.row==2{
                cell.textLabel?.text="联系人"
                cell.textLabel?.textColor=wenziColor
                lable.text=self.activitySource.contactman
                cell.contentView.addSubview(lable)
            }else if indexPath.row==3{
                cell.textLabel?.text="联系方式"
                cell.textLabel?.textColor=wenziColor
                lable.text=self.activitySource.contactphone
                cell.contentView.addSubview(lable)
            }
            tableView.rowHeight=44
            return cell
        }else{
            let cell = UITableViewCell()
            let lable = UILabel(frame: CGRectMake(150,10,frame.width-160,20))
            lable.textColor=wenziColor
            if indexPath.row==0 {
                cell.textLabel?.text="报名开始时间"
                cell.textLabel?.textColor=wenziColor
                cell.contentView.addSubview(lable)
                
            }else {
                cell.textLabel?.text="报名结束时间"
                cell.textLabel?.textColor=wenziColor
                cell.contentView.addSubview(lable)
            }
            tableView.rowHeight=44
            return cell
        }
        
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section==0 {
            return 1
        }else if section==1{
            return 4
        }else{
            return 2
        }
        
    }
    
    func clickBtn(sender:UIButton){
//        let activityInfo = self.activitySource
//        let detailsVC = PicDetailViewController()
//        
//        detailsVC.activitySource = activityInfo
//        detailsVC.activity_listSource = activity_listList(activityInfo.activity_list!)
//        detailsVC.apply_countSource = apply_countList(activityInfo.apply_count!)
//        detailsVC.picSource = picList(activityInfo.pic!)
//        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func GetBaoMing(btn:UIButton){
//        http://wxt.xiaocool.net/index.php?g=apps&m=student&a=ApplyActivity&userid=597&activityid=3&sex=1&age=5&fathername=大眼&contactphone=111
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=teacher&a=ApplyActivity"
        let userid = NSUserDefaults.standardUserDefaults()
        let uid = userid.stringForKey("userid")
        let param = [
            "activityid":id,
            "userid":uid
        ]
        Alamofire.request(.GET, url, parameters: param as? [String:String]).response { request, response, json, error in
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
                    hud.labelText = status.errorData
                    hud.margin = 10.0
                    hud.removeFromSuperViewOnHide = true
                    hud.hide(true, afterDelay: 1)
                }
                
                if(status.status == "success"){
                    //self.dianZanBtn.selected == true
                    let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                    hud.mode = MBProgressHUDMode.Text;
                    hud.labelText = "报名成功"
                    hud.margin = 10.0
                    hud.removeFromSuperViewOnHide = true
                    hud.hide(true, afterDelay: 1)
                    //                    刷新
                    userid.setObject("true", forKey: "isCollect")
                    self.isCollect = true
                    self.likeNum = 1
                    self.tableView.reloadData()
                }
                
            }
            
        }
        

    }
    
    
}
