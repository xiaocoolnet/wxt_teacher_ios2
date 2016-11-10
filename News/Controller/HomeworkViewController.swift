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
    
    var commentSource = HCommentList()
    let arrayPeople = NSMutableArray()
    
    override func viewWillAppear(animated: Bool) {
        self.DropDownUpdate()
        let user = NSUserDefaults.standardUserDefaults()
        user.removeObjectForKey("homeworkArr")
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
        let cell = UITableViewCell(style: .Default, reuseIdentifier:String(indexPath.row))
        cell.selectionStyle = .None
        tableView.separatorStyle = .None
        let model = self.homeworkSource.homeworkList[indexPath.row]
        
        //  活动标题
        let titleLbl = UILabel()
        titleLbl.frame = CGRectMake(10, 10, WIDTH - 20, 30)
        
        titleLbl.text = model.title
        titleLbl.textColor=biaotiColor
        titleLbl.font=biaotifont
        cell.contentView.addSubview(titleLbl)
        //  活动内容
        let contentLbl = UILabel()
        contentLbl.frame = CGRectMake(10, 50, WIDTH - 20, 0)
        contentLbl.font = neirongfont
        contentLbl.textColor = neirongColor
        contentLbl.text = model.content
        contentLbl.numberOfLines = 0
        cell.contentView.addSubview(contentLbl)
        
        //        自适应行高
        let options : NSStringDrawingOptions = NSStringDrawingOptions.UsesLineFragmentOrigin
        let screenBounds:CGRect = UIScreen.mainScreen().bounds
        let boundingRect = String(model.content).boundingRectWithSize(CGSizeMake(screenBounds.width-20, 0), options: options, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(15)], context: nil)
        let height = boundingRect.size.height + 50
        contentLbl.frame = CGRectMake(10, 20, WIDTH - 20, height)
        //  活动图片
        let pic = model.pic
        //  图片
        var image_h = CGFloat()
        var button:UIButton?
        
        
        //判断图片张数显示
        if pic.count == 1 {
            if !(pic.first!.pictureurl=="") && !(pic.first?.pictureurl=="null") {
                image_h=(WIDTH - 40)/3.0
                let pciInfo = pic[0]
                let imgUrl = pictureUrl+(pciInfo.pictureurl)
                let avatarUrl = NSURL(string: imgUrl)
                let request: NSURLRequest = NSURLRequest(URL: avatarUrl!)
                NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?)-> Void in
                    if(data != nil){
                        button = UIButton()
                        button!.frame = CGRectMake(12, height, WIDTH - 24, (WIDTH - 40)/3.0)
                        let imgTmp = UIImage(data: data!)
                        
                        button!.setImage(imgTmp, forState: .Normal)
                        if button?.imageView?.image == nil{
                            
                            button?.setBackgroundImage(UIImage(named: "4"), forState: .Normal)
                        }
                        button?.tag = indexPath.row
                        button?.addTarget(self, action: #selector(self.clickBtn), forControlEvents: .TouchUpInside)
                        cell.contentView.addSubview(button!)
                        
                    }
                })
            }
        }
        if(pic.count>1&&pic.count<=3){
            image_h=(WIDTH - 40)/3.0
            for i in 1...pic.count{
                var x = 12
                let pciInfo = pic[i-1]
                let imgUrl = pictureUrl+(pciInfo.pictureurl)
                print(imgUrl)
                
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
                   
                            button?.setBackgroundImage(UIImage(named: "Logo"), forState: .Normal)
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
                    if pciInfo.pictureurl != "" {
                        
                        
                        let imgUrl = pictureUrl+(pciInfo.pictureurl)
                        
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
                                cell.contentView.addSubview(button!)
                            }
                        })
                    }}else{
                    var x = 12
                    let pciInfo = pic[i-1]
                    if pciInfo.pictureurl != "" {
                        let imgUrl = pictureUrl+(pciInfo.pictureurl)
                        
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
                    if pciInfo.pictureurl != "" {
                        let imgUrl = pictureUrl+(pciInfo.pictureurl)
                        
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
                                cell.contentView.addSubview(button!)
                            }
                        })
                        
                    }}else if (i>3&&i<=6){
                    var x = 12
                    let pciInfo = pic[i-1]
                    if pciInfo.pictureurl != "" {
                        let imgUrl = pictureUrl+(pciInfo.pictureurl)
                        
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
                                cell.contentView.addSubview(button!)
                            }
                        })
                        
                    } }else{
                    var x = 12
                    let pciInfo = pic[i-1]
                    if pciInfo.pictureurl != "" {
                        let imgUrl = pictureUrl+(pciInfo.pictureurl)
                        
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
                    if pciInfo.pictureurl != "" {
                        let imgUrl = pictureUrl+(pciInfo.pictureurl)
                        
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
                                cell.contentView.addSubview(button!)
                            }
                        })
                        
                    }}else if (i>3&&i<=6){
                    var x = 12
                    let pciInfo = pic[i-1]
                    if pciInfo.pictureurl != "" {
                        let imgUrl = pictureUrl+(pciInfo.pictureurl)
                        
                        
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
                                cell.contentView.addSubview(button!)
                            }
                        })
                        
                    } }else{
                    var x = 12
                    let pciInfo = pic[i-1]
                    if pciInfo.pictureurl != "" {
                        let imgUrl = pictureUrl+(pciInfo.pictureurl)
                        
                        
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
                                cell.contentView.addSubview(button!)
                            }
                        })
                        
                    }
                    
                }
                
            }}
        
        let imageView = UIImageView()
        imageView.frame = CGRectMake(10, height + image_h + 10, 21, 21)
        imageView.image = UIImage.init(named: "ic_fasong")
        cell.contentView.addSubview(imageView)
        
        let senderLbl = UILabel()
        senderLbl.frame = CGRectMake(40, height + image_h + 10, 60, 20)
        senderLbl.font = UIFont.systemFontOfSize(16)
        senderLbl.text = model.username
        cell.contentView.addSubview(senderLbl)
        
        
        //  活动时间
        let dateformate = NSDateFormatter()
        dateformate.dateFormat = "yyyy-MM-dd HH:mm"
        let date = NSDate(timeIntervalSince1970: NSTimeInterval(model.create_time!)!)
        var str:String = dateformate.stringFromDate(date)
        let timeLbl = UILabel()
        timeLbl.frame = CGRectMake(110, height + image_h + 10, WIDTH - 120, 20)
        timeLbl.textAlignment = NSTextAlignment.Right
        timeLbl.font = timefont
        timeLbl.textColor = timeColor
        timeLbl.text = str
        cell.contentView.addSubview(timeLbl)
        
        let line = UILabel()
        line.frame = CGRectMake(1, height + image_h + 40, WIDTH - 2, 0.5)
        line.backgroundColor = UIColor.lightGrayColor()
        cell.addSubview(line)
        
        let all = UILabel()
        all.frame = CGRectMake(10, height + image_h + 50, 60, 20)
        all.text = "总发 "
        all.textColor = UIColor.orangeColor()
        all.font = timefont
        cell.contentView.addSubview(all)
        
        let already = UILabel()
        already.frame = CGRectMake(80, height + image_h + 50, 80, 20)
        let array = NSMutableArray()
