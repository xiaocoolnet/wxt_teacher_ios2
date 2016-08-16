//
//  QCDetailsClassActiveCell.swift
//  WXT_Parents
//
//  Created by 沈晓龙 on 16/7/19.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class QCDetailsClassActiveCell: UITableViewCell {
    
    var headerImageView = UIImageView()
    var headerTitelImage = UIImageView()
    var teacherLabel = UILabel()
    var timeLabel = UILabel()
    var titleLabel = UILabel()
    var contentLabel = UILabel()
    var startTime = UILabel()
    var activeTimes = UILabel()
    var contentImageView = UIImageView()
    var joinButton = UIButton()
    var joinCountLabel = UILabel()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        headerImageView.frame = CGRectMake(15, 15, 60, 60)
        headerImageView.image = UIImage.init(named: "1.png")
        headerImageView.cornerRadius = 30
        self.contentView.addSubview(headerImageView)
        
        headerTitelImage.frame = CGRectMake(90, 15, 20, 20)
        headerTitelImage.image = UIImage.init(named: "ic_fasong")
        self.contentView.addSubview(headerTitelImage)
        
        teacherLabel.frame = CGRectMake(110, 15, 100, 20)
        teacherLabel.text = "张老师"
        self.contentView.addSubview(teacherLabel)
        
        timeLabel.frame = CGRectMake(90, 55, 100, 20)
        timeLabel.text = "07-26 12:61"
        timeLabel.textColor = UIColor.lightGrayColor()
        self.contentView.addSubview(timeLabel)
        
        let view = UIView()
        view.frame = CGRectMake(0, 90, WIDTH, 1)
        view.backgroundColor = UIColor.grayColor()
        self.contentView.addSubview(view)
        
        titleLabel.frame = CGRectMake((WIDTH - 200) / 2, 100, 200, 30)
        titleLabel.text = "舞蹈大赛活动"
        titleLabel.textAlignment = NSTextAlignment.Center
        self.contentView.addSubview(titleLabel)
        
        //  进行多行显示即可
        contentLabel.frame = CGRectMake(10, 130, WIDTH - 20, 200)
        contentLabel.numberOfLines = 0
        contentLabel.text = "舞蹈大赛活动舞蹈大赛活动舞蹈大赛活动舞蹈大赛活动舞蹈大赛活动舞蹈大赛活动舞蹈大赛活动舞蹈大赛活动舞蹈大赛活动舞蹈大赛活动舞蹈大赛活动舞蹈大赛活动舞蹈大赛活动舞蹈大赛活动舞蹈大赛活动舞蹈大赛活动舞蹈大赛活动舞蹈大赛活动舞蹈大赛活动舞蹈大赛活动"
        contentLabel.textColor = UIColor.lightGrayColor()
        self.contentView.addSubview(contentLabel)
        
        startTime.frame = CGRectMake(10, 330, WIDTH - 20, 30)
        startTime.text = "大赛举办时间2016-08-15"
        startTime.textColor = UIColor.lightGrayColor()
        self.contentView.addSubview(startTime)
        
        activeTimes.frame = CGRectMake(10, 360, WIDTH - 20, 30)
        activeTimes.textColor = UIColor.lightGrayColor()
        activeTimes.text = "报名起止日期07-18到08-15"
        self.contentView.addSubview(activeTimes)
        
        contentImageView.frame = CGRectMake(10, 390, WIDTH - 20, (WIDTH - 20) * 0.66)
        contentImageView.image = UIImage.init(named: "1.png")
//        self.contentView.addSubview(contentImageView)
        
       
//        
//        joinCountLabel.frame = CGRectMake(10, 460 + WIDTH * 0.66, WIDTH - 20, 20)
//        joinCountLabel.textColor = UIColor.orangeColor()
//        joinCountLabel.text = "已报名人数为22"
//        self.contentView.addSubview(joinCountLabel)
        
        
    }
    func joinAction(){
        
        print("报名活动")
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
