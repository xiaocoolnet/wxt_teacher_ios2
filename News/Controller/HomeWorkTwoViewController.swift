//
//  HomeWorkTwoViewController.swift
//  WXT_Teacher
//
//  Created by xiaocool on 16/6/30.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class HomeWorkTwoViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    var table = UITableView()
    var HWTitle = String()
    var HWContent = String()
    var HWPhoto = String()
    var HWUsername = String()
    var HWreadcount = Int()
    var HWallreader = Int()
    var HWcreate_time = String()
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title="我的作业"
        createTable()
    }
    //    创建表
    func createTable(){
        table.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64)
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .None
        table.backgroundColor = RGBA(242.0, g: 242.0, b: 242.0, a: 1)
        self.view.addSubview(table)
        
        //        注册cell
        table.registerNib(UINib.init(nibName: "HomeworkTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeworkCellID")
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 2
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        if indexPath.row==0 {
            let cell = MassageCell.cellWithTableView(tableView)
            
            cell.selectionStyle = .None
            
            cell.titleL.text=HWUsername
            cell.contentL.text="小一班"
            let dateformate = NSDateFormatter()
            dateformate.dateFormat = "yyyy-MM-dd HH:mm"
            //        时间
            let date = NSDate(timeIntervalSince1970: NSTimeInterval(HWcreate_time)!)
            let str:String = dateformate.stringFromDate(date)

            cell.timeL.text=str
            let photo = ""
            let url = imageUrl+photo
            let photourl = NSURL(string: url)
            cell.iconIV.yy_setImageWithURL(photourl, placeholder: UIImage(named: "无网络的背景"))
            table.rowHeight=80
            
            return cell

        }else{
        let cell = tableView.dequeueReusableCellWithIdentifier("HomeworkCellID", forIndexPath: indexPath)
            as! HomeworkTableViewCell
            cell.backgroundColor=UIColor.whiteColor()
        cell.selectionStyle = .None
        
        
        
        cell.titleLbl.text = HWTitle
        cell.contentLbl.text = HWContent
        
        let imgUrl = imageUrl + HWPhoto
        let photourl = NSURL(string: imgUrl)
        cell.bigImageView.yy_setImageWithURL(photourl, placeholder: UIImage(named: "园所公告背景.png"))
        cell.senderLbl.text = HWUsername
        cell.senderLbl.hidden=true
        cell.senderIV.hidden=true
        //        已读
        cell.readBtn.setTitle("已读\(String(HWreadcount)) 未读\(String(HWallreader-HWreadcount))", forState: .Normal)
        cell.readBtn.addTarget(self, action: #selector(HomeworkViewController.readBtn(_:)), forControlEvents: .TouchUpInside)
        cell.readBtn.tag = indexPath.row
        
        cell.dianzanBtn.setBackgroundImage(UIImage(named: "已点赞.png"), forState:.Selected)
        cell.dianzanBtn.tag = indexPath.row
        
        cell.pinglunBtn.tag = indexPath.row
        
        cell.timeLbl.hidden=true
        
        //        自适应行高
        let options : NSStringDrawingOptions = NSStringDrawingOptions.UsesLineFragmentOrigin
        let screenBounds:CGRect = UIScreen.mainScreen().bounds
        let boundingRect = String(cell.contentLbl.text).boundingRectWithSize(CGSizeMake(screenBounds.width, 0), options: options, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(17)], context: nil)
        
        table.rowHeight = boundingRect.size.height + 391
        return cell
        }
        
        }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
