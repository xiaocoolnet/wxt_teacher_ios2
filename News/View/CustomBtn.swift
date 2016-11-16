//
//  CustomBtn.swift
//  WXT_Teacher
//
//  Created by qiang on 16/8/24.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class CustomBtn: UIButton {

    var sections : NSInteger?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //do something what you want
        self.imageView?.contentMode = .ScaleAspectFill
    }
//    重写的话Swift规定不可以缺少这个request init方法：（编译器会自动提示）
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
