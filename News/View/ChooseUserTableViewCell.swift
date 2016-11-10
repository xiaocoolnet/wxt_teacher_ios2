//
//  ChooseUserTableViewCell.swift
//  WXT_Teacher
//
//  Created by qiang on 16/8/18.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class ChooseUserTableViewCell: UITableViewCell {

    
    
    
    var nameLabel = UILabel()
    var select = CustomBtn()
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        for view in self.contentView.subviews {
            view.removeFromSuperview()
        }
       
        nameLabel.frame = CGRectMake(40, 10, WIDTH - 80, 20)
        nameLabel.font = UIFont.systemFontOfSize(15)
        self.contentView.addSubview(nameLabel)
       
        select.frame = CGRectMake(WIDTH - 40, 10, 30, 30)

        select.setBackgroundImage(UIImage(named: "deseleted"), forState: UIControlState.Normal)
        select.setBackgroundImage(UIImage(named: "selected"), forState: UIControlState.Selected)
        self.contentView.addSubview(select)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
