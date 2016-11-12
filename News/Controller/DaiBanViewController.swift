//
//  DaiBanViewController.swift
//  WXT_Teacher
//
//  Created by 李春波 on 16/3/23.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import PagingMenuController
class DaiBanViewController: UIViewController {
    
    let DaiBanTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        loadView()
            }

 func reloadview() {
        self.title = "待办事宜"
        let yishou = YiShouViewController()
        let yifa = YiFaViewController()
        
        yishou.title = "已获取的事项"
        yifa.title = "已发布的事项"
        
        
        let viewControllers = [yishou, yifa]
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
        let rightItem = UIBarButtonItem(title: "新增", style: UIBarButtonItemStyle.Done, target: self, action: #selector(addThing))
        self.navigationItem.rightBarButtonItem = rightItem
        

    }
    func addThing(){
        let vc = AddDaiBanViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    override func viewWillAppear(animated: Bool) {
        let user = NSUserDefaults.standardUserDefaults()
        user.removeObjectForKey("scheduleArr")
        reloadview()
        
        
    }
    override func viewWillDisappear(animated: Bool) {
        let user = NSUserDefaults.standardUserDefaults()
        user.removeObjectForKey("scheduleArr")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
