//
//  NoticeDetailViewController.swift
//  WXT_Parents
//
//  Created by 沈晓龙 on 16/8/1.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class NoticeDetailViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{

    let table = UITableView()
    var dateSource :ClassNoticeInfo?
    var rdateSource : ReciveAnnounceInfo?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = RGBA(242.0, g: 242.0, b: 242.0, a: 1)

        table.frame = CGRectMake(0, 0, WIDTH, HEIGHT)
        
        table.separatorStyle = .None
        
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = RGBA(242.0, g: 242.0, b: 242.0, a: 1)
        
        self.view.addSubview(table)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier:String(indexPath.row))
        cell.selectionStyle = .None
        tableView.separatorStyle = .None
        
        if self.dateSource == nil && self.rdateSource != nil {
            let model = self.rdateSource
            let img = UIImageView()
            img.frame = CGRectMake(10, 15, 40, 40)
            let pict = model?.avatar
            let imgUrl = pictureUrl + pict!
            let photourl = NSURL(string: imgUrl)
            
            img.yy_setImageWithURL(photourl, placeholder: UIImage(named: "4"))
            cell.contentView.addSubview(img)
            
            let nameLab = UILabel()
            nameLab.frame = CGRectMake(60, 10, 100, 20)
            nameLab.text = model?.username
            cell.contentView.addSubview(nameLab)
            
            let timeLab = UILabel()
            timeLab.frame = CGRectMake(160, 10, WIDTH - 170, 20)
            timeLab.font = UIFont.systemFontOfSize(16)
            timeLab.textColor = UIColor.lightGrayColor()
            let dateformate = NSDateFormatter()
            dateformate.dateFormat = "yyyy-MM-dd HH:mm"
            let date = NSDate(timeIntervalSince1970: NSTimeInterval(model!.create_time!)!)
            let st:String = dateformate.stringFromDate(date)
            timeLab.text = st
            timeLab.textAlignment = NSTextAlignment.Right
            cell.contentView.addSubview(timeLab)
            
            
            
            
            
            //  活动标题
            let titleLbl = UILabel()
            titleLbl.frame = CGRectMake(10, 80, WIDTH - 20, 30)
            titleLbl.textAlignment = NSTextAlignment.Center
            titleLbl.text = model!.title
            cell.contentView.addSubview(titleLbl)
            //  活动内容
            let contentLbl = UILabel()
            contentLbl.frame = CGRectMake(10, 120, WIDTH - 20, 60)
            contentLbl.font = UIFont.systemFontOfSize(16)
            contentLbl.textColor = UIColor.lightGrayColor()
            contentLbl.text = model!.content
            contentLbl.numberOfLines = 0
            contentLbl.sizeToFit()
            contentLbl.textColor = UIColor.lightGrayColor()
            cell.contentView.addSubview(contentLbl)
            
            //        自适应行高
            let options : NSStringDrawingOptions = NSStringDrawingOptions.UsesLineFragmentOrigin
            let screenBounds:CGRect = UIScreen.mainScreen().bounds
            let boundingRect = String(contentLbl.text).boundingRectWithSize(CGSizeMake(screenBounds.width, 0), options: options, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(17)], context: nil)
            let height = boundingRect.size.height + 120
            //  活动图片
            let pic = model!.pic
            //  图片
            var image_h = CGFloat()
            var button:UIButton?
            
            
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
                                    cell.contentView.addSubview(button!)
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
                                    cell.contentView.addSubview(button!)
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
                                    cell.contentView.addSubview(button!)
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
                                    cell.contentView.addSubview(button!)
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
                                    cell.contentView.addSubview(button!)
                                }
                            })
                            
                        } }else{
                        var x = 12
                        let pciInfo = pic[i-1]
                        if pciInfo.pictureurl != "" {
                            let imgUrl = pictureUrl + (pciInfo.pictureurl)!
                            
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
                                    cell.contentView.addSubview(button!)
                                }
                            })
                            
                        }
                        
                    }
                    
                }}
            
            
            let line = UILabel()
            line.frame = CGRectMake(1, height + image_h + 10, WIDTH - 2, 0.5)
            line.backgroundColor = UIColor.lightGrayColor()
            cell.addSubview(line)
            
            let all = UILabel()
            all.frame = CGRectMake(10, height + image_h + 20, 60, 20)
            all.text = "总发 \(model!.reciver_list.count)"
            all.textColor = UIColor.orangeColor()
            all.font = UIFont.systemFontOfSize(15)
            cell.contentView.addSubview(all)
            
            let already = UILabel()
            already.frame = CGRectMake(80, height + image_h + 20, 80, 20)
            var a = 0
            for i in 0..<model!.reciver_list.count {
                let strr = model!.reciver_list[i].create_time
                if strr == "0" {
                    a+=1
                }
            }
            already.text = "已阅读 \(model!.reciver_list.count - a)"
            already.textColor = UIColor.orangeColor()
            already.font = UIFont.systemFontOfSize(15)
            cell.contentView.addSubview(already)
            
            let wei = UILabel()
            wei.frame = CGRectMake(170, height + image_h + 20, 60, 20)
            wei.text = "未读 \(a)"
            wei.textColor = UIColor.orangeColor()
            wei.font = UIFont.systemFontOfSize(15)
            cell.contentView.addSubview(wei)
            
            //        let view = UIView()
            //        view.frame = CGRectMake(0, height + image_h + 40, WIDTH, 20)
            //        view.backgroundColor = RGBA(242.0, g: 242.0, b: 242.0, a: 1)
            //        cell.addSubview(view)
            
            table.rowHeight = height + image_h + 50
        }else{
            let model = self.dateSource
            let img = UIImageView()
            img.frame = CGRectMake(10, 15, 40, 40)
            let pict = model?.avatar
            let imgUrl = pictureUrl + pict!
            let photourl = NSURL(string: imgUrl)
            
            img.yy_setImageWithURL(photourl, placeholder: UIImage(named: "4"))
            cell.contentView.addSubview(img)
            
            let nameLab = UILabel()
            nameLab.frame = CGRectMake(60, 10, 100, 20)
            nameLab.text = model?.username
            cell.contentView.addSubview(nameLab)
            
            let timeLab = UILabel()
            timeLab.frame = CGRectMake(160, 10, WIDTH - 170, 20)
            timeLab.font = UIFont.systemFontOfSize(16)
            timeLab.textColor = UIColor.lightGrayColor()
            let dateformate = NSDateFormatter()
            dateformate.dateFormat = "yyyy-MM-dd HH:mm"
            let date = NSDate(timeIntervalSince1970: NSTimeInterval(model!.create_time!)!)
            let st:String = dateformate.stringFromDate(date)
            timeLab.text = st
            timeLab.textAlignment = NSTextAlignment.Right
            cell.contentView.addSubview(timeLab)
            
            
            
            
            
            //  活动标题
            let titleLbl = UILabel()
            titleLbl.frame = CGRectMake(10, 80, WIDTH - 20, 30)
            titleLbl.textAlignment = NSTextAlignment.Center
            titleLbl.text = model!.title
            cell.contentView.addSubview(titleLbl)
            //  活动内容
            let contentLbl = UILabel()
            contentLbl.frame = CGRectMake(10, 120, WIDTH - 20, 60)
            contentLbl.font = UIFont.systemFontOfSize(16)
            contentLbl.textColor = UIColor.lightGrayColor()
            contentLbl.text = model!.content
            contentLbl.numberOfLines = 0
            contentLbl.sizeToFit()
            contentLbl.textColor = UIColor.lightGrayColor()
            cell.contentView.addSubview(contentLbl)
            
            //        自适应行高
            let options : NSStringDrawingOptions = NSStringDrawingOptions.UsesLineFragmentOrigin
            let screenBounds:CGRect = UIScreen.mainScreen().bounds
            let boundingRect = String(contentLbl.text).boundingRectWithSize(CGSizeMake(screenBounds.width, 0), options: options, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(17)], context: nil)
            let height = boundingRect.size.height + 120
            //  活动图片
            let pic = model!.pic
            //  图片
            var image_h = CGFloat()
            var button:UIButton?
            
            
            //判断图片张数显示
            if pic.count == 1 {
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
                    let imgUrl = pictureUrl+(pciInfo.pictureurl)
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
                                    button?.addTarget(self, action: #selector(self.clickBtn(_:)), forControlEvents: .TouchUpInside)
                                    cell.contentView.addSubview(button!)
                                }
                            })
                            
                        }
                        
                    }
                    
                }}
            
            
            let line = UILabel()
            line.frame = CGRectMake(1, height + image_h + 10, WIDTH - 2, 0.5)
            line.backgroundColor = UIColor.lightGrayColor()
            cell.addSubview(line)
            
            let all = UILabel()
            all.frame = CGRectMake(10, height + image_h + 15, 60, 20)
            all.text = "总发\(model!.receive_list.count)"
            all.textColor = UIColor.orangeColor()
            all.font = UIFont.systemFontOfSize(13)
            cell.contentView.addSubview(all)
            
            let already = UILabel()
            already.frame = CGRectMake(55, height + image_h + 15, 60, 20)
            let array = NSMutableArray()
            for i in 0..<model!.receive_list.count {
                let strr = model!.receive_list[i].receivertype
                if strr == "0" {
                    array.addObject(strr)
                }
            }
            already.text = "已阅读\(model!.receive_list.count - array.count)"
            already.textColor = UIColor.orangeColor()
            already.font = UIFont.systemFontOfSize(13)
            cell.contentView.addSubview(already)
            
            let wei = UILabel()
            wei.frame = CGRectMake(110, height + image_h + 15, 60, 20)
            wei.text = "未读\(array.count)"
            wei.textColor = UIColor.orangeColor()
            wei.font = UIFont.systemFontOfSize(13)
            cell.contentView.addSubview(wei)
            
            //        let view = UIView()
            //        view.frame = CGRectMake(0, height + image_h + 40, WIDTH, 20)
            //        view.backgroundColor = RGBA(242.0, g: 242.0, b: 242.0, a: 1)
            //        cell.addSubview(view)
            
            table.rowHeight = height + image_h + 50
        
        
        }
        
        
        return cell
    }
    
    func clickBtn(sender:UIButton) {
//        let vc = NoticePicViewController()
//        let model = self.dateSource
//        vc.arrayInfo = model!.pic
//        vc.nu = model!.pic.count
//        self.navigationController?.pushViewController(vc, animated: true)
        
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
