//
//  QCTeacherCommentCell.swift
//  WXT_Parents
//
//  Created by 沈晓龙 on 16/7/15.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class QCTeacherCommentCell: UITableViewCell {
    var headerImageView = UIImageView()
    var teacherLabel = UILabel()
    var timeLable = UILabel()
    
    var studyLable = UILabel()
    var actionLable = UILabel()
    var singLable = UILabel()
    
    var laborLable = UILabel()
    var skillLable = UILabel()
    var relationLable = UILabel()
    
    var contentLable = UILabel()
    
    var studyButtonZan = UIButton()
    var studyButtonRHua = UIButton()
    var studyButtonGHua = UIButton()
    let studyZan = UILabel()
    let studyRHua = UILabel()
    let studyGHua = UILabel()
    
    var actionButtonZan = UIButton()
    var actionButtonRHua = UIButton()
    var actionButtonGHua = UIButton()
    let actionZan = UILabel()
    let actionRHua = UILabel()
    let actionGHua = UILabel()
    
    var singButtonZan = UIButton()
    var singButtonRHua = UIButton()
    var singButtonGHua = UIButton()
    let singZan = UILabel()
    let singRHua = UILabel()
    let singGHua = UILabel()
    
    var laborButtonZan = UIButton()
    var laborButtonRHua = UIButton()
    var laborButtonGHua = UIButton()
    let laborZan = UILabel()
    let laborRHua = UILabel()
    let laborGHua = UILabel()
    
    var skillButtonZan = UIButton()
    var skillButtonRHua = UIButton()
    var skillButtonGHua = UIButton()
    let skillZan = UILabel()
    let skillRHua = UILabel()
    let skillGHua = UILabel()
    
    var relationButtonZan = UIButton()
    var relationButtonRHua = UIButton()
    var relationButtonGHua = UIButton()
    let relationZan = UILabel()
    let relationRHua = UILabel()
    let relationGHua = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        for view in self.contentView.subviews {
            view.removeFromSuperview()
        }
        
        headerImageView.frame = CGRectMake(10, 10, 60, 60)
        headerImageView.image = UIImage.init(named: "1")
        headerImageView.cornerRadius = 30
        self.contentView.addSubview(headerImageView)
        teacherLabel.frame = CGRectMake(80, 10, 200, 30)
//        teacherLabel.text = "点评人:王老师"
        self.contentView.addSubview(teacherLabel)
        timeLable.frame = CGRectMake(80, 40, 200, 30)
//        timeLable.text = "1888-08:08-08:08"
        timeLable.font = UIFont.systemFontOfSize(14)
        timeLable.textColor = UIColor.lightGrayColor()
        self.contentView.addSubview(timeLable)
        
        studyLable = createLabel(CGRectMake(20, 100, WIDTH * 0.4 - 40, 30))
        studyLable.text = "学习"
        self.contentView.addSubview(studyLable)
//        studyButtonRHua = createButton(CGRectMake(WIDTH * 0.4, 100, 30, 30), image_nor: "ic_hui", image_press: "ic_hong")
        studyButtonRHua.frame = CGRectMake(WIDTH * 0.4, 100, 30, 30)
        studyButtonRHua.setImage(UIImage(named: "ic_hui"), forState: .Normal)
        self.contentView.addSubview(studyButtonRHua)
        studyRHua.frame = CGRectMake(WIDTH * 0.4 + 30, 100, WIDTH * 0.6 - (WIDTH * 0.4 + 30), 30)
        studyRHua.text = "优秀"
        self.contentView.addSubview(studyRHua)

//        studyButtonGHua = createButton(CGRectMake(WIDTH * 0.6, 100, 30, 30), image_nor: "ic_hui", image_press: "ic_ju")
        studyButtonGHua.frame = CGRectMake(WIDTH * 0.6, 100, 30, 30)
        studyButtonGHua.setImage(UIImage(named: "ic_hui"), forState: .Normal)
        self.contentView.addSubview(studyButtonGHua)
        studyGHua.frame = CGRectMake(WIDTH * 0.6 + 30, 100, WIDTH * 0.8 - WIDTH * 0.6 - 30, 30)
        studyGHua.text = "良好"
        self.contentView.addSubview(studyGHua)


