//
//  TeacherDianPingTableViewCell.swift
//  WXT_Teacher
//
//  Created by 李春波 on 16/3/12.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class TeacherDianPingTableViewCell: UITableViewCell {

    let avatorImage = UIImageView()
    let nameLabel = UILabel()
    let contentLabel = UILabel()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        for view in self.contentView.subviews {
            view.removeFromSuperview()
        }
        self.avatorImage.frame = CGRectMake(10, 5, 40, 40)
        self.avatorImage.layer.cornerRadius = 20
        self.avatorImage.layer.masksToBounds = true
        self.nameLabel.frame = CGRectMake(60, 5, 70, 40)
        self.nameLabel.font = UIFont.systemFontOfSize(16)
        self.nameLabel.textAlignment = .Center
        self.contentLabel.frame = CGRectMake(WIDTH-170, 5, 150, 40)
        self.contentLabel.font = UIFont.systemFontOfSize(15)
        self.contentLabel.textColor = UIColor.init(red: 155.0/255, green: 229.0/255, blue: 180.0/255, alpha: 1)
        self.contentLabel.textAlignment = NSTextAlignment.Right
        self.contentLabel.numberOfLines = 1
        
        let im = UIImageView()
        im.frame = CGRectMake(self.contentLabel.frame.maxX, 15, 10, 20)
        im.image = UIImage(named: "右侧箭头")
        self.contentView.addSubview(im)
        self.contentView.addSubview(self.nameLabel)
        self.contentView.addSubview(self.avatorImage)
        self.contentView.addSubview(self.contentLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
