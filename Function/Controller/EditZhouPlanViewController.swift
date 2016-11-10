//
//  EditZhouPlanViewController.swift
//  WXT_Teacher
//
//  Created by 李春波 on 16/3/31.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import MBProgressHUD

class EditZhouPlanViewController: UIViewController {

    var plan = planInfo()
    let contentTextView = UITextView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = plan.title
        self.view.backgroundColor = UIColor.whiteColor()
        let rightItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(EditZhouPlanViewController.EditPlan))
        self.navigationItem.rightBarButtonItem = rightItem
        self.contentTextView.font = UIFont.systemFontOfSize(17)

    
        self.contentTextView.textAlignment = NSTextAlignment.Left
    
        self.contentTextView.text = "要点\(plan.workpoint!)\n星期一:\(plan.monday!)\n星期二:\(plan.tuesday!)\n星期三:\(plan.wednesday!)\n星期四:\(plan.thursday!)\n星期五:\(plan.friday!)\n星期六:\(plan.saturday!)\n星期日:\(plan.sunday!)"
        
    
         self.contentTextView.editable = false
         self.contentTextView.frame = CGRectMake(0, 0, WIDTH, HEIGHT)
        self.view.addSubview(self.contentTextView)
    }
    
    func EditPlan(sender:AnyObject){
//        let menuArray = [
//            KxMenuItem.init("新增", image: UIImage(named: "add2-1"), target: self, action: #selector(EditZhouPlanViewController.NewPlan)),
//            KxMenuItem.init("编辑", image: UIImage(named: "edit"), target: self, action: #selector(EditZhouPlanViewController.Edit))
//        ]
//        KxMenu.setTitleFont(UIFont(name: "HelveticaNeue", size: 15))
//        //配置二：拓展配置
//        let options = OptionalConfiguration(arrowSize: 9,  //指示箭头大小
//            marginXSpacing: 7,  //MenuItem左右边距
//            marginYSpacing: 9,  //MenuItem上下边距
//            intervalSpacing: 25,  //MenuItemImage与MenuItemTitle的间距
//            menuCornerRadius: 5,  //菜单圆角半径
//            maskToBackground: true,  //是否添加覆盖在原View上的半透明遮罩
//            shadowOfMenu: false,  //是否添加菜单阴影
//            hasSeperatorLine: true,  //是否设置分割线
//            seperatorLineHasInsets: false,  //是否在分割线两侧留下Insets
//            textColor: Color(R: 0, G: 0, B: 0),  //menuItem字体颜色
//            menuBackgroundColor: Color(R: 1, G: 1, B: 1)  //菜单的底色
//        )
//        KxMenu.showMenuInView(self.view, fromRect: CGRectMake(self.view.bounds.width - 100, 0, 150, 0), menuItems: menuArray, withOptions: options)
        
        let vc = NewPlanViewController()
        vc.type = 1
        vc.plan = plan
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
  
    
    func Edit(){
//        self.contentTextView.editable = true
        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.mode = MBProgressHUDMode.Text
        hud.labelText = "编辑文本"
        hud.margin = 10.0
        hud.removeFromSuperViewOnHide = true
        hud.hide(true, afterDelay: 3)
    }
}