//        studyButtonZan = createButton(CGRectMake(WIDTH * 0.8, 100, 30, 30), image_nor: "ic_hui", image_press: "ic_huang")
        studyButtonZan.frame = CGRectMake(WIDTH * 0.8, 100, 30, 30)
        studyButtonZan.setImage(UIImage(named: "ic_hui"), forState: .Normal)
        self.contentView.addSubview(studyButtonZan)
        studyZan.frame = CGRectMake(WIDTH * 0.8 + 30, 100,WIDTH - WIDTH * 0.8 - 40, 30)
        studyZan.text = "一般"
        self.contentView.addSubview(studyZan)
        
        
        
        actionLable = createLabel(CGRectMake(20, 140, WIDTH * 0.4 - 40, 30))
        actionLable.text = "动手能力"
        self.contentView.addSubview(actionLable)
//        actionButtonRHua = createButton(CGRectMake(WIDTH * 0.4, 140, 30, 30), image_nor: "ic_hui", image_press: "ic_hong")
        actionButtonRHua.frame = CGRectMake(WIDTH * 0.4, 140, 30, 30)
        actionButtonRHua.setImage(UIImage(named: "ic_hui"), forState: .Normal)
        self.contentView.addSubview(actionButtonRHua)
        actionRHua.frame = CGRectMake(WIDTH * 0.4 + 30, 140, WIDTH * 0.6 - (WIDTH * 0.4 + 30), 30)
        actionRHua.text = "优秀"
        self.contentView.addSubview(actionRHua)
        
//        actionButtonGHua = createButton(CGRectMake(WIDTH * 0.6, 140, 30, 30), image_nor: "ic_hui", image_press: "ic_ju")
        actionButtonGHua.frame = CGRectMake(WIDTH * 0.6, 140, 30, 30)
        actionButtonGHua.setImage(UIImage(named: "ic_hui"), forState: .Normal)
        self.contentView.addSubview(actionButtonGHua)
        actionGHua.frame = CGRectMake(WIDTH * 0.6 + 30, 140, WIDTH * 0.8 - WIDTH * 0.6 - 30, 30)
        actionGHua.text = "良好"
        self.contentView.addSubview(actionGHua)
        
//        actionButtonZan = createButton(CGRectMake(WIDTH * 0.8, 140, 30, 30), image_nor: "ic_hui", image_press: "ic_huang")
        actionButtonZan.frame = CGRectMake(WIDTH * 0.8, 140, 30, 30)
        actionButtonZan.setImage(UIImage(named: "ic_hui"), forState: .Normal)
        self.contentView.addSubview(actionButtonZan)
        actionZan.frame = CGRectMake(WIDTH * 0.8 + 30, 140,WIDTH - WIDTH * 0.8 - 40, 30)
        actionZan.text = "一般"
        self.contentView.addSubview(actionZan)
        
        
        singLable = createLabel(CGRectMake(20, 180, WIDTH * 0.4 - 40, 30))
        singLable.text = "唱歌"
        self.contentView.addSubview(singLable)
//        singButtonRHua = createButton(CGRectMake(WIDTH * 0.4, 180, 30, 30), image_nor: "ic_hui", image_press: "ic_hong")
        singButtonRHua.frame = CGRectMake(WIDTH * 0.4, 180, 30, 30)
        singButtonRHua.setImage(UIImage(named: "ic_hui"), forState: .Normal)
        self.contentView.addSubview(singButtonRHua)
        singRHua.frame = CGRectMake(WIDTH * 0.4 + 30, 180, WIDTH * 0.6 - (WIDTH * 0.4 + 30), 30)
        singRHua.text = "优秀"
        self.contentView.addSubview(singRHua)
        
//        singButtonGHua = createButton(CGRectMake(WIDTH * 0.6, 180, 30, 30), image_nor: "ic_hui", image_press: "ic_ju")
        singButtonGHua.frame = CGRectMake(WIDTH * 0.6, 180, 30, 30)
        singButtonGHua.setImage(UIImage(named: "ic_hui"), forState: .Normal)

        self.contentView.addSubview(singButtonGHua)
        singGHua.frame = CGRectMake(WIDTH * 0.6 + 30, 180, WIDTH * 0.8 - WIDTH * 0.6 - 30, 30)
        singGHua.text = "良好"
        self.contentView.addSubview(singGHua)
        
