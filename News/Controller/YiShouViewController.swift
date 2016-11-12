//
//  YiShouViewController.swift
//  WXT_Teacher
//
//  Created by xiaocool on 16/7/22.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
class YiShouViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{
let DaiBanTableView = UITableView()
    var DaibanSource = DaiBanModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title="已收代办事项"
        self.view.backgroundColor=UIColor.whiteColor()
        DaiBanTableView.frame = CGRectMake(0, 0, frame.width, frame.height - 64-44)
        DaiBanTableView.delegate = self
        DaiBanTableView.dataSource = self
        DaiBanTableView.tableFooterView = UIView(frame: CGRectZero)
        loadData()
        self.view.addSubview(DaiBanTableView)
        
        // Do any additional setup after loading the view.
    }
    //MARK: -    获取数据
    func loadData(){
        
    //http://wxt.xiaocool.net/index.php?g=apps&m=school&a=GetMyReciveSchedulelist&userid=597&schoolid=1
        //下面两句代码是从缓存中取出userid（入参）值
        let defalutid = NSUserDefaults.standardUserDefaults()
        let teacherid = defalutid.stringForKey("userid")
        let schoolid = defalutid.stringForKey("schoolid")
        
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=school&a=GetMyReciveSchedulelist"
        let param = [
            "userid":teacherid,
            "schoolid":schoolid
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
                    self.DaibanSource = DaiBanModel(status.data!)
                    self.DaiBanTableView.reloadData()
                    self.DaiBanTableView.headerView?.endRefreshing()
                }
            }
        }
    }
   
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return DaibanSource.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let daibaninfo = DaibanSource.parentsExhortList[indexPath.row]
        
        let cell = UITableViewCell(style: .Default, reuseIdentifier: String(indexPath.row))
        let titleL = UILabel()
        titleL.frame=CGRectMake(10,5,frame.width-20,20)
        cell.contentView.addSubview(titleL)
        titleL.text=daibaninfo.title!
        titleL.textColor=biaotiColor
        titleL.font=biaotifont
    
        //计算lable的高度
        let titleL_h = calculateHeight(titleL.text!, size: 17, width: frame.width-20)
        titleL.numberOfLines=0
        titleL.frame.size.height=titleL_h
        let contentL = UILabel()
        contentL.frame=CGRectMake(10,titleL_h+15,frame.width-20,20)
        cell.contentView.addSubview(contentL)
        contentL.textColor=UIColor.grayColor()
        contentL.text=daibaninfo.content!
        if indexPath.row==0 {
            let user = NSUserDefaults.standardUserDefaults()
            user.setValue(daibaninfo.content, forKey: "daiban")
            
        }
        contentL.font=neirongfont
        contentL.textColor=neirongColor
        //计算lable的高度
        let contentL_h = calculateHeight(contentL.text!, size: 15, width: frame.width-20)
        contentL.numberOfLines=0
        contentL.frame.size.height=contentL_h
        
        
        var blogimage:UIImageView?
        var image_h = CGFloat()
        
