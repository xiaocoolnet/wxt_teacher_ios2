//
//  ActivityTableViewCell.swift
//  WXT_Parents
//
//  Created by 沈晓龙 on 16/8/3.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {

    let imgView = UIImageView()
    let timeLable = UILabel()
    let personLab = UILabel()
    
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        for view in self.contentView.subviews {
            view.removeFromSuperview()
        }
        
        imgView.frame = CGRectMake(10, 10, WIDTH - 20, 170)
        imgView.image = UIImage(named: "4")
        self.contentView.addSubview(imgView)
        
        timeLable.frame = CGRectMake(10, 190, 140, 20)
        timeLable.text = "剩余时间：6天"
        timeLable.textColor = UIColor.lightGrayColor()
        timeLable.font = UIFont.systemFontOfSize(16)
        self.contentView.addSubview(timeLable)
        
        personLab.frame = CGRectMake(150, 190, WIDTH - 160, 20)
        personLab.text = "100人参加"
        personLab.textColor = UIColor.lightGrayColor()
        personLab.font = UIFont.systemFontOfSize(16)
        personLab.textAlignment = NSTextAlignment.Right
        self.contentView.addSubview(personLab)
        
        let view = UIView()
        view.frame = CGRectMake(0, 210, WIDTH, 15)
        view.backgroundColor = RGBA(242.0, g: 242.0, b: 242.0, a: 1)
        self.contentView.addSubview(view)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
