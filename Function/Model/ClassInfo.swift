//
//  ClassInfo.swift
//  WXT_Teacher
//
//  Created by qiang on 16/8/30.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import Foundation

class ClassInfoList: JSONJoy {
    var status:String?
    var objectlist: [ClassInfo]
    
    var count: Int{
        return self.objectlist.count
    }
    init(){
        objectlist = Array<ClassInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        
        objectlist = Array<ClassInfo>()
        for childs: JSONDecoder in decoder.array!{
            objectlist.append(ClassInfo(childs))
        }
    }
    
    func append(list: [ClassInfo]){
        self.objectlist = list + self.objectlist
    }

}


class ClassInfo: JSONJoy{
    
    
    var classid:String?
    var classname:String?
    
    required init(_ decoder: JSONDecoder){
        classid = decoder["classid"].string
        classname = decoder["classname"].string
       
    
        
    }
    
}
