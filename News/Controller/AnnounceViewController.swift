//
//  AnnounceViewController.swift
//  WXT_Teacher
//
//  Created by xiaocool on 16/8/14.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import PagingMenuController
class AnnounceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "通知公告"
        let shou = ReciveAnnounceViewController()
        let yifa = TongZhiGonggaoViewController()
        
        shou.title = "我收到的"
        yifa.title = "我发出的"
        
        
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
        let rightItem = UIBarButtonItem(title: "新增", style: UIBarButtonItemStyle.Done, target: self, action: #selector(addThing))
        self.navigationItem.rightBarButtonItem = rightItem

        // Do any additional setup after loading the view.
    }
    
    
    func addThing(){
        let obj = NSMutableArray()
        
        for titles in self.titles() {
            let wb = WBPopMenuModel()
            wb.title = titles as! String
            obj.addObject(wb)
            
        }
        WBPopMenuSingleton.shareManager().showPopMenuSelecteWithFrame(100, item: obj as [AnyObject]) { (index) in
            
            let add = AddJZGongGaoViewController()
            if index==0{
                add.type = "0"
            }else{
                add.type = "1"
            }
            self.navigationController?.pushViewController(add, animated: true)
        }
        

    }

    
    func titles() -> NSArray {
        return ["教师公告","学生公告"]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        let user = NSUserDefaults.standardUserDefaults()
        user.removeObjectForKey("noticeArr")
    }
    override func viewWillDisappear(animated: Bool) {
        let user = NSUserDefaults.standardUserDefaults()
        user.removeObjectForKey("noticeArr")
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
