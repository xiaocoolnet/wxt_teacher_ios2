
//
//  KeChengList.swift
//  WXT_Teacher
//
//  Created by apple on 16/4/8.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import Foundation

class KeChengList: JSONJoy {
    var objectlist: [KeChengInfo]
    var count: Int{
        return self.objectlist.count
    }
    
    init(){
        objectlist = Array<KeChengInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        //        status = decoder["status"].string
        objectlist = Array<KeChengInfo>()
        for childs: JSONDecoder in decoder.array!{
            objectlist.append(KeChengInfo(childs))
        }
    }
    
    func append(list: [KeChengInfo]){
        self.objectlist = list + self.objectlist
    }
}
class KeChengInfo: JSONJoy{
    var syllabus_id : String?
    var schoolid : String?
    var classid : String?
    var  monday : String?
    var tuesday : String?
    var wednesday : String?
    var  thursday : String?
    var friday : String?
    var saturday : String?
    var sunday : String?
  
    var syllabus_no:String?
    
    init() {
        
    }
    required init(_ decoder: JSONDecoder){
        syllabus_id=decoder["syllabus_id"].string
        schoolid=decoder["schoolid"].string
        classid=decoder["classid"].string
        monday=decoder["monday"].string
        tuesday=decoder["tuesday"].string
        wednesday=decoder["wednesday"].string
        thursday=decoder["thursday"].string
        friday=decoder["friday"].string
        saturday=decoder["saturday"].string
        sunday=decoder["sunday"].string
  
        syllabus_no = decoder["syllabus_no"].string
        
    }
    
}
