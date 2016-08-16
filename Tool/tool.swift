//
//  tool.swift
//  校酷网络
//
//  Created by zhang on 16/3/17.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import Foundation

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
    print(boundingRect.height)
    return boundingRect.height
}