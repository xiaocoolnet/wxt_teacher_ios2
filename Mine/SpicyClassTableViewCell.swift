//
//  SpicyClassTableViewCell.swift
//  WXT_Parents
//
//  Created by 沈晓龙 on 16/8/3.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class SpicyClassTableViewCell: UITableViewCell {

    let imgView = UIImageView()
    let timeLable = UILabel()
    let titleLab = UILabel()
    let contentLab = UILabel()
    let btn = UILabel()
    
    let view = UIView()
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        for view in self.contentView.subviews {
            view.removeFromSuperview()
        }
        
        view.frame = CGRectMake(10, 50, WIDTH - 20, 340)
        view.backgroundColor = UIColor.whiteColor()
        self.contentView.addSubview(view)
        
        timeLable.frame = CGRectMake(WIDTH/2 - 30, 15, 60, 20)
        timeLable.textColor = UIColor.lightGrayColor()
        timeLable.text = "1小时前"
        timeLable.font = UIFont.systemFontOfSize(16)
        timeLable.textAlignment = NSTextAlignment.Center
        self.contentView.addSubview(timeLable)
        
        titleLab.frame = CGRectMake(10, 10, WIDTH - 40, 60)
        titleLab.text = "冬季今晚湖的户外和单位好玩我海外饿我海外电话我胡搞成根深蒂固测报拆饿醋味请我出去因为电影"
        titleLab.numberOfLines = 0
        self.view.addSubview(titleLab)
        
        imgView.frame = CGRectMake(10, 80, WIDTH - 40, 160)
        imgView.image = UIImage(named: "5")
        self.view.addSubview(imgView)
        
        contentLab.frame = CGRectMake(10, 250, WIDTH - 40, 60)
        contentLab.textColor = UIColor.lightGrayColor()
        contentLab.text = "在这个处处讲北京的年代，东湖恶化度渡河的得出的活动等动物黑户的变成大叔是恶化 六个成员国一次乌俄对外我诶代表处的IE文化氛围不完"
        contentLab.font = UIFont.systemFontOfSize(16)
        contentLab.numberOfLines = 0
        self.view.addSubview(contentLab)
        
        btn.frame = CGRectMake(10, 320, 120, 20)
        btn.text = "阅读全文"
        btn.font = UIFont.systemFontOfSize(16)
        self.view.addSubview(btn)
        
        
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
