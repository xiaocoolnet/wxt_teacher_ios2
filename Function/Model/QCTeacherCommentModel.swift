//
//  QCTeacherCommentModel.swift
//  WXT_Parents
//
//  Created by 沈晓龙 on 16/7/15.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import Foundation

class TeacherCommentModel: JSONJoy {
    var objectlist: [TeacherCommentInfo]
    var count: Int{
        return self.objectlist.count
    }
    
    init(){
        objectlist = Array<TeacherCommentInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        //        status = decoder["status"].string
        objectlist = Array<TeacherCommentInfo>()
        for childs: JSONDecoder in decoder.array!{
            objectlist.append(TeacherCommentInfo(childs))
        }
    }
    
    func append(list: [TeacherCommentInfo]){
        self.objectlist = list + self.objectlist
    }
}

class TeacherCommentInfo: JSONJoy{
    
    
    var comment_id:String?
    var teacher_id:String?
    var studentid:String?
    var comment_time:String?
    var comment_status:String?
    var learn:String?
    var work:String?
    var sing:String?
    var labour:String?
    var strain:String?
    var comment_content:String?
    var teacher_name:String?
    var teacher_photo:String?
    
    init() {
        
    }
    required init(_ decoder: JSONDecoder){
        
        
        comment_id = decoder["comment_id"].string
        teacher_id = decoder["teacher_id"].string
        studentid = decoder["studentid"].string
        comment_time = decoder["comment_time"].string
        comment_status = decoder["comment_status"].string
        learn = decoder["learn"].string
        work = decoder["work"].string
        sing = decoder["sing"].string
        labour = decoder["labour"].string
        strain = decoder["strain"].string
        comment_content = decoder["comment_content"].string
        teacher_name = decoder["teacher_name"].string
        teacher_photo = decoder["teacher_photo"].string
    }
    
}
