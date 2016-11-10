//
//  DianPingList.swift
//  WXT_Teacher
//
//  Created by apple on 16/4/7.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import Foundation


class DianPingList: JSONJoy {
    var objectlist: [DianPingInfo]
    var count: Int{
        return self.objectlist.count
    }
    
    init(){
        objectlist = Array<DianPingInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        //        status = decoder["status"].string
        objectlist = Array<DianPingInfo>()
        for childs: JSONDecoder in decoder.array!{
            objectlist.append(DianPingInfo(childs))
        }
    }
    
    func append(list: [DianPingInfo]){
        self.objectlist = list + self.objectlist
    }
}
class DianPingInfo: JSONJoy{
    var classid:String?
    var classname: String?
    var studentlist = Array<StudentList>()
    init() {
        
    }
    required init(_ decoder: JSONDecoder){
        classid = decoder["classid"].string
        classname = decoder["classname"].string
        if decoder["studentlist"].array != nil {
            for childs: JSONDecoder in decoder["studentlist"].array!{
                self.studentlist.append(StudentList(childs))
            }
        }
    }
    
}

class StudentList: JSONJoy {
    var id:String?
    var name: String?
    var sex:String?
    var phone: String?

    var photo:String?
 

    var comments = Array<Comments>()
    init() {
        
    }
    required init(_ decoder: JSONDecoder){
        id = decoder["id"].string
        name = decoder["name"].string
        sex = decoder["sex"].string
        name = decoder["name"].string
        phone = decoder["phone"].string
        photo = decoder["photo"].string
        if decoder["comments"].array != nil {
            for childs: JSONDecoder in decoder["comments"].array!{
                self.comments.append(Comments(childs))
            }
        }
    }
    
}

class Comments: JSONJoy {
    var studentid:String?
    var comment_time: String?
    var comment_status:String?
    var learn: String?
    var work:String?
    var sing: String?
    var labour:String?
    var strain:String?
    var comment_content:String?
   
    init() {
        
    }
    required init(_ decoder: JSONDecoder){
        studentid = decoder["studentid"].string
        comment_time = decoder["comment_time"].string
        comment_status = decoder["comment_status"].string
        learn = decoder["learn"].string
        work = decoder["work"].string
        sing = decoder["sing"].string

        labour = decoder["labour"].string
        strain = decoder["strain"].string
        comment_content = decoder["comment_content"].string

    }
}