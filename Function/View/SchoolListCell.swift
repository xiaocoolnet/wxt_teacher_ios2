//
//  SchoolListCell.swift
//  WXT_Teacher
//
//  Created by xiaocool on 16/7/19.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class SchoolListCell: UITableViewCell {

    var iconIV = UIImageView()
    var titleL = UILabel()
    var contentL = UILabel()
    var timeL = UILabel()
    
    
    
    
    
    override func awakeFromNib() {
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        super.awakeFromNib()
        iconIV.frame=CGRectMake(10, 10, 80, 80)
        self.addSubview(iconIV)
        titleL.frame=CGRectMake(100, 10, self.bounds.width/2, 20)
        timeL.textColor=wenziColor
        self.addSubview(titleL)
        timeL.frame=CGRectMake(200, self.bounds.height-30, self.bounds.width-210, 20)
        timeL.font=UIFont.systemFontOfSize(12)
        timeL.textColor=UIColor.grayColor()
        self.addSubview(timeL)
        contentL.frame=CGRectMake(100, 40, self.bounds.width-110, 20)
        contentL.textColor=UIColor.grayColor()
        contentL.font=UIFont.systemFontOfSize(13)
        self.addSubview(contentL)
        
    }
    class func cellWithTableView(tableView:UITableView)->SchoolListCell  {
        var cell = tableView.dequeueReusableCellWithIdentifier("a") as? SchoolListCell
        
        if cell==nil {
            cell = SchoolListCell(style: UITableViewCellStyle.Default, reuseIdentifier: "a")
        }
        return cell!
    }

}
