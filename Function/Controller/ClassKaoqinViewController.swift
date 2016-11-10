//
//  ClassKaoqinViewController.swift
//  WXT_Teacher
//
//  Created by qiang on 16/8/29.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import PagingMenuController
class ClassKaoqinViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "班级考勤"
        let shou = bbKaoQinViewController()
        let yifa = QianTuiViewController()
        
        shou.title = "签到"
        yifa.title = "签退"
        
        
        let viewControllers = [shou, yifa]
        let options = PagingMenuOptions()
        options.menuItemMargin = 5
        options.menuHeight = 40
        options.menuDisplayMode = .SegmentedControl
        options.selectedTextColor = UIColor(red: 54.0 / 255.0, green: 190.0 / 255.0, blue: 100.0 / 255.0, alpha: 1.0)
        let pagingMenuController = PagingMenuController(viewControllers: viewControllers, options: options)
        pagingMenuController.view.frame.origin.y += 0
        pagingMenuController.view.frame.size.height -= 0
        addChildViewController(pagingMenuController)
        view.addSubview(pagingMenuController.view)
        pagingMenuController.didMoveToParentViewController(self)
        let rightItem = UIBarButtonItem(title: "签到历史", style: UIBarButtonItemStyle.Done, target: self, action: #selector(addThing))
        self.navigationItem.rightBarButtonItem = rightItem
    }

    //签到历史
    func addThing(){
        self.navigationController?.pushViewController(KaoQinHistroyViewController(), animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = true
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.hidden = false
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
