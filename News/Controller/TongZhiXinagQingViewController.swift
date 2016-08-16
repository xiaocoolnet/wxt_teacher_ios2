//
//  TongZhiXinagQingViewController.swift
//  WXT_Teacher
//
//  Created by 李春波 on 16/3/23.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
class TongZhiXinagQingViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    let newsInfoTableView = UITableView()
    var gonggaoTitle = String()
    var gonggaoContent = String()
    var gonggaoUsername = String()
    var gonggaoPhoto = String()
    var gonggaoTime = String()
    var gonggaoCreatetime = String()
    
    

    var activitySource = GongGaoModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "通知详情"
        newsInfoTableView.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height)
        self.view.backgroundColor = UIColor.whiteColor()
        newsInfoTableView.delegate = self
        newsInfoTableView.dataSource = self
        newsInfoTableView.scrollEnabled = false
        newsInfoTableView.registerNib((UINib(nibName: "HomeworkTableViewCell",bundle: nil)) ,forCellReuseIdentifier: "cell")
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(newsInfoTableView)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 1
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var cell = HomeworkTableViewCell()
        cell=tableView.dequeueReusableCellWithIdentifier("cell") as! HomeworkTableViewCell
        cell.selectionStyle = .None
        
        cell.titleLbl.text=gonggaoTitle
        cell.contentLbl.text=gonggaoContent
        cell.senderLbl.text=gonggaoUsername
        let imgUrl = imageUrl + gonggaoPhoto
        let photourl = NSURL(string: imgUrl)
        cell.bigImageView.yy_setImageWithURL(photourl, placeholder: UIImage(named: "无网络的背景"))
        let dateformate = NSDateFormatter()
        dateformate.dateFormat = "yyyy-MM-dd HH:mm"
        let date = NSDate(timeIntervalSince1970: NSTimeInterval(gonggaoCreatetime)!)
        let str:String = dateformate.stringFromDate(date)
        cell.timeLbl.text = str
        
        
      
        cell.dianzanBtn.setImage(UIImage(named: "已点赞.png"), forState:.Selected)
        cell.dianzanBtn.tag = indexPath.row
       
        cell.pinglunBtn.tag = indexPath.row
        
        
        
        let options : NSStringDrawingOptions = NSStringDrawingOptions.UsesLineFragmentOrigin
        let screenBounds:CGRect = UIScreen.mainScreen().bounds
        let boundingRect = String(cell.contentLbl.text).boundingRectWithSize(CGSizeMake(screenBounds.width, 0), options: options, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(17)], context: nil)
        newsInfoTableView.rowHeight = boundingRect.size.height + 331
        

        
        return cell
    }
}
