//
//  ChooseUser.swift
//  WXT_Teacher
//
//  Created by qiang on 16/8/17.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import Foundation


class ChooseUserList: JSONJoy {
    var status:String?
    var objectlist: [ChooseUser]
    
    var count: Int{
        return self.objectlist.count
    }
    init(){
        objectlist = Array<ChooseUser>()
    }
    required init(_ decoder: JSONDecoder) {
        
        objectlist = Array<ChooseUser>()
        for childs: JSONDecoder in decoder.array!{
            objectlist.append(ChooseUser(childs))
        }
    }
    
    func append(list: [ChooseUser]){
        self.objectlist = list + self.objectlist
    }
    
}

class ChooseUser: JSONJoy{
    var classid:String?
    var classname:String?
    var studentlist = Array<StudentInfo>()
    var isSelected = false
    var isOpen = false
    
    
    
    required init(_ decoder: JSONDecoder){
        classid = decoder["classid"].string
        classname = decoder["classname"].string
        if decoder["studentlist"].array != nil {
            for childs: JSONDecoder in decoder["studentlist"].array!{
                self.studentlist.append(StudentInfo(childs))
            }
        }
       
        
    }
    
}

class StudentInfoList: JSONJoy {
    var status:String?
    var objectlist: [StudentInfo]
    
    var count: Int{
        return self.objectlist.count
    }
    init(){
        objectlist = Array<StudentInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        
        objectlist = Array<StudentInfo>()
        for childs: JSONDecoder in decoder.array!{
            objectlist.append(StudentInfo(childs))
        }
    }
    
    func append(list: [StudentInfo]){
        self.objectlist = list + self.objectlist
    }
}

class StudentInfo: JSONJoy {
    
    var id:String
    var name:String
    var sex:String
    var phone:String
    var photo:String
    var isChecked = false
    
    
    required init(_ decoder: JSONDecoder){
        id = decoder["id"].string ?? ""
        name = decoder["name"].string ?? ""
        sex = decoder["sex"].string ?? ""
        phone = decoder["phone"].string ?? ""
        photo = decoder["photo"].string ?? ""
    }
    
}





