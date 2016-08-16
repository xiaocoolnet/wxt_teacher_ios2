//
//  AddressBookViewController.swift
//  WXT_Teacher
//
//  Created by xiaocool on 16/7/15.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import PagingMenuController
class AddressBookViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "通讯录"
        self.view.backgroundColor=UIColor.whiteColor()
        //搜索按钮
        let button1 = UIButton(frame:CGRectMake(0, 0, 18, 18))
        button1.setImage(UIImage(named: "ic_sousuo"), forState: .Normal)
        button1.addTarget(self,action:#selector(AddressBookViewController.tapped1),forControlEvents:.TouchUpInside)
        let barButton1 = UIBarButtonItem(customView: button1)
        
        //添加按钮
        let button2 = UIButton(frame:CGRectMake(0, 0, 18, 18))
        button2.setImage(UIImage(named: "ic_jia"), forState: .Normal)
        button2.addTarget(self,action:#selector(AddressBookViewController.tapped2),forControlEvents:.TouchUpInside)
        let barButton2 = UIBarButtonItem(customView: button2)
        
        //按钮间的空隙
        let gap = UIBarButtonItem(barButtonSystemItem: .FixedSpace, target: nil,
                                  action: nil)
        gap.width = 15;
        
        //用于消除右边边空隙，要不然按钮顶不到最边上
        let spacer = UIBarButtonItem(barButtonSystemItem: .FixedSpace, target: nil,
                                     action: nil)
        spacer.width = -10;
        
        //设置按钮（注意顺序）
        self.navigationItem.rightBarButtonItems = [spacer,barButton2,gap,barButton1]
        let jiaZhangView = JiaZhangViewController()
        let yuanDingView = YuanDingViewController()
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
    }
    
    func tapped1(){
        
    }
    func tapped2(){
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
