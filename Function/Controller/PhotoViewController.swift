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
        tableview.frame=CGRectMake(0, 0,frame.width , frame.height)
        tableview.delegate=self
        tableview.dataSource=self
        let rightItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(PhotoViewController.NewPhoto))
        self.navigationItem.rightBarButtonItem = rightItem
        self.view.addSubview(tableview)
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
        
        titleL.textColor=wenziColor
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
        tableview.rowHeight=30+titleL_h+image_h
        
        //下面的评论视图
//        let senderIV = UIImageView(frame: CGRectMake(10, titleL_h+image_h+25, 20, 20))
//        senderIV.image=UIImage(named: "ic_fasong")
//        cell.contentView.addSubview(senderIV)
//        let senderL = UILabel(frame: CGRectMake(35,titleL_h+image_h+25,120,20))
//        if JZDZinfo.studentname != nil {
//            senderL.text=JZDZinfo.studentname!
//        }
//        senderL.font=UIFont.systemFontOfSize(15)
//        cell.contentView.addSubview(senderL)
//        let timeL = UILabel(frame: CGRectMake(frame.width-150,titleL_h+image_h+25,140,20))
//        timeL.textAlignment = .Right
//        timeL.textColor=timeColor
//        timeL.font=UIFont.systemFontOfSize(15)
//        timeL.text=changeTime(JZDZinfo.create_time!)
//        cell.contentView.addSubview(timeL)
        return cell
    }
    func clickBtn(sender:UIButton) {
        let vc = PhotoBigViewController()
        let model = self.PhotoSource.parentsExhortList[sender.tag]
        vc.arrayInfo = model.pic
        vc.nu = model.pic.count
        self.navigationController?.pushViewController(vc, animated: true)
        
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
