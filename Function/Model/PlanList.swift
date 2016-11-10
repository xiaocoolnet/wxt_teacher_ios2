//
//  PlanList.swift
//  WXT_Teacher
//
//  Created by xiaocool on 16/4/10.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import Foundation

class PlanList: JSONJoy {
    var objectlist: [planInfo]
    var count: Int{
        return self.objectlist.count
    }
    
    init(){
        objectlist = Array<planInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        //        status = decoder["status"].string
        objectlist = Array<planInfo>()
        for childs: JSONDecoder in decoder.array!{
            objectlist.append(planInfo(childs))
        }
    }
    
    func append(list: [planInfo]){
        self.objectlist = list + self.objectlist
    }
}
class planInfo: JSONJoy{
    
//    "id": "1",
//    "schoolid": "1",
//    "classid": "1",
//    "userid": "605",
//    "type": "1",
//    "title": "这周的计划",
//    "monday": "完成1",
//    "tuesday": "瓦城2",
//    "wednesday": "完成三",
//    "thursday": "哇查查给你四",
//    "friday": "",
//    "saturday": "",
//    "sunday": "",
//    "workpoint": "完成微校通",
//    "begintime": "1470724463",
//    "endtime": "1470811334",
//    "school_phone": "12345681901",
//    "create_time": "1458376723",
//    "school_status": "2",
//    "classname": "小一班"
    var id:String?
    var schoolid: String?
    var classid:String?
    var userid:String?
    var type:String?
    var title: String?
    var monday:String?
    var tuesday:String?
    var wednesday:String?
    var thursday: String?
    var friday:String?
    var saturday:String?
    var sunday:String?
    var workpoint:String?
    var begintime: String?
    var endtime:String?
    var school_phone:String?
    var create_time:String?
    var school_status: String?
    var classname:String?
   
    
    init() {
        
    }
    required init(_ decoder: JSONDecoder){
        id = decoder["id"].string
        schoolid = decoder["schoolid"].string
        classid = decoder["classid"].string
        userid = decoder["userid"].string
        type = decoder["type"].string
        title = decoder["title"].string
        monday = decoder["monday"].string
        tuesday = decoder["tuesday"].string
        wednesday = decoder["wednesday"].string
        thursday = decoder["thursday"].string
        friday = decoder["friday"].string
        saturday = decoder["saturday"].string
        sunday = decoder["sunday"].string
        workpoint = decoder["workpoint"].string
        begintime = decoder["begintime"].string
        endtime = decoder["endtime"].string
        school_phone = decoder["school_phone"].string
        create_time = decoder["create_time"].string
        classname = decoder["classname"].string
        
    }
    
}
