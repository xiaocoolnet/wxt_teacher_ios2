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
func changeTimeThree(string:String)->String{
    let dateformate = NSDateFormatter()
    dateformate.dateFormat = "yyyy-MM-dd"//获得日期
    let date = NSDate(timeIntervalSince1970: NSTimeInterval(string)!)
    let str:String = dateformate.stringFromDate(date)
    return str
}
func changeTimefour(string:String)->String{
    let dateformate = NSDateFormatter()
    dateformate.dateFormat = "HH:mm"//获得日期
    let date = NSDate(timeIntervalSince1970: NSTimeInterval(string)!)
    let str:String = dateformate.stringFromDate(date)
    return str
}
/**
 :param: stringTime 时间为stirng
 
 :returns: 返回时间戳为stirng
 */
func stringToTimeStamp(stringTime:String)->String {
    
    let dfmatter = NSDateFormatter()
    dfmatter.dateFormat="yyyy-MM-dd-HH-mm-ss"
    let date = dfmatter.dateFromString(stringTime)
    
    let dateStamp:NSTimeInterval = date!.timeIntervalSince1970
    
    let dateSt:Int = Int(dateStamp)
    print(dateSt)
    return String(dateSt)
    
}
func changeTimeFour(string:String)->String{
    let dateformate = NSDateFormatter()
    dateformate.dateFormat = "yyyy-MM"//获得日期
    let date = NSDate(timeIntervalSince1970: NSTimeInterval(string)!)
    let str:String = dateformate.stringFromDate(date)
    return str
}

//添加分割线
func addCommentDividerOneLine(view : UIView,y:CGFloat)->CGFloat{
    
    let divider = UIView()
    divider.frame = CGRectMake(0, y, view.bounds.width, 1)
    divider.backgroundColor = RGBA(225.0, g: 225.0, b: 225.0, a: 1)
    view.addSubview(divider)
    return 1
}

func addDividerLongLine(view : UIView,y:CGFloat)->CGFloat{
    
    let divider = UIView()
    divider.frame = CGRectMake(0, y, WIDTH, 20)
    divider.backgroundColor = RGBA(242.0, g: 242.0, b: 242.0, a: 1)
    view.addSubview(divider)
    
    return 20
}

func addDividerLine(view : UIView,y:CGFloat,height:CGFloat)->UIView{
    
    let divider = UIView()
    divider.frame = CGRectMake(0, y, WIDTH, height)
    divider.backgroundColor = RGBA(242.0, g: 242.0, b: 242.0, a: 1)
    view.addSubview(divider)
    
    return divider
}
