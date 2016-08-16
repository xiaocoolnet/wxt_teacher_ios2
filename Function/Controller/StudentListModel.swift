//
//  StudentListModel.swift
//  WXT_Teacher
//
//  Created by xiaocool on 16/8/9.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import Foundation
class StudentListModel: JSONJoy {
    var objectlist: [StudentListInfo]
    var count: Int{
        return self.objectlist.count
    }
    
    init(){
        objectlist = Array<StudentListInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        //        status = decoder["status"].string
        objectlist = Array<StudentListInfo>()
        for childs: JSONDecoder in decoder.array!{
            objectlist.append(StudentListInfo(childs))
        }
    }
    
    func append(list: [StudentListInfo]){
        self.objectlist = list + self.objectlist
    }
    
}
class StudentListInfo: JSONJoy{
    var classname:String?
    var studentlist: [ParentsInfo]

    var classid:String?
    
    var count: Int{
        return self.studentlist.count
    }
    
    init() {
        studentlist = Array<ParentsInfo>()
    }
    
    required init(_ decoder: JSONDecoder){
        classname = decoder["classname"].string
        classid = decoder["classid"].string
        studentlist = Array<ParentsInfo>()
        for teacher: JSONDecoder in decoder["studentlist"].array!{
            
            studentlist.append(ParentsInfo(teacher))
            
        }
    }
    func append(list: [ParentsInfo]){
        self.studentlist = list + self.studentlist
    }
    
}
class ParentsInfo: JSONJoy{
    var name:String?
    var id: String?
    var phone: String?
    var photo : String?
    var sex : String?
    init() {
        
    }
    required init(_ decoder: JSONDecoder){
        name = decoder["name"].string
        id = decoder["id"].string
        phone = decoder["phone"].string
        photo=decoder["photo"].string
        sex=decoder["sex"].string
        
    }
    
}