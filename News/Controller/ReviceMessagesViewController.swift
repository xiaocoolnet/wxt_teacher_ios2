//
//  ReviceMessagesViewController.swift
//  WXT_Teacher
//
//  Created by 李春波 on 16/3/8.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
import IQKeyboardManagerSwift

class ReviceMessagesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    let newsInfoTableView = UITableView()
    var newsInfo = NewsInfo()
    
    let contentTextView = BRPlaceholderTextView()

    override func viewDidLoad() {
        super.viewDidLoad()
        IQKeyboardManager.sharedManager().enable = false
        self.title = "回复\(newsInfo.sendName!)"
        newsInfoTableView.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height)
        self.view.backgroundColor = UIColor.whiteColor()
        newsInfoTableView.delegate = self
        newsInfoTableView.dataSource = self
        newsInfoTableView.scrollEnabled = false
        self.automaticallyAdjustsScrollViewInsets = false
        let rightItem = UIBarButtonItem(title: "发送", style: UIBarButtonItemStyle.Done, target: self, action: #selector(ReviceMessagesViewController.ReviceMessages))
        self.navigationItem.rightBarButtonItem = rightItem
        self.view.addSubview(newsInfoTableView)
        // Do any additional setup after loading the view.
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
    
    func ReviceMessages(){
        print("发送")
        
        let url = apiUrl+"SendMessage"
        let param = [
            "sendid":599,
            "receiveid":1,
            "content":contentTextView.text
        ]
        Alamofire.request(.POST, url, parameters: param as? [String : AnyObject]).response { request, response, json, error in
            if(error != nil){
            }
            else{
                print("request是")
                print(request!)
                print("====================")
                let status = MineModel(JSONDecoder(json!))
                print("状态是")
                print(status.status)
                if(status.status == "error"){
                    let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                    hud.mode = MBProgressHUDMode.Text;
                    hud.labelText = status.errorData
                    hud.margin = 10.0
                    hud.removeFromSuperViewOnHide = true
                    hud.hide(true, afterDelay: 1)
                }
                if(status.status == "success"){
                    print("Success+1")
                    self.navigationController?.popToRootViewControllerAnimated(true)
                }
            }
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let avatorImage = UIImageView()
        let reviceLabel = UILabel()
        let nameLabel = UILabel()
        if(indexPath.section == 0){
            let cell = UITableViewCell(style: .Default, reuseIdentifier: "UserCell")
            cell.selectionStyle = .None
            avatorImage.frame = CGRectMake(13, 8, 74, 74)
            avatorImage.layer.cornerRadius = 37
            avatorImage.layer.masksToBounds = true
            avatorImage.image = UIImage(named: "Logo")
            reviceLabel.frame = CGRectMake(90, 15, 60, 20)
            reviceLabel.font = UIFont.systemFontOfSize(15)
            reviceLabel.textColor = UIColor.grayColor()
            reviceLabel.text = "接收人:"
            nameLabel.frame = CGRectMake(140, 15, 150, 20)
            nameLabel.font = UIFont.systemFontOfSize(17)
            nameLabel.textColor = UIColor.blackColor()
            nameLabel.text = newsInfo.sendName!
            cell.contentView.addSubview(avatorImage)
            cell.contentView.addSubview(reviceLabel)
            cell.contentView.addSubview(nameLabel)
            return cell
        }
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "UserCell")
        cell.selectionStyle = .None
        contentTextView.frame = CGRectMake(8, 5, self.view.bounds.width - 16, 200)
        contentTextView.font = UIFont.systemFontOfSize(15)
        contentTextView.placeholder = "请输入内容～不能超过200字哦"
        contentTextView.addMaxTextLengthWithMaxLength(200) { (contentTextView) -> Void in
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.mode = MBProgressHUDMode.Text
            hud.labelText = "超过200字啦"
            hud.margin = 10.0
            hud.removeFromSuperViewOnHide = true
            hud.hide(true, afterDelay: 3)
        }
        cell.contentView.addSubview(contentTextView)
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
