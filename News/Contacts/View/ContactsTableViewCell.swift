//
//  ContactsTableViewCell.swift
//  WXT_Teachers
//
//  Created by 李春波 on 16/2/23.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class ContactsTableViewCell: UITableViewCell {

    let MY_FONT = "Bauhaus ITC"
    var nameLabel = UILabel()
    var duanxinBtn = UIButton()
    var ipBtn = UIButton()
    var phoneBtn = UIButton()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        for view in self.contentView.subviews {
            view.removeFromSuperview()
        }
        
        self.nameLabel.frame = CGRectMake(self.bounds.height/2+20/2, 8, 100, 20)
        self.nameLabel.font = UIFont(name: MY_FONT, size: 15)
        self.nameLabel.textColor = UIColor.blackColor()
        duanxinBtn.frame = CGRectMake(UIScreen.mainScreen().bounds.width - 72, 10, 17, 17)
       
        ipBtn.frame = CGRectMake(UIScreen.mainScreen().bounds.width - 50, 10, 17, 17)
        
        phoneBtn.frame = CGRectMake(UIScreen.mainScreen().bounds.width - 30, 10, 17, 17)
    
        duanxinBtn.setImage(UIImage(named: "发消息"), forState: .Normal)
        ipBtn.setImage(UIImage(named: "电话"), forState: .Normal)
        phoneBtn.setImage(UIImage(named: "电话2"), forState: .Normal)
        self.contentView.addSubview(self.nameLabel)
        self.contentView.addSubview(duanxinBtn)
        self.contentView.addSubview(ipBtn)
        self.contentView.addSubview(phoneBtn)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