//        singButtonZan = createButton(CGRectMake(WIDTH * 0.8, 180, 30, 30), image_nor: "ic_hui", image_press: "ic_huang")
        singButtonZan.frame = CGRectMake(WIDTH * 0.8, 180, 30, 30)
        singButtonZan.setImage(UIImage(named: "ic_hui"), forState: .Normal)
        self.contentView.addSubview(singButtonZan)
        singZan.frame = CGRectMake(WIDTH * 0.8 + 30, 180,WIDTH - WIDTH * 0.8 - 40, 30)
        singZan.text = "一般"
        self.contentView.addSubview(singZan)
        
        
        
        laborLable = createLabel(CGRectMake(20, 220, WIDTH * 0.4 - 40, 30))
        laborLable.text = "劳动"
        self.contentView.addSubview(laborLable)
//        laborButtonRHua = createButton(CGRectMake(WIDTH * 0.4, 220, 30, 30), image_nor: "ic_hui", image_press: "ic_hong")
        laborButtonRHua.frame = CGRectMake(WIDTH * 0.4, 220, 30, 30)
        laborButtonRHua.setImage(UIImage(named: "ic_hui"), forState: .Normal)
        self.contentView.addSubview(laborButtonRHua)
        laborRHua.frame = CGRectMake(WIDTH * 0.4 + 30, 220, WIDTH * 0.6 - (WIDTH * 0.4 + 30), 30)
        laborRHua.text = "优秀"
        self.contentView.addSubview(laborRHua)
        
//        laborButtonGHua = createButton(CGRectMake(WIDTH * 0.6, 220, 30, 30), image_nor: "ic_hui", image_press: "ic_ju")
        laborButtonGHua.frame = CGRectMake(WIDTH * 0.6, 220, 30, 30)
        laborButtonGHua.setImage(UIImage(named: "ic_hui"), forState: .Normal)
        self.contentView.addSubview(laborButtonGHua)
        laborGHua.frame = CGRectMake(WIDTH * 0.6 + 30, 220, WIDTH * 0.8 - WIDTH * 0.6 - 30, 30)
        laborGHua.text = "良好"
        self.contentView.addSubview(laborGHua)

        
//        laborButtonZan = createButton(CGRectMake(WIDTH * 0.8, 220, 30, 30), image_nor: "ic_hui", image_press: "ic_huang")
        laborButtonZan.frame = CGRectMake(WIDTH * 0.8, 220, 30, 30)
        laborButtonZan.setImage(UIImage(named: "ic_hui"), forState: .Normal)
        self.contentView.addSubview(laborButtonZan)
        laborZan.frame = CGRectMake(WIDTH * 0.8 + 30, 220,WIDTH - WIDTH * 0.8 - 40, 30)
        laborZan.text = "一般"
        self.contentView.addSubview(laborZan)
        
        
        
        
        skillLable = createLabel(CGRectMake(20, 260, WIDTH * 0.4 - 40, 30))
        skillLable.text = "应变能力"
        self.contentView.addSubview(skillLable)
//        skillButtonRHua = createButton(CGRectMake(WIDTH * 0.4, 260, 30, 30), image_nor: "ic_hui", image_press: "ic_hong")
        skillButtonRHua.frame = CGRectMake(WIDTH * 0.4, 260, 30, 30)
        skillButtonRHua.setImage(UIImage(named: "ic_hui"), forState: .Normal)
        self.contentView.addSubview(skillButtonRHua)
        skillRHua.frame = CGRectMake(WIDTH * 0.4 + 30, 260, WIDTH * 0.6 - (WIDTH * 0.4 + 30), 30)
        skillRHua.text = "优秀"
        self.contentView.addSubview(skillRHua)
        
//        skillButtonGHua = createButton(CGRectMake(WIDTH * 0.6, 260, 30, 30), image_nor: "ic_hui", image_press: "ic_ju")
        skillButtonGHua.frame = CGRectMake(WIDTH * 0.6, 260, 30, 30)
        skillButtonGHua.setImage(UIImage(named: "ic_hui"), forState: .Normal)
        self.contentView.addSubview(skillButtonGHua)
        skillGHua.frame = CGRectMake(WIDTH * 0.6 + 30, 260, WIDTH * 0.8 - WIDTH * 0.6 - 30, 30)
        skillGHua.text = "良好"
        self.contentView.addSubview(skillGHua)
        
