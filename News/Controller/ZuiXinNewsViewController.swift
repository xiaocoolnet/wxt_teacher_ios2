//
//  ZuiXinNewsViewController.swift
//  WXT_Teacher
//
//  Created by 李春波 on 16/3/23.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class ZuiXinNewsViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    private var tableView=UITableView()
    let newsInfoTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "系统消息"
        self.view.backgroundColor=UIColor.whiteColor()
        tableView.frame=CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height)
        tableView.delegate=self
        tableView.dataSource=self
        tableView.rowHeight=80
        self.view.addSubview(tableView)
    }
//代理方法
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 5
    }
//代理方法
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = MassageCell.cellWithTableView(tableView)
        
        cell.selectionStyle = .None
        
        cell.titleL.text="微校通教师端"
        cell.contentL.text="这是微校通教师端这是微校通教师端这是微校通教师端"
        cell.timeL.text="06-28"
        let photo = ""
        let url = imageUrl+photo
        let photourl = NSURL(string: url)
        cell.iconIV.yy_setImageWithURL(photourl, placeholder: UIImage(named: "无网络的背景"))
        
        
        return cell

    }
//点击事件
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   }
