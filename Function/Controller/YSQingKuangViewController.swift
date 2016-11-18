//
//  YSQingKuangViewController.swift
//  WXT_Teacher
//
//  Created by apple on 16/4/7.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

class YSQingKuangViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{

    let tableView = UITableView()
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=bkColor
        self.title="院所情况"
        // 初始化视图
        initView()

        
    }
    
    
    func initView() -> Void {
        tableView.frame = CGRectMake(0, 0, WIDTH, HEIGHT-64-40)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .None
        self.view.addSubview(tableView)
    }
    
    
    
    
        
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: delegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40
    }

    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("qingkaung")
     
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "qingkaung")
            cell?.accessoryType = .DisclosureIndicator
            cell?.selectionStyle = .None
        }
        
        if indexPath.row == 0 {
            cell?.textLabel?.text = "班级相册"
        }
               
        
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == 0 {
            self.navigationController?.pushViewController(QKClassAblumTableViewController(), animated: true)
        }
    }
    
    
    
   
    //MARK:
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden=true
        
    }
    override func viewWillDisappear(animated: Bool) {
        self.tabBarController?.tabBar.hidden=false
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
