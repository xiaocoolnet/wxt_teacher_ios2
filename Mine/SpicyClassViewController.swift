//
//  SpicyClassViewController.swift
//  WXT_Parents
//
//  Created by 沈晓龙 on 16/8/3.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class SpicyClassViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let myTableView = UITableView()
    
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "麻辣学堂"
        
        self.createTableView()
    }
    
    func createTableView(){
        myTableView.frame = CGRectMake(0, 0, WIDTH, HEIGHT - 20)
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.backgroundColor = RGBA(242.0, g: 242.0, b: 242.0, a: 1)
        myTableView.separatorStyle = .None
        self.view.addSubview(myTableView)
        
         myTableView.registerClass(SpicyClassTableViewCell.self, forCellReuseIdentifier: "cell")
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 390
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)as!SpicyClassTableViewCell
        cell.selectionStyle = .None
        
        cell.backgroundColor = RGBA(242.0, g: 242.0, b: 242.0, a: 1)
        
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
