//
//  ParentsExhortTableViewCell.swift
//  WXT_Parents
//
//  Created by zhang on 16/4/29.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class ParentsExhortTableViewCell: UITableViewCell {

//    姓名
    @IBOutlet weak var nameLbl: UILabel!
//    时间
    @IBOutlet weak var timeLbl: UILabel!
//    内容
    @IBOutlet weak var contentLbl: UILabel!
//    老师姓名
    @IBOutlet weak var teacherNameLbl: UILabel!
//    状态按钮
    @IBOutlet weak var remindBtn: UIButton!
//    老师头像
    @IBOutlet weak var headImageView: UIImageView!
//    老师姓名
    @IBOutlet weak var tNameLbl: UILabel!
//    回复时间
    @IBOutlet weak var receiveTimeLbl: UILabel!
//    回复内容
    @IBOutlet weak var receiveContentLbl: UILabel!
//    图片
    @IBOutlet weak var bigImageView: UIImageView!
//    回复视图
    @IBOutlet weak var bottomView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.remindBtn.layer.masksToBounds = true
        self.remindBtn.layer.cornerRadius = 10.0
        self.remindBtn.layer.borderWidth = 1.0
        self.remindBtn.layer.borderColor = UIColor.init(red: 138/255, green:227/255 , blue: 163/255, alpha: 1).CGColor
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func updateCellWithParentsList(exhortInfo:ExhortInfo){
        let dateformate = NSDateFormatter()
        dateformate.dateFormat = "yyyy-MM-dd HH:mm"
        
        nameLbl.text = exhortInfo.username
        self.contentLbl.text = exhortInfo.content
        let date = NSDate(timeIntervalSince1970: NSTimeInterval(exhortInfo.create_time!)!)
        let str:String = dateformate.stringFromDate(date)
        self.timeLbl.text = str
        self.teacherNameLbl.text = exhortInfo.teachername
        let imgUrl = microblogImageUrl + exhortInfo.photo!
        let photourl = NSURL(string: imgUrl)
        self.bigImageView.yy_setImageWithURL(photourl, placeholder: UIImage(named: "无网络的背景"))
        
        let feedback:String = exhortInfo.feedback!
        if  !feedback.isEmpty {
            self.receiveContentLbl.text = exhortInfo.feedback
            let date1 = NSDate(timeIntervalSince1970: NSTimeInterval(exhortInfo.feed_time!)!)
            let str1:String = dateformate.stringFromDate(date1)
            self.receiveTimeLbl.text = str1
            let imgUrl1 = imageUrl + exhortInfo.teacheravatar!
            let teacheravatar = NSURL(string: imgUrl1)
            self.headImageView.yy_setImageWithURL(teacheravatar, placeholder: UIImage(named: "Logo.png"))
        }else {
//            今天的日期
            let todayDate:NSDate = NSDate()
            let second = todayDate.timeIntervalSinceDate(date)
//            发布超过3小时可以进行提醒
            if second/3600 > 3 {
                self.remindBtn.setTitle("提醒", forState: .Normal)
                self.remindBtn.addTarget(self, action: #selector(ParentsExhortTableViewCell.remind), forControlEvents: .TouchUpInside)
            }else{
                self.remindBtn.setTitle("未回复", forState: .Normal)
            }
        }
    }
//    提醒
    func remind(){
        print("提醒老师")
    }
}
