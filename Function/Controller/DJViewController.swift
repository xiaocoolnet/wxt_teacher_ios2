//
//  DJViewController.swift
//  WXT_Teacher
//
//  Created by xiaocool on 16/7/29.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import PagingMenuController
class DJViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor=UIColor.whiteColor()
        self.title="待接确认"
        let weiqueren = DaiJieViewController()
        let queren = YDaiJieViewController()
        
        
        
        
        
        weiqueren.title = "待处理"
        queren.title = "已完成"
        
        
        
        let viewControllers = [weiqueren, queren]
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
        let rightItem = UIBarButtonItem(title: "新增", style: UIBarButtonItemStyle.Done, target: self, action: #selector(addDaijie))
        self.navigationItem.rightBarButtonItem = rightItem
        

    }
    func addDaijie(){
        let vc = AddDaijieViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden=true
    }
    override func viewWillDisappear(animated: Bool) {
        self.tabBarController?.tabBar.hidden=false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  

}
