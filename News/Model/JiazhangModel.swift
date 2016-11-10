//
//  JiazhangModel.swift
//  WXT_Teacher
//
//  Created by xiaocool on 16/10/21.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import Foundation
class JiazhangModel: JSONJoy {
    var objectlist: [JiazhangInfo]
    var count: Int{
        return self.objectlist.count
    }
    
    init(){
        objectlist = Array<JiazhangInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        //        status = decoder["status"].string
        objectlist = Array<JiazhangInfo>()
        for childs: JSONDecoder in decoder.array!{
            objectlist.append(JiazhangInfo(childs))
        }
    }
    
    func append(list: [JiazhangInfo]){
        self.objectlist = list + self.objectlist
    }
    
}
class JiazhangInfo: JSONJoy{

    var student_list: [jzInfo]
    var classname:String?
    
    var count: Int{
        return self.student_list.count
    }
    
    init() {
        student_list = Array<jzInfo>()
    }
    
    required init(_ decoder: JSONDecoder){
        classname = decoder["classname"].string
        student_list = Array<jzInfo>()
        for teacher: JSONDecoder in decoder["student_list"].array!{
            
            student_list.append(jzInfo(teacher))
            
        }
    }
    func append(list: [jzInfo]){
        self.student_list = list + self.student_list
    }
    
}
class jzInfo: JSONJoy{
    var name:String?
    var id: String?
    var parent_list : [jzphoneInfo]
    
    init() {
        parent_list = Array<jzphoneInfo>()
    }
    required init(_ decoder: JSONDecoder){
        name = decoder["name"].string
        id = decoder["id"].string
         parent_list = Array<jzphoneInfo>()
        for teacher: JSONDecoder in decoder["parent_list"].array!{
            
            parent_list.append(jzphoneInfo(teacher))
            
        }

    }
    func append(list: [jzphoneInfo]){
        self.parent_list = list + self.parent_list
    }
}
class jzphoneInfo: JSONJoy{
    var name:String?
    var phone: String?
    var appellation : String?
    
    
    init() {
        
    }
    required init(_ decoder: JSONDecoder){
        name = decoder["name"].string
        phone = decoder["phone"].string
        appellation=decoder["appellation"].string
    }
    
}