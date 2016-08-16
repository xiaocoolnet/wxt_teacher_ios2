


//
//  QCTakeBabyCell.swift
//  WXT_Parents
//
//  Created by 沈晓龙 on 16/7/21.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class QCTakeBabyCell: UITableViewCell {
    
    var headImageView = UIImageView()
    var nameLabel = UILabel()
    var timeLabel = UILabel()
    var bigImageView = UIImageView()
    var agreeBtn = UIButton()
    var somebodyLabel = UILabel()
    var banjiLable = UILabel()
    var disagreeBtn = UIButton()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        headImageView.frame = CGRectMake(10, 10, 60, 60)
        headImageView.cornerRadius = 30
        headImageView.image = UIImage.init(named: "1")
        contentView.addSubview(headImageView)
        
        nameLabel.frame = CGRectMake(80, 10, 100, 30)
        nameLabel.text = "老师名称"
        contentView.addSubview(nameLabel)
        
        banjiLable.frame = CGRectMake(80, 45, 100, 30)
        banjiLable.textColor = UIColor.lightGrayColor()
        banjiLable.text = "大幼一班"
        banjiLable.font = UIFont.systemFontOfSize(14)
        contentView.addSubview(banjiLable)
        
        timeLabel.frame = CGRectMake(WIDTH - 150, 45, 150, 30)
        timeLabel.text = "今天16:30"
        timeLabel.textColor = UIColor.lightGrayColor()
        timeLabel.font = UIFont.systemFontOfSize(14)
        contentView.addSubview(timeLabel)
        
        let view = UIView()
        view.frame = CGRectMake(0, 80, WIDTH, 1)
        view.backgroundColor = UIColor.lightGrayColor()
        contentView.addSubview(view)
        
        bigImageView.frame = CGRectMake(10, 90, WIDTH - 20, 280)
        bigImageView.image = UIImage.init(named: "1")
        contentView.addSubview(bigImageView)
        
        somebodyLabel = UILabel()
        somebodyLabel.frame = CGRectMake(10, 380, WIDTH - 20, 20)
        somebodyLabel.textColor = UIColor.grayColor()
        somebodyLabel.text = "\(somebodyLabel.text)家长，这个人可以接走孩子么？"
        contentView.addSubview(somebodyLabel)
        
        let view2 = UIView()
        view2.frame = CGRectMake(0, 410, WIDTH, 1)
        view2.backgroundColor = UIColor.lightGrayColor()
        contentView.addSubview(view2)
        
        disagreeBtn.frame = CGRectMake(WIDTH / 2, 415, WIDTH / 4 - 10, 30)
        disagreeBtn.backgroundColor = UIColor.orangeColor()
        disagreeBtn.cornerRadius = 5
        disagreeBtn.setTitle("呼叫", forState: .Normal)
        contentView.addSubview(disagreeBtn)
        
        agreeBtn.frame = CGRectMake(WIDTH / 4 * 3, 415, WIDTH / 4 - 10, 30)
        agreeBtn.backgroundColor = RGBA(155, g: 229, b: 180, a: 1)
        agreeBtn.cornerRadius = 5
        agreeBtn.setTitle("提醒", forState: .Normal)
        contentView.addSubview(agreeBtn)
        
        
        
        
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
