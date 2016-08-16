//
//  BlogCommentTableViewController.swift
//  WXT_Parents
//
//  Created by 李春波 on 16/1/28.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class BlogCommentViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    var pingLunSource = CommentList()
    var mid:String?
    let commentTableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationItem.backBarButtonItem = UIBarButtonItem(title: "hah", style: .Plain, target: nil, action: nil)
        self.title = "评论列表"
        if(pingLunSource.count == 0){
            let tiShiLable = UILabel()
            self.view.backgroundColor = UIColor.grayColor()
            tiShiLable.frame = CGRectMake(0, 0, 150, 40)
            tiShiLable.center = self.view.center
            tiShiLable.text = "还没有评论～"
            tiShiLable.textColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1)
            tiShiLable.textAlignment = .Center
            self.view.addSubview(tiShiLable)
        }
        else{
            commentTableView.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height - 64)
            commentTableView.delegate = self
            commentTableView.dataSource = self
            let emptyView = UIView()
            emptyView.frame = CGRectZero
            commentTableView.tableFooterView = emptyView
            self.automaticallyAdjustsScrollViewInsets = false
            self.view.addSubview(commentTableView)
        }
        let rightItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(BlogCommentViewController.NewComment))
        self.navigationItem.rightBarButtonItem = rightItem
        self.view.backgroundColor = UIColor.whiteColor()
        self.tabBarController?.tabBar.hidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func NewComment(){
        let newComment = NewCommentViewController()
        newComment.mid = self.mid!
        self.navigationController?.pushViewController(newComment, animated: true)
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(section == 0){
            return pingLunSource.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let options : NSStringDrawingOptions = NSStringDrawingOptions.UsesLineFragmentOrigin
        let pingLunInfo = pingLunSource.PingLunlist[indexPath.row]
        let string:NSString = pingLunInfo.content ?? ""
        let screenBounds:CGRect = UIScreen.mainScreen().bounds
        let boundingRect = string.boundingRectWithSize(CGSizeMake(screenBounds.width, 0), options: options, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(17)], context: nil)
        if(boundingRect.height < 50){
            return 50 + 10
        }
        
        return boundingRect.height + 20
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let options : NSStringDrawingOptions = NSStringDrawingOptions.UsesLineFragmentOrigin
        let pingLunInfo = pingLunSource.PingLunlist[indexPath.row]
        let string:NSString = pingLunInfo.content ?? ""
        let screenBounds:CGRect = UIScreen.mainScreen().bounds
        let boundingRect = string.boundingRectWithSize(CGSizeMake(screenBounds.width - 70, 0), options: options, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(17)], context: nil)
        let contentLabel = UILabel()
        contentLabel.frame = CGRectMake(70, 2, self.view.bounds.width - 70, boundingRect.height)
        contentLabel.numberOfLines = 0
        contentLabel.font = UIFont.systemFontOfSize(15)
        contentLabel.textColor = UIColor.grayColor()
        let cell = UITableViewCell(style: .Value1, reuseIdentifier: "testCell")
        cell.selectionStyle = .None
        if(indexPath.section == 0){
            let cell = UITableViewCell(style: .Value1, reuseIdentifier: "testCell")
            cell.selectionStyle = .None
            let pingLunInfo = pingLunSource.PingLunlist[indexPath.row]
            cell.textLabel?.text = pingLunInfo.userName!
            contentLabel.text = pingLunInfo.content ?? ""
            cell.contentView.addSubview(contentLabel)
            return cell
        }
        return cell
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    

}
