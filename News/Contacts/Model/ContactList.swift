//
//  ContactList.swift
//  WXT_Teacher
//
//  Created by apple on 16/4/7.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import Foundation


class ContactList: JSONJoy {
    var objectlist: [ContactsInfo]
    var count: Int{
        return self.objectlist.count
    }
    
    init(){
        objectlist = Array<ContactsInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        //        status = decoder["status"].string
        objectlist = Array<ContactsInfo>()
        for childs: JSONDecoder in decoder.array!{
            objectlist.append(ContactsInfo(childs))
        }
    }
    
    func append(list: [ContactsInfo]){
        self.objectlist = list + self.objectlist
    }
    
}
class ContactsInfo: JSONJoy{
    var classname:String?
    var teacherlist: [TeacherInfo]
    var schoolname:String?
    var schoolid:String?
    var classid:String?
    
    var count: Int{
        return self.teacherlist.count
    }
    
    init() {
        teacherlist = Array<TeacherInfo>()
    }
    
    required init(_ decoder: JSONDecoder){
        classname = decoder["classname"].string
        schoolname = decoder["schoolname"].string
        schoolid = decoder["schoolid"].string
        classid = decoder["classid"].string
        teacherlist = Array<TeacherInfo>()
        for teacher: JSONDecoder in decoder["teacherinfo"].array!{
            
                teacherlist.append(TeacherInfo(teacher))
            
        }
    }
    func append(list: [TeacherInfo]){
        self.teacherlist = list + self.teacherlist
    }
    
}
class TeacherInfo: JSONJoy{
    var name:String?
    var id: String?
    var phone: String?
    init() {
        
    }
    required init(_ decoder: JSONDecoder){
        name = decoder["name"].string
        id = decoder["id"].string
        phone = decoder["phone"].string
    }
    
}