//        判断图片张数显示
        if(daibaninfo.picCount>0&&daibaninfo.picCount<=3){
            image_h=300
            if daibaninfo.picCount==1 {
                
                let pciInfo = daibaninfo.pic[0]
                let imgUrl = pictureUrl+(pciInfo.picture_url)!
                
                //let image = self.imageCache[imgUrl] as UIImage?
                let avatarUrl = NSURL(string: imgUrl)
                let request: NSURLRequest = NSURLRequest(URL: avatarUrl!)
                
                NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?)-> Void in
                    if(data != nil){
                        
                        blogimage = UIImageView(frame: CGRectMake(20, titleL_h+contentL_h+25, frame.width-40, 300))
                        let imgTmp = UIImage(data: data!)
                        //self.imageCache[imgUrl] = imgTmp
                        blogimage!.image = imgTmp
                        if blogimage?.image==nil{
                            blogimage?.image=UIImage(named: "Logo")
                        }
                        cell.contentView.addSubview(blogimage!)
                        
                    }
                })
            }else{
                for i in 2...daibaninfo.picCount{
                var x = 8
                let pciInfo = daibaninfo.pic[i-1]
                let imgUrl = pictureUrl+(pciInfo.picture_url)!
                
                //let image = self.imageCache[imgUrl] as UIImage?
                let avatarUrl = NSURL(string: imgUrl)
                let request: NSURLRequest = NSURLRequest(URL: avatarUrl!)
                
                NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?)-> Void in
                    if(data != nil){
                        x = x+((i-1)*(intmax_t)((WIDTH-40)/3+5))
                        blogimage = UIImageView(frame: CGRectMake(CGFloat(x), titleL_h+contentL_h+25, (WIDTH-40)/3, (WIDTH-40)/3))
                        let imgTmp = UIImage(data: data!)
                        //self.imageCache[imgUrl] = imgTmp
                        blogimage!.image = imgTmp
                        cell.contentView.addSubview(blogimage!)
                        
                    }
                })
                
                }}
        }
        if(daibaninfo.picCount>3&&daibaninfo.picCount<=6){
            image_h=170
            for i in 1...daibaninfo.picCount{
                if i <= 3 {
                    var x = 8
                    let pciInfo = daibaninfo.pic[i-1]
                    if pciInfo.picture_url != nil {
                        
                        
                        let imgUrl = picUrl+(pciInfo.picture_url)!
                        
                        //let image = self.imageCache[imgUrl] as UIImage?
                        let avatarUrl = NSURL(string: imgUrl)
                        let request: NSURLRequest = NSURLRequest(URL: avatarUrl!)
                        
                        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?)-> Void in
                            if(data != nil){
                                x = x+((i-1)*(intmax_t)((WIDTH-40)/3+5))
                                blogimage = UIImageView(frame: CGRectMake(CGFloat(x), titleL_h+contentL_h+25, (WIDTH-40)/3, (WIDTH-40)/3))
                                let imgTmp = UIImage(data: data!)
                                //self.imageCache[imgUrl] = imgTmp
                                blogimage!.image = imgTmp
                                
                                cell.contentView.addSubview(blogimage!)
                            }
                        })
                    }}else{
                    var x = 8
                    let pciInfo = daibaninfo.pic[i-1]
                    if pciInfo.picture_url != nil {
                        let imgUrl = picUrl+(pciInfo.picture_url)!
                        
                        //let image = self.imageCache[imgUrl] as UIImage?
                        let avatarUrl = NSURL(string: imgUrl)
                        let request: NSURLRequest = NSURLRequest(URL: avatarUrl!)
                        
                        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?)-> Void in
                            if(data != nil){
                                x = x+((i-4)*85)
                                blogimage = UIImageView(frame: CGRectMake(CGFloat(x), titleL_h+contentL_h+25+85, (WIDTH-40)/3, (WIDTH-40)/3))
                                let imgTmp = UIImage(data: data!)
                                //self.imageCache[imgUrl] = imgTmp
                                blogimage!.image = imgTmp
                                
                                cell.contentView.addSubview(blogimage!)
                            }
                        })
                        
                    }
                }
            }}
        if(daibaninfo.picCount>6&&daibaninfo.picCount<=9){
            image_h=260
            for i in 1...daibaninfo.picCount{
                if i <= 3 {
                    var x = 8
                    let pciInfo = daibaninfo.pic[i-1]
                    if pciInfo.picture_url != nil {
                        let imgUrl = picUrl+(pciInfo.picture_url)!
                        
                        //let image = self.imageCache[imgUrl] as UIImage?
                        let avatarUrl = NSURL(string: imgUrl)
                        let request: NSURLRequest = NSURLRequest(URL: avatarUrl!)
                        
                        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?)-> Void in
                            if(data != nil){
                                x = x+((i-1)*(intmax_t)((WIDTH-40)/3+5))
                                blogimage = UIImageView(frame: CGRectMake(CGFloat(x), titleL_h+contentL_h+25, (WIDTH-40)/3, (WIDTH-40)/3))
                                let imgTmp = UIImage(data: data!)
                                //self.imageCache[imgUrl] = imgTmp
                                blogimage!.image = imgTmp
                                
                                cell.contentView.addSubview(blogimage!)
                            }
                        })
                        
                    }}else if (i>3&&i<=6){
                    var x = 8
                    let pciInfo = daibaninfo.pic[i-1]
                    if pciInfo.picture_url != nil {
                        let imgUrl = picUrl+(pciInfo.picture_url)!
                        
                        //let image = self.imageCache[imgUrl] as UIImage?
                        let avatarUrl = NSURL(string: imgUrl)
                        let request: NSURLRequest = NSURLRequest(URL: avatarUrl!)
                        
                        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?)-> Void in
                            if(data != nil){
                                x = x+((i-4)*(intmax_t)((WIDTH-40)/3+5))
                                blogimage = UIImageView(frame: CGRectMake(CGFloat(x), 25+titleL_h+contentL_h+85, (WIDTH-40)/3, (WIDTH-40)/3))
                                let imgTmp = UIImage(data: data!)
                                //self.imageCache[imgUrl] = imgTmp
                                blogimage!.image = imgTmp
                                
                                cell.contentView.addSubview(blogimage!)
                            }
                        })
                        
                    } }else{
                    var x = 8
                    let pciInfo = daibaninfo.pic[i-1]
                    if pciInfo.picture_url != nil {
                        let imgUrl = picUrl+(pciInfo.picture_url)!
                        
                        //let image = self.imageCache[imgUrl] as UIImage?
                        let avatarUrl = NSURL(string: imgUrl)
                        let request: NSURLRequest = NSURLRequest(URL: avatarUrl!)
                        
                        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?)-> Void in
                            if(data != nil){
                                x = x+((i-7)*(intmax_t)((WIDTH-40)/3+5))
                                blogimage = UIImageView(frame: CGRectMake(CGFloat(x), 25+titleL_h+contentL_h+85+85, (WIDTH-40)/3, (WIDTH-40)/3))
                                let imgTmp = UIImage(data: data!)
                                //self.imageCache[imgUrl] = imgTmp
                                blogimage!.image = imgTmp
                                
                                cell.contentView.addSubview(blogimage!)
                            }
                        })
                        
                    }
                    
                }
                
            }}
        let senderIV = UIImageView(frame: CGRectMake(10, titleL_h+image_h+25+contentL_h, 20, 20))
        senderIV.image=UIImage(named: "ic_fasong")
        cell.contentView.addSubview(senderIV)
        let senderL = UILabel(frame: CGRectMake(35,titleL_h+image_h+25+contentL_h,120,20))
        if daibaninfo.name != nil {
            senderL.text=daibaninfo.name!
        }
        senderL.font=timefont
        senderL.textColor=timeColor
        cell.contentView.addSubview(senderL)
        let timeL = UILabel(frame: CGRectMake(frame.width-150,titleL_h+image_h+25+contentL_h,140,20))
        timeL.textAlignment = .Right
        timeL.textColor=timeColor
        timeL.font=timefont
        timeL.text=changeTime(daibaninfo.create_time!)
        cell.contentView.addSubview(timeL)

        tableView.rowHeight=titleL_h+contentL_h+40+image_h+20
        cell.selectionStyle = .None
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let daibaninfo = DaibanSource.parentsExhortList[indexPath.row]
        let vc = DaiBanInfoViewController()
        vc.info=daibaninfo
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    override func viewWillAppear(animated: Bool) {
        DaiBanTableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
