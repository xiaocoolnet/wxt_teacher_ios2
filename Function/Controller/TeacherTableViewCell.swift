//
//  TeacherTableViewCell.swift
//  WXT_Teacher
//
//  Created by xiaocool on 16/6/23.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class TeacherTableViewCell: UITableViewCell {

    var iconIV = UIImageView()
    var titleL = UILabel()
    var contentL = UILabel()
    var timeL = UILabel()
    
    
    
    
    
    override func awakeFromNib() {
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        super.awakeFromNib()
        iconIV.frame=CGRectMake(5, 10, 60, 60)
        self.addSubview(iconIV)
        titleL.frame=CGRectMake(75, 10, self.bounds.width-185, 20)
        timeL.textColor=UIColor.blackColor()
        self.addSubview(titleL)
        timeL.frame=CGRectMake(self.bounds.width-110, 10, 100, 20)
        timeL.font=UIFont.systemFontOfSize(12)
        timeL.textColor=UIColor.grayColor()
        self.addSubview(timeL)
        contentL.frame=CGRectMake(80, 30, self.bounds.width-90, 45)
        contentL.textColor=UIColor.grayColor()
        contentL.font=UIFont.systemFontOfSize(13)
        contentL.lineBreakMode = .ByCharWrapping
        contentL.numberOfLines=0
        self.addSubview(contentL)
        
    }
    class func cellWithTableView(tableView:UITableView)->TeacherTableViewCell  {
        var cell = tableView.dequeueReusableCellWithIdentifier("a") as? TeacherTableViewCell
        
        if cell==nil {
            cell = TeacherTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "a")
        }
        return cell!
    }
    

}
