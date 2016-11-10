//
//  BirthdayViewController.swift
//  HQHotel
//
//  Created by xiaocool on 16/6/23.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit
protocol sendTimeDelegate:NSObjectProtocol {
    func sendTime(time:String)
}
class BirthdayViewController: UIViewController {
    let dateFormatter = NSDateFormatter()
    var  datePicker = UIDatePicker()
    var yesBT = UIButton()
    var str = String()
    var delegate : sendTimeDelegate?
    
    var timeView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.whiteColor()

        yesBT.frame=CGRectMake(self.view.frame.width/2-60, 66+frame.height/2, 120, 30)
        yesBT.backgroundColor=UIColor.greenColor()
        yesBT.setTitle("确认", forState: .Normal)
        yesBT.layer.masksToBounds=false
        yesBT.layer.cornerRadius=4
        
        yesBT.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        yesBT.titleLabel?.textAlignment = .Center
        yesBT.addTarget(self, action: #selector(viewtap), forControlEvents: .TouchUpInside)
        

        
        // 初始化 datePicker
        
        datePicker.frame = CGRectMake(0, 66, self.view.frame.width, frame.height/2)
        
        // 设置样式，当前设为显示日期，
        
        datePicker.datePickerMode = UIDatePickerMode.Date
        
        // 设置日期范围（超过日期范围，会回滚到最近的有效日期）
        
        //        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let maxDate = dateFormatter.dateFromString("1970-01-01 ")
        
        let minDate = dateFormatter.dateFromString("2016-01-01 ")
        
        datePicker.maximumDate = maxDate
        
        datePicker.minimumDate = minDate
        
        // 设置默认时间
        
        datePicker.date = NSDate()
        
        // 响应事件（只要滚轮变化就会触发）
        
        datePicker.addTarget(self, action:#selector(BirthdayViewController.datePickerValueChange(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        
        self.view.addSubview(yesBT)

        self.view.addSubview(datePicker)
        

    }
    func datePickerValueChange(sender: UIDatePicker) {
        let datestr = dateFormatter.stringFromDate(sender.date)
    
        self.delegate?.sendTime(datestr)
        
    }
    func viewtap(){

        self.navigationController?.popViewControllerAnimated(true)
        
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