//        for i in 0..<model.receive_list.count {
//            let strr = model.receive_list[i].receivertype
//            if strr == "0" {
//                array.addObject(strr)
//            }
//        }
        already.text = "已阅读 "
        already.textColor = UIColor.orangeColor()
        already.font = timefont
        cell.contentView.addSubview(already)
        
        let wei = UILabel()
        wei.frame = CGRectMake(170, height + image_h + 50, 60, 20)
        wei.text = "未读 \(array.count)"
        wei.textColor = UIColor.orangeColor()
        wei.font = UIFont.systemFontOfSize(15)
        cell.contentView.addSubview(wei)
        
        let view = UIView()
        view.frame = CGRectMake(0, height + image_h + 70, WIDTH, 20)
        view.backgroundColor = RGBA(242.0, g: 242.0, b: 242.0, a: 1)
        cell.addSubview(view)
        
        tableView.rowHeight = height + image_h + 90
        print(contentLbl.frame.height)
        print(titleLbl.frame.maxY)
        print(titleLbl.frame.height)
        return cell
    }
    func clickBtn(sender:UIButton){
        
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
    override func viewWillDisappear(animated: Bool) {
        let user = NSUserDefaults.standardUserDefaults()
        user.removeObjectForKey("homeworkArr")
    }
    
}
