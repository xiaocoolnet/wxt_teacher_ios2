//
//  tool.swift
//  校酷网络
//
//  Created by zhang on 16/3/17.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import Foundation
import MBProgressHUD
let WIDTH = UIScreen.mainScreen().bounds.size.width
let HEIGHT = UIScreen.mainScreen().bounds.size.height
func RGBA (r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat)->UIColor {
    return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}
//   动态计算高度
func calculateHeight(string:String,size:CGFloat,width:  CGFloat) -> CGFloat {
    let options : NSStringDrawingOptions = NSStringDrawingOptions.UsesLineFragmentOrigin
    //let screenBounds:CGRect = UIScreen.mainScreen().bounds
    let boundingRect = String(string).boundingRectWithSize(CGSizeMake(width, 0), options: options, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(size)], context: nil)
    
    return boundingRect.height
}
//时间戳转时间
func changeTime(string:String)->String{
    let dateformate = NSDateFormatter()
    dateformate.dateFormat = "yyyy-MM-dd HH:mm"//获得日期
    let date = NSDate(timeIntervalSince1970: NSTimeInterval(string)!)
    let str:String = dateformate.stringFromDate(date)
    return str
}
func messageHUD(view:UIView,messageData:String){
    let progressHUD = MBProgressHUD.showHUDAddedTo(view, animated: true)
    progressHUD.mode = MBProgressHUDMode.Text;
    progressHUD.labelText = messageData
    progressHUD.margin = 10.0
    progressHUD.removeFromSuperViewOnHide = true
    progressHUD.hide(true, afterDelay: 1)
}

func changeTimeTwo(string:String)->String{
    let dateformate = NSDateFormatter()
    dateformate.dateFormat = "MM-dd"//获得日期
    let date = NSDate(timeIntervalSince1970: NSTimeInterval(string)!)
    let str:String = dateformate.stringFromDate(date)
    return str
}
