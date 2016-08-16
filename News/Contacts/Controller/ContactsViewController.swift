//
//  ContactsViewController.swift
//  WXT_Teachers
//
//  Created by 李春波 on 16/2/23.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import PagingMenuController

class ContactsViewController: UIViewController {

    override func viewDidLoad(){
        super.viewDidLoad()
        self.title = "通讯录"
        let rightItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: #selector(ContactsViewController.RightBtn))
        let leftItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Search, target: self, action: #selector(ContactsViewController.LeftBtn))
        self.navigationItem.rightBarButtonItem = rightItem
        self.navigationItem.leftBarButtonItem = leftItem
        let jiaZhangView = JiaZhangViewController()
        let yuanDingView = JiaZhangViewController()
        let qunLiaoView = JiaZhangViewController()
        jiaZhangView.title = "家长"
        yuanDingView.title = "园丁"
        qunLiaoView.title = "群聊"
        let viewControllers = [jiaZhangView, yuanDingView,qunLiaoView]
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
        // Do any additional setup after loading the view.
    }
    
    func LeftBtn(){
        print("")
    }
    
    func RightBtn(){
        print("")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
