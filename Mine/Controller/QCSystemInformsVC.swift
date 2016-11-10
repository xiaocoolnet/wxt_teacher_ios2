//
//  QCSystemInformsVC.swift
//  WXT_Parents
//
//  Created by 沈晓龙 on 16/7/14.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

class QCSystemInformsVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var tableView = UITableView()
    var dataSource = NewssList()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
        createTableView()
        
        GetDate()
    }
    func initUI(){
        self.title = "系统通知"
        self.tabBarController?.tabBar.hidden = true
    }
    func createTableView(){
        
        tableView.frame = self.view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.objectList.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier:String(indexPath.row))
        cell.selectionStyle = .None
        tableView.separatorStyle = .None
        
        let model = self.dataSource.objectList[indexPath.row]
        
        let img = UIImageView()
        img.frame = CGRectMake(10, 10, 60, 60)
        let pic = model.thumb
        let imgUrl = microblogImageUrl + pic!
        let photourl = NSURL(string: imgUrl)
        img.yy_setImageWithURL(photourl, placeholder: UIImage(named: "Logo"))
        img.layer.cornerRadius = 30
        img.clipsToBounds = true
        cell.contentView.addSubview(img)
        
        let title = UILabel()
        title.frame = CGRectMake(80, 10, 100, 30)
        title.font = UIFont.systemFontOfSize(19)
        title.text = model.term_name
        cell.contentView.addSubview(title)
        
        let time = UILabel()
        time.frame = CGRectMake(WIDTH - 190, 10, 180, 30)
        time.textColor = UIColor.lightGrayColor()
        time.text = model.post_date
        time.font = UIFont.systemFontOfSize(16)
        time.textAlignment = NSTextAlignment.Right
        cell.contentView.addSubview(time)
        
        let content = UILabel()
        content.frame = CGRectMake(80, 50, WIDTH - 85, 20)
        content.font = UIFont.systemFontOfSize(16)
        content.textColor = UIColor.lightGrayColor()
        content.text = model.post_excerpt
        cell.contentView.addSubview(content)
        
        let line = UILabel()
        line.frame = CGRectMake(5, 79, WIDTH - 5, 1)
        line.textColor = UIColor.lightGrayColor()
        cell.contentView.addSubview(line)
        
        
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("点击单元格")
        let detailVC = SystemDetailViewController()
        let model = self.dataSource.objectList[indexPath.row]
        detailVC.id = model.id
        detailVC.tit = model.post_title
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func GetDate(){
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=index&a=getSystemMessages"
        //       http://wxt.xiaocool.net/index.php?g=apps&m=index&a=getSystemMessages&term_id=3

        let param = [
            "term_id":"3"
        ]
        Alamofire.request(.GET, url, parameters: param).response { request, response, json, error in
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
                    hud.mode = MBProgressHUDMode.Text;
                    hud.margin = 10.0
                    hud.removeFromSuperViewOnHide = true
                    hud.hide(true, afterDelay: 1)
                }
                
                if(status.status == "success"){
                    self.dataSource = NewssList(status.data!)
                    self.tableView.reloadData()
                }
            }
            
        }

    }

}
