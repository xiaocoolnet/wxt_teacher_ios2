//
//  YuanDingViewController.swift
//  WXT_Teachers
//
//  Created by 李春波 on 16/2/23.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class YuanDingViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var tableView=UITableView()

    var adHeaders:[String] = ["a","b","c","d","e","f","g","h","i","j","k"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.frame=CGRectMake(0, 0, frame.width, frame.height)
        tableView.delegate=self
        tableView.dataSource=self
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(tableView)
    }
    //实现索引数据源代理方法
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return adHeaders
    }
    
    //点击索引，移动TableView的组位置
    func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String,
                   atIndex index: Int) -> Int {
        var tpIndex:Int = 0
        //遍历索引值
        for character in adHeaders{
            //判断索引值和组名称相等，返回组坐标
            if character == title{
                return tpIndex
            }
            tpIndex += 1
        }
        return 0
    }
    
    //设置分区数
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return adHeaders.count;
    }
    
    //返回表格行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
   
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: .Default, reuseIdentifier: String(indexPath.row))
        return cell
    }
}
