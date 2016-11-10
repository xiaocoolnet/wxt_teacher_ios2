//
//  PhotoViewController.swift
//  WXT_Teacher
//
//  Created by 李春波 on 16/3/9.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
import XWSwiftRefresh
class PhotoViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    var tableview = UITableView()
    var frame = UIScreen.mainScreen().bounds.size
    
    var PhotoSource = PhotoModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "班级相册"
        loadData()
        self.view.backgroundColor = UIColor.whiteColor()
        self.tabBarController?.tabBar.hidden = true
        tableview.frame=CGRectMake(0, 0,frame.width , frame.height-44)
        tableview.delegate=self
        tableview.dataSource=self
        tableview.separatorStyle = .None
        let rightItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(PhotoViewController.NewPhoto))
        self.navigationItem.rightBarButtonItem = rightItem
        self.view.addSubview(tableview)
        DropDownUpdate()
    }
    //    开始刷新
    func DropDownUpdate(){
        self.tableview.headerView = XWRefreshNormalHeader(target: self, action: #selector(PhotoViewController.loadData))
        self.tableview.reloadData()
        self.tableview.headerView?.beginRefreshing()
    }

    //MARK: -    获取数据
    func loadData(){
        
        //http://wxt.xiaocool.net/index.php?g=apps&m=index&a=GetMicroblog&schoolid=1&classid=1

        //下面两句代码是从缓存中取出userid（入参）值
        let defalutid = NSUserDefaults.standardUserDefaults()
        let classid = defalutid.stringForKey("classid")
        let schoolid = defalutid.stringForKey("schoolid")
        let userid = defalutid.stringForKey("userid")
        
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=index&a=GetMicroblog"
        let param = [
            "userid":userid,
            "classid":classid,
            "schoolid":schoolid,
            "type":"2",
            "beginid":"0"
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
                    self.PhotoSource=PhotoModel(status.data!)
                    self.tableview.reloadData()
                    self.tableview.headerView?.endRefreshing()
                }
            }
        }
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return PhotoSource.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let photoinfo = PhotoSource.parentsExhortList[indexPath.row]
        
        let cell = UITableViewCell(style: .Default, reuseIdentifier: String(indexPath.row))
        let titleL = UILabel()
        titleL.frame=CGRectMake(10,5,frame.width-20,20)
        cell.addSubview(titleL)
        titleL.text=photoinfo.content!
        
        titleL.textColor=neirongColor
        titleL.font=neirongfont
        //计算lable的高度
        let titleL_h = calculateHeight(titleL.text!, size: 17, width: frame.width-20)
        titleL.numberOfLines=0
        titleL.frame.size.height=titleL_h
        cell.selectionStyle = .None
        var blogimage:UIButton?
        var image_h = CGFloat()
        
        //判断图片张数显示
        if(photoinfo.picCount>0&&photoinfo.picCount<=3){
            image_h=80
            for i in 1...photoinfo.picCount{
                var x = 8
                let pciInfo = photoinfo.pic[i-1]
                let imgUrl = pictureUrl+(pciInfo.pictureurl)!
                print(imgUrl)
                
                //let image = self.imageCache[imgUrl] as UIImage?
                let avatarUrl = NSURL(string: imgUrl)
                let request: NSURLRequest = NSURLRequest(URL: avatarUrl!)
                
                NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?)-> Void in
                    if(data != nil){
                        x = x+((i-1)*85)
                        blogimage = UIButton(frame: CGRectMake(CGFloat(x), 20+titleL_h, 80, 80))
                        let imgTmp = UIImage(data: data!)
                        //self.imageCache[imgUrl] = imgTmp
                        blogimage?.setImage(imgTmp, forState: .Normal)
                        if blogimage?.imageView?.image==nil{
                            blogimage?.setImage(UIImage(named: "4"), forState: .Normal)
                        }
                        blogimage?.tag=indexPath.row
                        blogimage?.addTarget(self, action: #selector(self.clickBtn(_:)), forControlEvents: .TouchUpInside)
                        cell.contentView.addSubview(blogimage!)
                        
                    }
                })
                
            }
        }
        if(photoinfo.picCount>3&&photoinfo.picCount<=6){
            image_h=170
            for i in 1...photoinfo.picCount{
                if i <= 3 {
                    var x = 8
                    let pciInfo = photoinfo.pic[i-1]
                    if pciInfo.pictureurl != nil {
                        
                        
                        let imgUrl = pictureUrl+(pciInfo.pictureurl)!
                        
                        //let image = self.imageCache[imgUrl] as UIImage?
                        let avatarUrl = NSURL(string: imgUrl)
                        let request: NSURLRequest = NSURLRequest(URL: avatarUrl!)
                        
                        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?)-> Void in
                            if(data != nil){
                                x = x+((i-1)*85)
                                blogimage = UIButton(frame: CGRectMake(CGFloat(x), 20+titleL_h, 80, 80))
                                let imgTmp = UIImage(data: data!)
                                //self.imageCache[imgUrl] = imgTmp
                                blogimage?.setImage(imgTmp, forState: .Normal)
                                if blogimage?.imageView?.image==nil{
                                    blogimage?.setImage(UIImage(named: "4"), forState: .Normal)
                                }

                                blogimage?.tag=indexPath.row
                                blogimage?.addTarget(self, action: #selector(self.clickBtn(_:)), forControlEvents: .TouchUpInside)
                                cell.contentView.addSubview(blogimage!)
                            }
                        })
                    }}else{
                    var x = 8
                    let pciInfo = photoinfo.pic[i-1]
                    if pciInfo.pictureurl != nil {
                        let imgUrl = pictureUrl+(pciInfo.pictureurl)!
                        
                        //let image = self.imageCache[imgUrl] as UIImage?
                        let avatarUrl = NSURL(string: imgUrl)
                        let request: NSURLRequest = NSURLRequest(URL: avatarUrl!)
                        
                        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?)-> Void in
                            if(data != nil){
                                x = x+((i-4)*85)
                                blogimage = UIButton(frame: CGRectMake(CGFloat(x), 20+titleL_h+90, 80, 80))
                                let imgTmp = UIImage(data: data!)
                                //self.imageCache[imgUrl] = imgTmp
                                blogimage?.setImage(imgTmp, forState: .Normal)
                                if blogimage?.imageView?.image==nil{
                                    blogimage?.setImage(UIImage(named: "4"), forState: .Normal)
                                }
                                blogimage?.tag=indexPath.row
                                blogimage?.addTarget(self, action: #selector(self.clickBtn(_:)), forControlEvents: .TouchUpInside)
                                cell.contentView.addSubview(blogimage!)
                            }
                        })
                        
                    }
                }
            }}
        if(photoinfo.picCount>6&&photoinfo.picCount<=9){
            image_h=260
            for i in 1...photoinfo.picCount{
                if i <= 3 {
                    var x = 8
                    let pciInfo = photoinfo.pic[i-1]
                    if pciInfo.pictureurl != nil {
                        let imgUrl = pictureUrl+(pciInfo.pictureurl)!
                        
                        //let image = self.imageCache[imgUrl] as UIImage?
                        let avatarUrl = NSURL(string: imgUrl)
                        let request: NSURLRequest = NSURLRequest(URL: avatarUrl!)
                        
                        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?)-> Void in
                            if(data != nil){
                                x = x+((i-1)*85)
                                blogimage = UIButton(frame: CGRectMake(CGFloat(x), 20+titleL_h, 80, 80))
                                let imgTmp = UIImage(data: data!)
                                //self.imageCache[imgUrl] = imgTmp
                                blogimage?.setImage(imgTmp, forState: .Normal)
                                if blogimage?.imageView?.image==nil{
                                    blogimage?.setImage(UIImage(named: "4"), forState: .Normal)
                                }
                                blogimage?.tag=indexPath.row
                                blogimage?.addTarget(self, action: #selector(self.clickBtn(_:)), forControlEvents: .TouchUpInside)
                                cell.contentView.addSubview(blogimage!)
                            }
                        })
                        
                    }}else if (i>3&&i<=6){
                    var x = 8
                    let pciInfo = photoinfo.pic[i-1]
                    if pciInfo.pictureurl != nil {
                        let imgUrl = pictureUrl+(pciInfo.pictureurl)!
                        
                        //let image = self.imageCache[imgUrl] as UIImage?
                        let avatarUrl = NSURL(string: imgUrl)
                        let request: NSURLRequest = NSURLRequest(URL: avatarUrl!)
                        
                        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?)-> Void in
                            if(data != nil){
                                x = x+((i-4)*85)
                                blogimage = UIButton(frame: CGRectMake(CGFloat(x), 20+titleL_h+90, 80, 80))
                                let imgTmp = UIImage(data: data!)
                                //self.imageCache[imgUrl] = imgTmp
                                blogimage?.setImage(imgTmp, forState: .Normal)
                                if blogimage?.imageView?.image==nil{
                                    blogimage?.setImage(UIImage(named: "4"), forState: .Normal)
                                }
                                blogimage?.tag=indexPath.row
                                blogimage?.addTarget(self, action: #selector(self.clickBtn(_:)), forControlEvents: .TouchUpInside)
                                cell.contentView.addSubview(blogimage!)
                            }
                        })
                        
                    } }else{
                    var x = 8
                    let pciInfo = photoinfo.pic[i-1]
                    if pciInfo.pictureurl != nil {
                        let imgUrl = pictureUrl+(pciInfo.pictureurl)!
                        
                        //let image = self.imageCache[imgUrl] as UIImage?
                        let avatarUrl = NSURL(string: imgUrl)
                        let request: NSURLRequest = NSURLRequest(URL: avatarUrl!)
                        
                        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?)-> Void in
                            if(data != nil){
                                x = x+((i-7)*85)
                                blogimage = UIButton(frame: CGRectMake(CGFloat(x), 20+titleL_h+180, 80, 80))
                                let imgTmp = UIImage(data: data!)
                                //self.imageCache[imgUrl] = imgTmp
                                blogimage?.setImage(imgTmp, forState: .Normal)
                                if blogimage?.imageView?.image==nil{
                                    blogimage?.setImage(UIImage(named: "4"), forState: .Normal)
                                }
                                blogimage?.tag=indexPath.row
                                blogimage?.addTarget(self, action: #selector(self.clickBtn(_:)), forControlEvents: .TouchUpInside)
                                cell.contentView.addSubview(blogimage!)
                            }
                        })
                        
                    }
                    
                }
                
            }}
        
        
        //下面的评论视图
        let senderIV = UIImageView(frame: CGRectMake(10, titleL_h+image_h+25, 20, 20))
        senderIV.image=UIImage(named: "ic_fasong")
        cell.contentView.addSubview(senderIV)
        let senderL = UILabel(frame: CGRectMake(35,titleL_h+image_h+25,120,20))
        if photoinfo.name != nil {
            senderL.text=photoinfo.name!
        }
        senderL.font=timefont
        senderL.textColor=timeColor
        cell.contentView.addSubview(senderL)
        let timeL = UILabel(frame: CGRectMake(frame.width-150,titleL_h+image_h+25,140,20))
        timeL.textAlignment = .Right
        timeL.textColor=timeColor
        timeL.font=timefont
        timeL.text=changeTime(photoinfo.write_time!)
        cell.contentView.addSubview(timeL)
        //MARK: - 点赞按钮
        let zanBT = UIButton(frame: CGRectMake(frame.width-100, titleL_h+image_h+25+30, 20, 20))
        zanBT.setImage(UIImage(named: "点赞"), forState: .Normal)
        zanBT.tag=Int(photoinfo.mid!)!
        let userid = NSUserDefaults.standardUserDefaults()
        let uid = userid.stringForKey("userid")
        if photoinfo.photolikelist.count != 0 {
            for item in 0...photoinfo.photolikelist.count-1 {
                if photoinfo.photolikelist[item].userid==uid {
                    zanBT.setImage(UIImage(named: "已点赞"), forState: .Normal)
                    break
                }
            }
        }
        if zanBT.imageView?.image==UIImage(named:"点赞") {
             zanBT.addTarget(self, action: #selector(dianzan(_:)), forControlEvents: .TouchUpInside)
        }else{
            zanBT.addTarget(self, action: #selector(quxiaodianzan(_:)), forControlEvents: .TouchUpInside)
        }
        
       
        cell.contentView.addSubview(zanBT)
        let plBT = UIButton(frame: CGRectMake(frame.width-50, titleL_h+image_h+25+30, 20, 20))
        plBT.setImage(UIImage(named: "发消息"), forState: .Normal)
        cell.contentView.addSubview(plBT) 
        
        let textField = UITextField(frame: CGRectMake(10,titleL_h+image_h+85,frame.width/4*3,30))
        textField.layer.masksToBounds=true
        textField.layer.cornerRadius=4
        textField.tag=Int(photoinfo.mid!)!+100
        textField.backgroundColor=UIColor.init(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        
        cell.contentView.addSubview(textField)
        let senderBT = UIButton(frame: CGRectMake(10+frame.width/4*3+10,titleL_h+image_h+85,frame.width-30-frame.width/4*3,30))
        senderBT.setTitle("发送", forState: .Normal)
        senderBT.backgroundColor=UIColor.init(red: 194/255, green: 221/255, blue: 163/255, alpha: 1)
        senderBT.tag=Int(photoinfo.mid!)!+100
        senderBT.layer.masksToBounds=true
        senderBT.layer.cornerRadius=4
        senderBT.addTarget(self, action: #selector(Pinglun(_:)), forControlEvents: .TouchUpInside)
        cell.contentView.addSubview(senderBT)
        if photoinfo.PhotoComment.count != 0 {
            for item in 0...photoinfo.PhotoComment.count-1 {
                
            let pinglunView = UIView(frame: CGRectMake(5,titleL_h+image_h+90+30+60*CGFloat(item),frame.width-10,60))
            pinglunView.backgroundColor=bkColor
                pinglunView.layer.cornerRadius=5
            cell.contentView.addSubview(pinglunView)
            
            let icon=UIImageView(frame: CGRectMake(5, 5, 50, 50))
            icon.layer.masksToBounds=true
            icon.layer.cornerRadius=25
            icon.image=UIImage(named: "4")
            pinglunView.addSubview(icon)
            let nameL = UILabel(frame: CGRectMake(60,5,frame.width-70,20))
            nameL.text=photoinfo.PhotoComment[item].name
            nameL.font=UIFont.systemFontOfSize(14)
            pinglunView.addSubview(nameL)
            let contentL = UILabel(frame: CGRectMake(60,30,frame.width-70,20))
            contentL.textColor=pinglunColor
            
            contentL.lineBreakMode  = NSLineBreakMode.ByWordWrapping
            contentL.numberOfLines=0
            contentL.text=photoinfo.PhotoComment[item].content
            contentL.font=UIFont.systemFontOfSize(14)
            let content_h = calculateHeight(contentL.text!, size: 14, width: frame.width-70)
            
            pinglunView.frame.size.height=40+content_h
            contentL.frame.size.height=content_h
            pinglunView.addSubview(contentL)
            }
            tableview.rowHeight=30+titleL_h+image_h+20+40+60*CGFloat(photoinfo.PhotoComment.count)+40
            
            
        }else{
        
            tableview.rowHeight=30+titleL_h+image_h+20+40+40
            
        }
        let view = UIView(frame: CGRectMake(0,tableView.rowHeight-4,frame.width,4))
        view.backgroundColor=bkColor
        cell.addSubview(view)
        

        
        return cell
    }
    func clickBtn(sender:UIButton) {
        let vc = PhotoBigViewController()
        let model = self.PhotoSource.parentsExhortList[sender.tag]
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
        let id = String(sender.tag-100)
        
        let param = [
            
            "userid":uid,
            "id":id,
            "content":content,
            "type":"2"
            
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
                    self.self.tableview.reloadData()
                }
            }
        }
        
    }
    func dianzan(sender:UIButton){
        
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=school&a=SetLike"
        let userid = NSUserDefaults.standardUserDefaults()
        let uid = userid.stringForKey("userid")
        let id = String(sender.tag)
        
        let param = [
            
            "userid":uid,
            "id":id,
            "type":"2"
            
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
                    sender.setImage(UIImage(named: "已点赞"), forState: .Normal)

                     self.loadData()
                    self.self.tableview.reloadData()
                    
                }
            }
        }

    }
    func quxiaodianzan(sender:UIButton){
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=school&a=ResetLike"
        let userid = NSUserDefaults.standardUserDefaults()
        let uid = userid.stringForKey("userid")
        let id = String(sender.tag)
        
        let param = [
            
            "userid":uid,
            "id":id,
            "type":"2"
            
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
                    sender.setImage(UIImage(named: "点赞"), forState: .Normal)

                    self.loadData()
                    self.self.tableview.reloadData()
                    
                }
            }
        }

    }
    func NewPhoto(){
        let newPhoto = NewPhotoViewController()
        self.navigationController?.pushViewController(newPhoto, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
