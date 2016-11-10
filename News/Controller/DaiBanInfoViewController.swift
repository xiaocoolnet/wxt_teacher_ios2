//
//  DaiBanInfoViewController.swift
//  WXT_Teacher
//
//  Created by xiaocool on 16/8/31.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class DaiBanInfoViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    var tableview = UITableView()
    var info = DaibanInfo()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor=UIColor.whiteColor()
        self.title="待办事项"
        tableview.frame=CGRectMake(0, 0, frame.width, frame.height)
        tableview.delegate=self
        tableview.dataSource=self
        self.view.addSubview(tableview)
        let view = UIView(frame: CGRectMake(0,0,frame.width,40))
        tableview.tableFooterView=view
        let button = UIButton(frame: CGRectMake(30,0,frame.width-60,40))
        view.addSubview(button)
        button.backgroundColor=greenColor
        button.layer.cornerRadius=5
        button.setTitle("办理", forState: .Normal)
        button.addTarget(self, action: #selector(banli), forControlEvents: .TouchUpInside)
        if info.status=="1" {
            button.userInteractionEnabled=false
            button.setTitle("已办结", forState: .Normal)
            button.backgroundColor=UIColor.lightGrayColor()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 1+info.reciverlist.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: .Default, reuseIdentifier: String(indexPath.row))
        if indexPath.row==0 {
        
        let icon = UIImageView(frame: CGRectMake(10, 5, 50, 50))
        icon.image=UIImage(named: "1")
        icon.layer.masksToBounds=true
        icon.layer.cornerRadius=25
        cell.contentView.addSubview(icon)
        let senderL = UILabel(frame: CGRectMake(70,10,100,20))
        if info.name != nil {
            senderL.text=info.name!
        }
        senderL.font=UIFont.systemFontOfSize(15)
        cell.contentView.addSubview(senderL)
        let timeL = UILabel(frame: CGRectMake(frame.width-140,10,130,20))
        timeL.textAlignment = .Right
        timeL.textColor=timeColor
        timeL.font=UIFont.systemFontOfSize(15)
        timeL.text=changeTime(info.create_time!)
        cell.contentView.addSubview(timeL)

        let titleL = UILabel()
        titleL.frame=CGRectMake(10,75,frame.width-20,20)
        cell.contentView.addSubview(titleL)
        titleL.text=info.title!
        
        //计算lable的高度
        let titleL_h = calculateHeight(titleL.text!, size: 17, width: frame.width-20)
        titleL.numberOfLines=0
        titleL.frame.size.height=titleL_h
        let contentL = UILabel()
        contentL.frame=CGRectMake(10,titleL_h+85,frame.width-20,20)
        cell.contentView.addSubview(contentL)
        contentL.textColor=UIColor.grayColor()
        contentL.text=info.content!
        contentL.font=UIFont.systemFontOfSize(15)
        //计算lable的高度
        let contentL_h = calculateHeight(contentL.text!, size: 15, width: frame.width-20)
        contentL.numberOfLines=0
        contentL.frame.size.height=contentL_h
        
        
        var blogimage:UIImageView?
        var image_h = CGFloat()
        
        //        判断图片张数显示
        if(info.picCount>0&&info.picCount<=3){
            for i in 1...info.picCount{
                var x = 8
                let pciInfo = info.pic[i-1]
                let imgUrl = pictureUrl+(pciInfo.picture_url)!
                
                //let image = self.imageCache[imgUrl] as UIImage?
                let avatarUrl = NSURL(string: imgUrl)
                let request: NSURLRequest = NSURLRequest(URL: avatarUrl!)
                
                NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?)-> Void in
                    if(data != nil){
                        x = x+((i-1)*85)
                        blogimage = UIImageView(frame: CGRectMake(CGFloat(x), titleL_h+contentL_h+25, 80, 80))
                        let imgTmp = UIImage(data: data!)
                        //self.imageCache[imgUrl] = imgTmp
                        blogimage!.image = imgTmp
                        cell.contentView.addSubview(blogimage!)
                        image_h=80
                    }
                })
                
            }
        }
        if(info.picCount>3&&info.picCount<=6){
            image_h=170
            for i in 1...info.picCount{
                if i <= 3 {
                    var x = 8
                    let pciInfo = info.pic[i-1]
                    if pciInfo.picture_url != nil {
                        
                        
                        let imgUrl = picUrl+(pciInfo.picture_url)!
                        
                        //let image = self.imageCache[imgUrl] as UIImage?
                        let avatarUrl = NSURL(string: imgUrl)
                        let request: NSURLRequest = NSURLRequest(URL: avatarUrl!)
                        
                        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?)-> Void in
                            if(data != nil){
                                x = x+((i-1)*85)
                                blogimage = UIImageView(frame: CGRectMake(CGFloat(x), titleL_h+contentL_h+25, 80, 80))
                                let imgTmp = UIImage(data: data!)
                                //self.imageCache[imgUrl] = imgTmp
                                blogimage!.image = imgTmp
                                
                                cell.contentView.addSubview(blogimage!)
                            }
                        })
                    }}else{
                    var x = 8
                    let pciInfo = info.pic[i-1]
                    if pciInfo.picture_url != nil {
                        let imgUrl = picUrl+(pciInfo.picture_url)!
                        
                        //let image = self.imageCache[imgUrl] as UIImage?
                        let avatarUrl = NSURL(string: imgUrl)
                        let request: NSURLRequest = NSURLRequest(URL: avatarUrl!)
                        
                        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?)-> Void in
                            if(data != nil){
                                x = x+((i-4)*85)
                                blogimage = UIImageView(frame: CGRectMake(CGFloat(x), titleL_h+contentL_h+25+85, 80, 80))
                                let imgTmp = UIImage(data: data!)
                                //self.imageCache[imgUrl] = imgTmp
                                blogimage!.image = imgTmp
                                
                                cell.contentView.addSubview(blogimage!)
                            }
                        })
                        
                    }
                }
            }}
        if(info.picCount>6&&info.picCount<=9){
            image_h=260
            for i in 1...info.picCount{
                if i <= 3 {
                    var x = 8
                    let pciInfo = info.pic[i-1]
                    if pciInfo.picture_url != nil {
                        let imgUrl = picUrl+(pciInfo.picture_url)!
                        
                        //let image = self.imageCache[imgUrl] as UIImage?
                        let avatarUrl = NSURL(string: imgUrl)
                        let request: NSURLRequest = NSURLRequest(URL: avatarUrl!)
                        
                        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?)-> Void in
                            if(data != nil){
                                x = x+((i-1)*85)
                                blogimage = UIImageView(frame: CGRectMake(CGFloat(x), titleL_h+contentL_h+25, 80, 80))
                                let imgTmp = UIImage(data: data!)
                                //self.imageCache[imgUrl] = imgTmp
                                blogimage!.image = imgTmp
                                
                                cell.contentView.addSubview(blogimage!)
                            }
                        })
                        
                    }}else if (i>3&&i<=6){
                    var x = 8
                    let pciInfo = info.pic[i-1]
                    if pciInfo.picture_url != nil {
                        let imgUrl = picUrl+(pciInfo.picture_url)!
                        
                        //let image = self.imageCache[imgUrl] as UIImage?
                        let avatarUrl = NSURL(string: imgUrl)
                        let request: NSURLRequest = NSURLRequest(URL: avatarUrl!)
                        
                        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?)-> Void in
                            if(data != nil){
                                x = x+((i-4)*85)
                                blogimage = UIImageView(frame: CGRectMake(CGFloat(x), 25+titleL_h+contentL_h+85, 80, 80))
                                let imgTmp = UIImage(data: data!)
                                //self.imageCache[imgUrl] = imgTmp
                                blogimage!.image = imgTmp
                                
                                cell.contentView.addSubview(blogimage!)
                            }
                        })
                        
                    } }else{
                    var x = 8
                    let pciInfo = info.pic[i-1]
                    if pciInfo.picture_url != nil {
                        let imgUrl = picUrl+(pciInfo.picture_url)!
                        
                        //let image = self.imageCache[imgUrl] as UIImage?
                        let avatarUrl = NSURL(string: imgUrl)
                        let request: NSURLRequest = NSURLRequest(URL: avatarUrl!)
                        
                        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?)-> Void in
                            if(data != nil){
                                x = x+((i-7)*85)
                                blogimage = UIImageView(frame: CGRectMake(CGFloat(x), 25+titleL_h+contentL_h+85+85, 80, 80))
                                let imgTmp = UIImage(data: data!)
                                //self.imageCache[imgUrl] = imgTmp
                                blogimage!.image = imgTmp
                                
                                cell.contentView.addSubview(blogimage!)
                            }
                        })
                        
                    }
                    
                }
                
            }}
        
        tableView.rowHeight=titleL_h+contentL_h+40+image_h+70
        }else{
            let nameL = UILabel(frame: CGRectMake(5,5,110,20))
            nameL.text="上一步经办人："
            nameL.font=UIFont.systemFontOfSize(15)
            cell.contentView.addSubview(nameL)
            let senderL = UILabel(frame: CGRectMake(120,5,100,20))
            if info.reciverlist[indexPath.row-1].name != nil {
                senderL.text=info.reciverlist[indexPath.row-1].name!
            }
            senderL.font=UIFont.systemFontOfSize(15)
            cell.contentView.addSubview(senderL)
//            let timeL = UILabel(frame: CGRectMake(frame.width-140,5,130,20))
//            timeL.textAlignment = .Right
//            timeL.textColor=timeColor
//            timeL.font=UIFont.systemFontOfSize(15)
//            timeL.text=changeTime(info.reciverlist[indexPath.row-1].comment_time!)
//            cell.contentView.addSubview(timeL)

            let ideaL = UILabel(frame: CGRectMake(5,30,100,20))
            ideaL.text="上一步意见："
            ideaL.font=UIFont.systemFontOfSize(15)
            cell.contentView.addSubview(ideaL)
            let contentL = UILabel(frame: CGRectMake(110,30,frame.width-115,20))
            contentL.text=info.reciverlist[indexPath.row-1].feedback!
            contentL.font=UIFont.systemFontOfSize(15)
            let contentL_h=calculateHeight(contentL.text!, size: 15, width: frame.width-115)
            contentL.frame.size.height=contentL_h
            tableView.rowHeight=40+contentL_h
            
            
        }
        cell.selectionStyle = .None
        return cell
}
    func banli(){
        let vc = BanLiViewController()
        vc.info=self.info
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}