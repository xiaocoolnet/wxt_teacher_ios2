//
//  JZdingzhuViewController.swift
//  WXT_Teacher
//
//  Created by xiaocool on 16/6/1.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
class JZdingzhuViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{

    let JZdingzhuTableView = UITableView()
    var picSource = PiclistInfo()
    var newsInfo = NewsInfo()
    var parentsExhortSource = JZdingzhuModel()
    var pltable = UITableView()
    var ind = Int()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "家长叮嘱"
        JZdingzhuTableView.frame = CGRectMake(0, 0, frame.width, frame.height - 64)
        JZdingzhuTableView.delegate = self
        JZdingzhuTableView.dataSource = self
        JZdingzhuTableView.tableFooterView = UIView(frame: CGRectZero)
        self.view.addSubview(JZdingzhuTableView)
        loadData()
        //MARK: -  添加手势，点击空白处收回键盘
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewtap))
        tap.cancelsTouchesInView=false
        self.view.addGestureRecognizer(tap)
        

        XKeyBoard.registerKeyBoardHide(self)
        XKeyBoard.registerKeyBoardShow(self)

    }
//MARK: -    获取数据
    func loadData(){
    
        //http://wxt.xiaocool.net/index.php?g=apps&m=teacher&a=getentrustlist&teacherid=597
        //下面两句代码是从缓存中取出userid（入参）值
        let defalutid = NSUserDefaults.standardUserDefaults()
        let teacherid = defalutid.stringForKey("userid")
        
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=teacher&a=getentrustlist"
        let param = [
            "teacherid":teacherid
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
                    self.parentsExhortSource = JZdingzhuModel(status.data!)
                    self.JZdingzhuTableView.reloadData()
                    self.JZdingzhuTableView.headerView?.endRefreshing()
                }
            }
        }
    }
//MARK: - tableview代理方法
    //组数
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    //数量
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView==pltable {
            return 1
        }else{
        return parentsExhortSource.count
        }}
    

    //cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        
        let cell = UITableViewCell(style: .Default, reuseIdentifier: String(indexPath.row))
        
        let JZDZinfo = parentsExhortSource.parentsExhortList[indexPath.row]
        let titleL = UILabel()
        titleL.frame=CGRectMake(10,5,frame.width-20,20)
        cell.addSubview(titleL)
        titleL.text=JZDZinfo.content!
        if indexPath.row==0 {
            let user = NSUserDefaults.standardUserDefaults()
            user.setValue(JZDZinfo.content, forKey: "dingzhu")
            
        }
        titleL.textColor=neirongColor
        titleL.font=neirongfont
        //计算lable的高度
        let titleL_h = calculateHeight(titleL.text!, size: 15, width: frame.width-20)
        titleL.numberOfLines=0
        titleL.frame.size.height=titleL_h
        cell.selectionStyle = .None
        var blogimage:UIButton?
        
        
        var image_h = CGFloat()
        let pic = JZDZinfo.pic
        var pics = Array<String>()
        for item in pic {
            pics.append(item.pictureurl!)
        }
        let picView = NinePicView(frame:CGRectMake(0, titleL_h + 10, WIDTH,0),pic:pics,vc:self)
        cell.contentView.addSubview(picView)
        image_h = picView.image_h
        //判断图片张数显示