//        skillButtonZan = createButton(CGRectMake(WIDTH * 0.8, 260, 30, 30), image_nor: "ic_hui", image_press: "ic_huang")
        skillButtonZan.frame = CGRectMake(WIDTH * 0.8, 260, 30, 30)
        skillButtonZan.setImage(UIImage(named: "ic_hui"), forState: .Normal)
        self.contentView.addSubview(skillButtonZan)
        skillZan.frame = CGRectMake(WIDTH * 0.8 + 30, 260,WIDTH - WIDTH * 0.8 - 40, 30)
        skillZan.text = "一般"
        self.contentView.addSubview(skillZan)

        
        
        
        relationLable = createLabel(CGRectMake(20, 300, WIDTH * 0.4 - 40, 30))
        relationLable.text = "伙伴关系"
        self.contentView.addSubview(relationLable)
//        relationButtonRHua = createButton(CGRectMake(WIDTH * 0.4, 300, 30, 30), image_nor: "ic_hui", image_press: "ic_hong")
        relationButtonRHua.frame = CGRectMake(WIDTH * 0.4, 300, 30, 30)
        relationButtonRHua.setImage(UIImage(named: "ic_hui"), forState: .Normal)
        self.contentView.addSubview(relationButtonRHua)
        relationRHua.frame = CGRectMake(WIDTH * 0.4 + 30, 300, WIDTH * 0.6 - (WIDTH * 0.4 + 30), 30)
        relationRHua.text = "优秀"
        self.contentView.addSubview(relationRHua)

        
//        relationButtonGHua = createButton(CGRectMake(WIDTH * 0.6, 300, 30, 30), image_nor: "ic_hui", image_press: "ic_ju")
        relationButtonGHua.frame = CGRectMake(WIDTH * 0.6, 300, 30, 30)
        relationButtonGHua.setImage(UIImage(named: "ic_hui"), forState: .Normal)
        self.contentView.addSubview(relationButtonGHua)
        relationGHua.frame = CGRectMake(WIDTH * 0.6 + 30, 300, WIDTH * 0.8 - WIDTH * 0.6 - 30, 30)
        relationGHua.text = "良好"
        self.contentView.addSubview(relationGHua)

        
