//
//  ChooseTeacherModel.swift
//  WXT_Teacher
//
//  Created by xiaocool on 16/8/29.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import Foundation
class ChooseTeacherModel: JSONJoy {
    var status:String?
    var objectlist: [ChooseTeacherInfo]
    
    var count: Int{
        return self.objectlist.count
    }
    init(){
        objectlist = Array<ChooseTeacherInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        
        objectlist = Array<ChooseTeacherInfo>()
        for childs: JSONDecoder in decoder.array!{
            objectlist.append(ChooseTeacherInfo(childs))
        }
    }
    
    func append(list: [ChooseTeacherInfo]){
        self.objectlist = list + self.objectlist
    }
    
}

class ChooseTeacherInfo: JSONJoy{
    var id:String?
    var photo:String?
    var name : String?
    var phone : String?
    
    var isSelected = false
    
    
    
    
    required init(_ decoder: JSONDecoder){
        id = decoder["id"].string ?? ""
        phone = decoder["phone"].string ?? ""
        name=decoder["name"].string ?? ""
        phone=decoder["phone"].string ?? ""
        
        
        
        
    }
    
}