//            if(JZDZinfo.picCount>0&&JZDZinfo.picCount<=3){
//                image_h=80
//                if  JZDZinfo.picCount==1{
//                   
//                    let pciInfo = JZDZinfo.pic[0]
//                    var imgUrl=String()
//                    if pciInfo.pictureurl != nil {
//                        imgUrl = pictureUrl+(pciInfo.pictureurl)!
//                    }
//                    
//                    //let image = self.imageCache[imgUrl] as UIImage?
//                    let avatarUrl = NSURL(string: imgUrl)
//                    let request: NSURLRequest = NSURLRequest(URL: avatarUrl!)
//                    
//                    NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?)-> Void in
//                        if(data != nil){
//                            
//                            blogimage = UIButton(frame: CGRectMake(20, 20+titleL_h, frame.width-40, 80))
//                            
//                            let imgTmp = UIImage(data: data!)
//                            //self.imageCache[imgUrl] = imgTmp
//                            blogimage!.setImage(imgTmp, forState: .Normal)
//                            if blogimage!.imageView!.image==nil{
//                                blogimage!.setImage(UIImage(named: "4"), forState: .Normal)
//                            }
//                            
//                            blogimage?.tag=indexPath.row
//                            blogimage?.addTarget(self, action: #selector(self.clickBtn(_:)), forControlEvents: .TouchUpInside)
//                            cell.contentView.addSubview(blogimage!)
//                            
//                            
//                        }
//                    })
//                }else{
//                for i in 1...JZDZinfo.picCount{
//                    var x = 8
//                    let pciInfo = JZDZinfo.pic[i-1]
//                    var imgUrl=String()
//                    if pciInfo.pictureurl != nil {
//                         imgUrl = pictureUrl+(pciInfo.pictureurl)!
//                    }
//                    
//                    //let image = self.imageCache[imgUrl] as UIImage?
//                    let avatarUrl = NSURL(string: imgUrl)
//                    let request: NSURLRequest = NSURLRequest(URL: avatarUrl!)
//                    
//                    NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?)-> Void in
//                        if(data != nil){
//                            x = x+((i-1)*85)
//                            blogimage = UIButton(frame: CGRectMake(CGFloat(x), 20+titleL_h, 80, 80))
//                          
//                            let imgTmp = UIImage(data: data!)
//                            //self.imageCache[imgUrl] = imgTmp
//                            blogimage!.setImage(imgTmp, forState: .Normal)
//                            if blogimage!.imageView!.image==nil{
//                               blogimage!.setImage(UIImage(named: "4"), forState: .Normal)
//                            }
//
//                           blogimage?.tag=indexPath.row
//                            blogimage?.addTarget(self, action: #selector(self.clickBtn(_:)), forControlEvents: .TouchUpInside)
//                            cell.contentView.addSubview(blogimage!)
//                           
//                            
//                        }
//                    })
//                    }}
//            }
//            if(JZDZinfo.picCount>3&&JZDZinfo.picCount<=6){
//                image_h=170
//                for i in 1...JZDZinfo.picCount{
//                    if i <= 3 {
//                        var x = 8
//                        let pciInfo = JZDZinfo.pic[i-1]
//                        if pciInfo.pictureurl != nil {
//                            
//                        
//                        let imgUrl = pictureUrl+(pciInfo.pictureurl)!
//                        
//                        //let image = self.imageCache[imgUrl] as UIImage?
//                        let avatarUrl = NSURL(string: imgUrl)
//                        let request: NSURLRequest = NSURLRequest(URL: avatarUrl!)
//                        
//                        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?)-> Void in
//                            if(data != nil){
//                                x = x+((i-1)*85)
//                                blogimage = UIButton(frame: CGRectMake(CGFloat(x), 20+titleL_h, 80, 80))
//                                let imgTmp = UIImage(data: data!)
//                                //self.imageCache[imgUrl] = imgTmp
//                                blogimage!.imageView!.image = imgTmp
//                                if blogimage!.imageView!.image==nil{
//                                    blogimage!.setImage(UIImage(named: "4"), forState: .Normal)
//                                }
//                                blogimage?.tag=indexPath.row
//                                blogimage?.addTarget(self, action: #selector(self.clickBtn(_:)), forControlEvents: .TouchUpInside)
//                                cell.contentView.addSubview(blogimage!)
//                        }
//                        })
//                        }}else{
//                        var x = 8
//                        let pciInfo = JZDZinfo.pic[i-1]
//                        if pciInfo.pictureurl != nil {
//                        let imgUrl = pictureUrl+(pciInfo.pictureurl)!
//                        
//                        //let image = self.imageCache[imgUrl] as UIImage?
//                        let avatarUrl = NSURL(string: imgUrl)
//                        let request: NSURLRequest = NSURLRequest(URL: avatarUrl!)
//                        
//                        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?)-> Void in
//                            if(data != nil){
//                                x = x+((i-4)*85)
//                                blogimage = UIButton(frame: CGRectMake(CGFloat(x), 20+titleL_h+85, 80, 80))
//                                let imgTmp = UIImage(data: data!)
//                               blogimage!.setImage(imgTmp, forState: .Normal)
//                                if blogimage!.imageView!.image==nil{
//                                   blogimage!.setImage(UIImage(named: "4"), forState: .Normal)
//                                }
//                                blogimage?.tag=indexPath.row
//                                blogimage?.addTarget(self, action: #selector(self.clickBtn(_:)), forControlEvents: .TouchUpInside)
//                                cell.contentView.addSubview(blogimage!)
//                            }
//                        })
//                        
//                    }
//                }
//                }}
//            if(JZDZinfo.picCount>6&&JZDZinfo.picCount<=9){
//                image_h=260
//                for i in 1...JZDZinfo.picCount{
//                    if i <= 3 {
//                        var x = 8
//                        let pciInfo = JZDZinfo.pic[i-1]
//                        if pciInfo.pictureurl != nil {
//                        let imgUrl = pictureUrl+(pciInfo.pictureurl)!
//                        
//                        //let image = self.imageCache[imgUrl] as UIImage?
//                        let avatarUrl = NSURL(string: imgUrl)
//                        let request: NSURLRequest = NSURLRequest(URL: avatarUrl!)
//                        
//                        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?)-> Void in
//                            if(data != nil){
//                                x = x+((i-1)*85)
//                                blogimage = UIButton(frame: CGRectMake(CGFloat(x), 20+titleL_h, 80, 80))
//                                let imgTmp = UIImage(data: data!)
//                                //self.imageCache[imgUrl] = imgTmp
//                                 blogimage!.setImage(imgTmp, forState: .Normal)
//                                if blogimage!.imageView!.image==nil{
//                                    blogimage!.setImage(UIImage(named: "4"), forState: .Normal)
//                                }
//                                blogimage?.tag=indexPath.row
//                                blogimage?.addTarget(self, action: #selector(self.clickBtn(_:)), forControlEvents: .TouchUpInside)
//                                cell.contentView.addSubview(blogimage!)
//                            }
//                        })
//                        
//                        }}else if (i>3&&i<=6){
//                        var x = 8
//                        let pciInfo = JZDZinfo.pic[i-1]
//                        if pciInfo.pictureurl != nil {
//                        let imgUrl = pictureUrl+(pciInfo.pictureurl)!
//                        
//                        //let image = self.imageCache[imgUrl] as UIImage?
//                        let avatarUrl = NSURL(string: imgUrl)
//                        let request: NSURLRequest = NSURLRequest(URL: avatarUrl!)
//                        
//                        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?)-> Void in
//                            if(data != nil){
//                                x = x+((i-4)*85)
//                                blogimage = UIButton(frame: CGRectMake(CGFloat(x), 20+titleL_h+85, 80, 80))
//                                let imgTmp = UIImage(data: data!)
//                                //self.imageCache[imgUrl] = imgTmp
//                                blogimage!.setImage(imgTmp, forState: .Normal)
//                                if blogimage!.imageView!.image==nil{
//                                   blogimage!.setImage(UIImage(named: "4"), forState: .Normal)
//                                }
//                                blogimage?.tag=indexPath.row
//                                blogimage?.addTarget(self, action: #selector(self.clickBtn(_:)), forControlEvents: .TouchUpInside)
//                                cell.contentView.addSubview(blogimage!)
//                            }
//                        })
//                        
//                        } }else{
//                        var x = 8
//                        let pciInfo = JZDZinfo.pic[i-1]
//                            if pciInfo.pictureurl != nil {
//                        let imgUrl = pictureUrl+(pciInfo.pictureurl)!
//                        
//                        //let image = self.imageCache[imgUrl] as UIImage?
//                        let avatarUrl = NSURL(string: imgUrl)
//                        let request: NSURLRequest = NSURLRequest(URL: avatarUrl!)
//                        
//                        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?)-> Void in
//                            if(data != nil){
//                                x = x+((i-7)*85)
//                                blogimage = UIButton(frame: CGRectMake(CGFloat(x), 20+titleL_h+85+85, 80, 80))
//                                let imgTmp = UIImage(data: data!)
//                                //self.imageCache[imgUrl] = imgTmp
//                                blogimage!.setImage(imgTmp, forState: .Normal)
//                                if blogimage!.imageView!.image==nil{
//                                    blogimage!.setImage(UIImage(named: "4"), forState: .Normal)
//                                }
//                                blogimage?.tag=indexPath.row
//                                blogimage?.addTarget(self, action: #selector(self.clickBtn(_:)), forControlEvents: .TouchUpInside)
//                                cell.contentView.addSubview(blogimage!)
//                            }
//                        })
//                    }
//                    }
//                }}
        //下面的评论视图
        let senderIV = UIImageView(frame: CGRectMake(10, titleL_h+image_h+25, 20, 20))
        senderIV.image=UIImage(named: "ic_fasong")
        cell.contentView.addSubview(senderIV)
        let senderL = UILabel(frame: CGRectMake(35,titleL_h+image_h+25,120,20))
        if JZDZinfo.studentname != nil {
            senderL.text=JZDZinfo.studentname!
        }
        senderL.font=timefont
        senderL.textColor=timeColor
        cell.contentView.addSubview(senderL)
        let timeL = UILabel(frame: CGRectMake(frame.width-150,titleL_h+image_h+25,140,20))
        timeL.textAlignment = .Right
        timeL.textColor=timeColor
        timeL.font=timefont
        timeL.text=changeTime(JZDZinfo.create_time!)
        cell.contentView.addSubview(timeL)
        
        let textField = UITextField(frame: CGRectMake(10,titleL_h+image_h+55,frame.width/4*3,30))
        textField.layer.masksToBounds=true
        textField.layer.cornerRadius=4
        textField.placeholder="回复一下家长吧～"
        textField.tag=Int(JZDZinfo.id!)!
        textField.backgroundColor=UIColor.init(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        
        cell.contentView.addSubview(textField)
        let senderBT = UIButton(frame: CGRectMake(10+frame.width/4*3+10,titleL_h+image_h+55,frame.width-30-frame.width/4*3,30))
        senderBT.setTitle("发送", forState: .Normal)
        senderBT.backgroundColor=UIColor.init(red: 194/255, green: 221/255, blue: 163/255, alpha: 1)
            senderBT.tag=Int(JZDZinfo.id!)!
        senderBT.layer.masksToBounds=true
        senderBT.layer.cornerRadius=4
            senderBT.addTarget(self, action: #selector(senderPinglun(_:)), forControlEvents: .TouchUpInside)
        cell.contentView.addSubview(senderBT)
//MARK: - 评论的view
        if JZDZinfo.comment.count != 0 {
            textField.hidden=true
            senderBT.hidden=true
            let pinglunView = UIView(frame: CGRectMake(5,titleL_h+image_h+55+10,frame.width-10,60))
            pinglunView.backgroundColor=UIColor.init(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
            pinglunView.layer.cornerRadius=5
            cell.contentView.addSubview(pinglunView)
            
            let icon=UIImageView(frame: CGRectMake(5, 5, 50, 50))
            icon.layer.masksToBounds=true
            icon.layer.cornerRadius=25
            
            icon.image=UIImage(named: "4")
            pinglunView.addSubview(icon)
            let nameL = UILabel(frame: CGRectMake(60,5,frame.width-70,20))
            nameL.text=JZDZinfo.comment.first?.name
            nameL.font=UIFont.systemFontOfSize(14)
            pinglunView.addSubview(nameL)
            let contentL = UILabel(frame: CGRectMake(60,30,frame.width-70,20))
            contentL.textColor=wenziColor
            
            contentL.lineBreakMode  = NSLineBreakMode.ByWordWrapping
            contentL.numberOfLines=0
            contentL.text=JZDZinfo.comment.first?.content
            contentL.font=UIFont.systemFontOfSize(14)
            let content_h = calculateHeight(contentL.text!, size: 14, width: frame.width-70)
            
            pinglunView.frame.size.height=40+content_h
            contentL.frame.size.height=content_h
            pinglunView.addSubview(contentL)
            
            
            tableView.rowHeight=40+titleL_h+image_h+95+content_h
            
            
        }else{
        
            tableView.rowHeight=40+titleL_h+image_h+35+20

        }
        
            return cell
        }
    func senderPinglun(sender:UIButton){
        print(sender.tag)
        
        let textfield = self.view.viewWithTag(sender.tag) as! UITextField
        let content = textfield.text
        if textfield.text=="" {
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.mode = MBProgressHUDMode.Text
            hud.labelText = "请输入回复内容"
            hud.margin = 10.0
            hud.removeFromSuperViewOnHide = true
            hud.hide(true, afterDelay: 1)
        }else{
        print(content)
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=school&a="+"SetComment"
        let userid = NSUserDefaults.standardUserDefaults()
        let uid = userid.stringForKey("userid")
        let id = String(sender.tag)
        
        let param = [
            
            "userid":uid,
            "id":id,
            "content":content,
            "type":"4"
            
        ]
        print(url)
        Alamofire.request(.GET, url, parameters: param as? [String : String]).response { request, response, json, error in
            if(error != nil){
            }
            else{
                print("request是")
                print(request!)
                print("====================")
                let status = Httpresult(JSONDecoder(json!))
                print(JSONDecoder(json!))
                print("状态是")
                print(status.status)
                if(status.status == "error"){
                    let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                    hud.mode = MBProgressHUDMode.Text;
                    hud.labelText = status.errorData
                    hud.margin = 10.0
                    hud.removeFromSuperViewOnHide = true
                    hud.hide(true, afterDelay: 3)
                }
                if(status.status == "success"){
                    print("评论成功")
                    textfield.text=""
                    self.loadData()
                    self.self.JZdingzhuTableView.reloadData()
                }
            }
        }
        
    }
    }
    func clickBtn(sender:UIButton) {
        let vc = JZPicViewController()
        let model = self.parentsExhortSource.parentsExhortList[sender.tag]
        vc.arrayInfo = model.pic
        vc.nu = model.pic.count
        self.navigationController?.pushViewController(vc, animated: true)
        
    }

    func Pinglun(sender:UIButton){
        print(sender.tag)
      
        let textfield = self.view.viewWithTag(sender.tag) as? UITextField
        let content = textfield?.text
        print(content)
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=school&a="+"SetComment"
        let userid = NSUserDefaults.standardUserDefaults()
        let uid = userid.stringForKey("userid")
        let id = String(sender.tag)
        
        let param = [
            
            "userid":uid,
            "id":id,
            "content":content,
            "type":"4"
            
        ]
        print(url)
        Alamofire.request(.GET, url, parameters: param as? [String : String]).response { request, response, json, error in
            if(error != nil){
            }
            else{
                print("request是")
                print(request!)
                print("====================")
                let status = Httpresult(JSONDecoder(json!))
                print(JSONDecoder(json!))
                print("状态是")
                print(status.status)
                if(status.status == "error"){
                    let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                    hud.mode = MBProgressHUDMode.Text;
                    hud.labelText = status.errorData
                    hud.margin = 10.0
                    hud.removeFromSuperViewOnHide = true
                    hud.hide(true, afterDelay: 3)
                }
                if(status.status == "success"){
                    print("评论成功")
                    textfield?.text=""
                    self.loadData()
                    self.self.JZdingzhuTableView.reloadData()
                }
            }
        }
        
    }

    //         键盘消失的通知方法
    func keyboardWillHideNotification(notification:NSNotification){
        UIView.animateWithDuration(0.3) { () -> Void in
            self.JZdingzhuTableView.frame = CGRectMake(0, 0, frame.width, frame.height-64)
            self.view.layoutIfNeeded()
     
            
        }
        
    }
    //     键盘出现的通知方法
    func keyboardWillShowNotification(notification:NSNotification){
        UIView.animateWithDuration(0.3) { () -> Void in
            self.JZdingzhuTableView.frame = CGRectMake(0, -150, frame.width, frame.height-64-50)
            self.view.layoutIfNeeded()
        
        }
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

    }
    //隐藏键盘的方法
    func viewtap(){
        self.view.endEditing(true)
   
        
        
    }
    override func viewWillAppear(animated: Bool) {
        let user = NSUserDefaults.standardUserDefaults()
        user.removeObjectForKey("trustArr")
    }
    override func viewWillDisappear(animated: Bool) {
        let user = NSUserDefaults.standardUserDefaults()
        user.removeObjectForKey("trustArr")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  }
