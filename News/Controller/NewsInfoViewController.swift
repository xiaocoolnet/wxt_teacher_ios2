//
//  NewsInfoViewController.swift
//  WXT_Teachers
//
//  Created by 李春波 on 16/2/23.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class NewsInfoViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    let newsInfoTableView = UITableView()
    var newsInfo = NewsInfo()
         
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "消息详情"
        newsInfoTableView.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height)
        self.view.backgroundColor = UIColor.whiteColor()
        newsInfoTableView.delegate = self
        newsInfoTableView.dataSource = self
        newsInfoTableView.scrollEnabled = false
        self.automaticallyAdjustsScrollViewInsets = false
        let rightItem = UIBarButtonItem(title: "回复", style: UIBarButtonItemStyle.Done, target: self, action: #selector(NewsInfoViewController.ReviceMessages))
        self.navigationItem.rightBarButtonItem = rightItem
        self.view.addSubview(newsInfoTableView)
    }

    func ReviceMessages(){
        let reviceView = ReviceMessagesViewController()
        reviceView.newsInfo = self.newsInfo
        self.navigationController?.pushViewController(reviceView, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.section == 0){
            return 90
        }
        return self.view.bounds.height - 90 - 64
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let avatorImage = UIImageView()
        let nameLabel = UILabel()
        let sendLabel = UILabel()
        let sendTimeLabel = UILabel()
        let timeLabel = UILabel()
        let contentLabel = UILabel()
        let content = UILabel()
        if(indexPath.section == 0){
            let cell = UITableViewCell(style: .Default, reuseIdentifier: "UserCell")
            cell.selectionStyle = .None
            let dateformate = NSDateFormatter()
            dateformate.dateFormat = "YY-MM-dd"
            var datedouble: Double?
            var dateint: Int?
            var create_time:NSDate?
            dateint = Int(newsInfo.message_time!)
            datedouble = Double(dateint!)
            create_time = NSDate(timeIntervalSince1970: datedouble!)
            avatorImage.frame = CGRectMake(13, 8, 74, 74)
            avatorImage.layer.cornerRadius = 37
            avatorImage.layer.masksToBounds = true
            avatorImage.image = UIImage(named: "Logo")
            sendLabel.frame = CGRectMake(90, 15, 60, 20)
            sendLabel.font = UIFont.systemFontOfSize(15)
            sendLabel.textColor = UIColor.grayColor()
            sendLabel.text = "发送人："
            nameLabel.frame = CGRectMake(140, 15, 150, 20)
            nameLabel.font = UIFont.systemFontOfSize(17)
            nameLabel.textColor = UIColor.blackColor()
            nameLabel.text = newsInfo.sendName!
            sendTimeLabel.frame = CGRectMake(0, 0, 70, 15)
            sendTimeLabel.frame.origin.x = self.view.bounds.width - 150
            sendTimeLabel.frame.origin.y = 70
            sendTimeLabel.font = UIFont.systemFontOfSize(14)
            sendTimeLabel.text = "发送时间:"
            sendTimeLabel.textColor = UIColor.grayColor()
            timeLabel.frame = CGRectMake(0, 0, 75, 15)
            timeLabel.frame.origin.x = self.view.bounds.width - 75
            timeLabel.frame.origin.y = 70
            timeLabel.font = UIFont.systemFontOfSize(14)
            timeLabel.textColor = UIColor.grayColor()
            timeLabel.text = dateformate.stringFromDate(create_time!)
            cell.contentView.addSubview(avatorImage)
            cell.contentView.addSubview(sendLabel)
            cell.contentView.addSubview(nameLabel)
            cell.contentView.addSubview(sendTimeLabel)
            cell.contentView.addSubview(timeLabel)
            return cell
        }
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "InfoCell")
        cell.selectionStyle = .None
        let options : NSStringDrawingOptions = NSStringDrawingOptions.UsesLineFragmentOrigin
        let string:NSString = newsInfo.message_content!
        let screenBounds:CGRect = UIScreen.mainScreen().bounds
        let boundingRect = string.boundingRectWithSize(CGSizeMake(screenBounds.width - 30, 0), options: options, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(17)], context: nil)
        contentLabel.frame = CGRectMake(15, 30, 100, 25)
        contentLabel.font = UIFont.systemFontOfSize(20)
        contentLabel.textColor = UIColor.grayColor()
        contentLabel.text = "消息详情:"
        content.frame = CGRectMake(15, 60, self.view.bounds.width - 30, boundingRect.height)
        content.font = UIFont.systemFontOfSize(16)
        content.textColor = UIColor.blackColor()
        content.text = newsInfo.message_content!
        content.numberOfLines = 0
        cell.contentView.addSubview(contentLabel)
        cell.contentView.addSubview(content)
        return cell
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
