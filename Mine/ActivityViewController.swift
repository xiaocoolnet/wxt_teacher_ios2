//
//  ActivityViewController.swift
//  WXT_Parents
//
//  Created by 沈晓龙 on 16/8/3.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    let myTableView = UITableView()
    
    override func viewWillAppear(animated: Bool) {
        
        self.tabBarController?.tabBar.hidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "活动"
        
        myTableView.frame = CGRectMake(0, 0, WIDTH, HEIGHT)
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.backgroundColor = RGBA(242.0, g: 242.0, b: 242.0, a: 1)
        myTableView.separatorStyle = .None
        self.view.addSubview(myTableView)
        myTableView.registerClass(ActivityTableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 225
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)as!ActivityTableViewCell
        cell.selectionStyle = .None
        
        return cell

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