//        relationButtonZan = createButton(CGRectMake(WIDTH * 0.8, 300, 30, 30), image_nor: "ic_hui", image_press: "ic_huang")
        relationButtonZan.frame = CGRectMake(WIDTH * 0.8, 300, 30, 30)
        relationButtonZan.setImage(UIImage(named: "ic_hui"), forState: .Normal)
        self.contentView.addSubview(relationButtonZan)
        relationZan.frame = CGRectMake(WIDTH * 0.8 + 30, 300,WIDTH - WIDTH * 0.8 - 40, 30)
        relationZan.text = "一般"
        self.contentView.addSubview(relationZan)
        
        
        contentLable.frame = CGRectMake(10, 340, WIDTH - 20, 120)
        contentLable.numberOfLines = 0
        contentLable.text = "孩子在学校表现很好，经常打架，调皮，还骂老师，打女同学，又好吃又懒，完全是火星来的吧，真是服了！～～～～"
        self.contentView.addSubview(contentLable)

    }
    
    var info:TeacherCommentInfo? {
        didSet {
            studyButtonRHua.setImage(UIImage(named: "ic_hui"), forState: .Normal)
            actionButtonRHua.setImage(UIImage(named: "ic_hui"), forState: .Normal)
            singButtonRHua.setImage(UIImage(named: "ic_hui"), forState: .Normal)
            laborButtonRHua.setImage(UIImage(named: "ic_hui"), forState: .Normal)
            skillButtonRHua.setImage(UIImage(named: "ic_hui"), forState: .Normal)
            relationButtonRHua.setImage(UIImage(named: "ic_hui"), forState: .Normal)
            
            studyButtonGHua.setImage(UIImage(named: "ic_hui"), forState: .Normal)
            actionButtonGHua.setImage(UIImage(named: "ic_hui"), forState: .Normal)
            singButtonGHua.setImage(UIImage(named: "ic_hui"), forState: .Normal)
            laborButtonGHua.setImage(UIImage(named: "ic_hui"), forState: .Normal)
            skillButtonGHua.setImage(UIImage(named: "ic_hui"), forState: .Normal)
            relationButtonGHua.setImage(UIImage(named: "ic_hui"), forState: .Normal)
            
            studyButtonZan.setImage(UIImage(named: "ic_hui"), forState: .Normal)
            actionButtonZan.setImage(UIImage(named: "ic_hui"), forState: .Normal)
            singButtonZan.setImage(UIImage(named: "ic_hui"), forState: .Normal)
            laborButtonZan.setImage(UIImage(named: "ic_hui"), forState: .Normal)
            skillButtonZan.setImage(UIImage(named: "ic_hui"), forState: .Normal)
            relationButtonZan.setImage(UIImage(named: "ic_hui"), forState: .Normal)

            teacherLabel.text = info!.teacher_name
            //  活动时间
            let dateformate = NSDateFormatter()
            dateformate.dateFormat = "yyyy-MM-dd HH:mm"
            let date = NSDate(timeIntervalSince1970: NSTimeInterval(info!.comment_time!)!)
            let str:String = dateformate.stringFromDate(date)
            timeLable.text = str
            
            
            let pict = info!.teacher_photo
            let imgUrl = imageUrl + pict!
            let photourl = NSURL(string: imgUrl)
            headerImageView.yy_setImageWithURL(photourl, placeholder: UIImage(named: "默认头像"))
            
            
            if info!.learn == "1" {
                studyButtonRHua.setImage(UIImage(named: "ic_hong"), forState: .Normal)
            }else if info!.learn == "2"{
                studyButtonGHua.setImage(UIImage(named: "ic_ju"), forState: .Normal)
            }else if info!.learn == "3"{
                studyButtonZan.setImage(UIImage(named: "ic_huang"), forState: .Normal)
            }else{
                studyButtonZan.setImage(UIImage(named: "ic_hui"), forState: .Normal)
            }
            
            if info!.work == "1" {
                actionButtonRHua.setImage(UIImage(named: "ic_hong"), forState: .Normal)
            }else if info!.work == "2"{
                actionButtonGHua.setImage(UIImage(named: "ic_ju"), forState: .Normal)
            }else if info!.work == "3"{
                actionButtonZan.setImage(UIImage(named: "ic_huang"), forState: .Normal)
            }else{
                actionButtonZan.setImage(UIImage(named: "ic_hui"), forState: .Normal)
            }
            
            if info!.sing == "1" {
                singButtonRHua.setImage(UIImage(named: "ic_hong"), forState: .Normal)
            }else if info!.sing == "2"{
                singButtonGHua.setImage(UIImage(named: "ic_ju"), forState: .Normal)
            }else if info!.sing == "3"{
                singButtonZan.setImage(UIImage(named: "ic_huang"), forState: .Normal)
            }else{
                singButtonZan.setImage(UIImage(named: "ic_hui"), forState: .Normal)
            }
            
            if info!.labour == "1" {
                laborButtonRHua.setImage(UIImage(named: "ic_hong"), forState: .Normal)
            }else if info!.labour == "2"{
                laborButtonGHua.setImage(UIImage(named: "ic_ju"), forState: .Normal)
            }else if info!.labour == "3"{
                laborButtonZan.setImage(UIImage(named: "ic_huang"), forState: .Normal)
            }else{
                laborButtonZan.setImage(UIImage(named: "ic_hui"), forState: .Normal)
            }
            
            if info!.strain == "1" {
                skillButtonRHua.setImage(UIImage(named: "ic_hong"), forState: .Normal)
            }else if info!.strain == "2"{
                skillButtonGHua.setImage(UIImage(named: "ic_ju"), forState: .Normal)
            }else if info!.strain == "3"{
                skillButtonZan.setImage(UIImage(named: "ic_huang"), forState: .Normal)
            }else{
                skillButtonZan.setImage(UIImage(named: "ic_hui"), forState: .Normal)
            }
            
            if info!.comment_status == "1" {
                relationButtonRHua.setImage(UIImage(named: "ic_hong"), forState: .Normal)
            }else if info!.comment_status == "2"{
                relationButtonGHua.setImage(UIImage(named: "ic_ju"), forState: .Normal)
            }else if info!.comment_status == "3"{
                relationButtonZan.setImage(UIImage(named: "ic_huang"), forState: .Normal)
            }else{
                relationButtonZan.setImage(UIImage(named: "ic_hui"), forState: .Normal)
            }
            
            contentLable.text = info!.comment_content
        }
    }
    
    func showModel(info:TeacherCommentInfo){
        teacherLabel.text = info.teacher_name
        //  活动时间
        let dateformate = NSDateFormatter()
        dateformate.dateFormat = "yyyy-MM-dd HH:mm"
        let date = NSDate(timeIntervalSince1970: NSTimeInterval(info.comment_time!)!)
        let str:String = dateformate.stringFromDate(date)
        timeLable.text = str
        
        
        let pict = info.teacher_photo
        let imgUrl = microblogImageUrl + pict!
        let photourl = NSURL(string: imgUrl)
        headerImageView.yy_setImageWithURL(photourl, placeholder: UIImage(named: "1"))
        
        
        if info.learn == "1" {
            studyButtonRHua.setImage(UIImage(named: "ic_hong"), forState: .Normal)
        }else if info.learn == "2"{
            studyButtonGHua.setImage(UIImage(named: "ic_ju"), forState: .Normal)
        }else if info.learn == "3"{
            studyButtonZan.setImage(UIImage(named: "ic_huang"), forState: .Normal)
        }else{
            studyButtonZan.setImage(UIImage(named: "ic_hui"), forState: .Normal)
        }
        
        if info.work == "1" {
            actionButtonRHua.setImage(UIImage(named: "ic_hong"), forState: .Normal)
        }else if info.work == "2"{
            actionButtonGHua.setImage(UIImage(named: "ic_ju"), forState: .Normal)
        }else if info.work == "3"{
            actionButtonZan.setImage(UIImage(named: "ic_huang"), forState: .Normal)
        }else{
            actionButtonZan.setImage(UIImage(named: "ic_hui"), forState: .Normal)
        }
        
        if info.sing == "1" {
            singButtonRHua.setImage(UIImage(named: "ic_hong"), forState: .Normal)
        }else if info.sing == "2"{
            singButtonGHua.setImage(UIImage(named: "ic_ju"), forState: .Normal)
        }else if info.sing == "3"{
            singButtonZan.setImage(UIImage(named: "ic_huang"), forState: .Normal)
        }else{
            singButtonZan.setImage(UIImage(named: "ic_hui"), forState: .Normal)
        }
        
        if info.labour == "1" {
            laborButtonRHua.setImage(UIImage(named: "ic_hong"), forState: .Normal)
        }else if info.labour == "2"{
            laborButtonGHua.setImage(UIImage(named: "ic_ju"), forState: .Normal)
        }else if info.labour == "3"{
            laborButtonZan.setImage(UIImage(named: "ic_huang"), forState: .Normal)
        }else{
            laborButtonZan.setImage(UIImage(named: "ic_hui"), forState: .Normal)
        }
        
        if info.strain == "1" {
            skillButtonRHua.setImage(UIImage(named: "ic_hong"), forState: .Normal)
        }else if info.strain == "2"{
            skillButtonGHua.setImage(UIImage(named: "ic_ju"), forState: .Normal)
        }else if info.strain == "3"{
            skillButtonZan.setImage(UIImage(named: "ic_huang"), forState: .Normal)
        }else{
            skillButtonZan.setImage(UIImage(named: "ic_hui"), forState: .Normal)
        }
        
        if info.comment_status == "1" {
            relationButtonRHua.setImage(UIImage(named: "ic_hong"), forState: .Normal)
        }else if info.comment_status == "2"{
            relationButtonGHua.setImage(UIImage(named: "ic_ju"), forState: .Normal)
        }else if info.comment_status == "3"{
            relationButtonZan.setImage(UIImage(named: "ic_huang"), forState: .Normal)
        }else{
            relationButtonZan.setImage(UIImage(named: "ic_hui"), forState: .Normal)
        }
        
        contentLable.text = info.comment_content
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //  创建label
    func createLabel(frame:CGRect) -> UILabel{
        let label = UILabel()
        label.frame = frame
        return label
        
    }
//    //  创建button
//    func createButton(frame:CGRect,image_nor:String,image_press:String) -> UIButton{
//        let button = UIButton()
//        button.frame = frame
//        button.setImage(UIImage.init(named: image_nor), forState: .Normal)
//        button.setImage(UIImage.init(named: image_press), forState: .Selected)
//        button.addTarget(self, action: #selector(selectedAction(_:)), forControlEvents: .TouchUpInside)
//        return button
//    }
//    func selectedAction(sender:UIButton){
//        if sender.selected == true {
//            sender.selected = false
//        }else{
//            sender.selected = true
//        }
//    }
    

    

    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
