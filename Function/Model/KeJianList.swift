//
//  KeJianList.swift
//  WXT_Teacher
//
//  Created by apple on 16/4/7.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import Foundation


class KeJianList: JSONJoy {
    var objectlist: [KeMuInfo]
    var count: Int{
        return self.objectlist.count
    }
    
    init(){
        objectlist = Array<KeMuInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        //        status = decoder["status"].string
        objectlist = Array<KeMuInfo>()
        for childs: JSONDecoder in decoder.array!{
            objectlist.append(KeMuInfo(childs))
        }
    }
    
    func append(list: [KeMuInfo]){
        self.objectlist = list + self.objectlist
    }
}

class KeMuInfo: JSONJoy{
    var id:String?
    var subject: String?
  
    var courseware_info = Array<KeJianInfo>()
    init() {
        
    }
    required init(_ decoder: JSONDecoder){
        id = decoder["id"].string
        subject = decoder["subject"].string
        if decoder["courseware_info"].array != nil {
            for childs: JSONDecoder in decoder["courseware_info"].array!{
                self.courseware_info.append(KeJianInfo(childs))
            }
        }
        
    }
    
}
class KeJianInfo: JSONJoy{
    var courseware_id:String?
    var schoolid: String?
    var classid:String?
    var user_id:String?

    var subjectid:String?
    var courseware_title: String?
    var courseware_content:String?
    var courseware_url:String?
    
    var courseware_time:String?
    var courseware_status: String?
    var teacher_name:String?
    var teacher_photo:String?
    
    var teacher_duty:String?
    var pic = Array<KeJianPicInfo>()
    init() {
        
    }
    required init(_ decoder: JSONDecoder){
        courseware_id = decoder["courseware_id"].string
        schoolid = decoder["schoolid"].string
        classid = decoder["classid"].string
        user_id = decoder["user_id"].string
        subjectid = decoder["subjectid"].string
        courseware_title = decoder["courseware_title"].string
        courseware_content = decoder["courseware_content"].string
        
        courseware_url = decoder["courseware_url"].string
        courseware_time = decoder["courseware_time"].string
        courseware_status = decoder["courseware_status"].string
        teacher_name = decoder["teacher_name"].string
        teacher_photo = decoder["teacher_photo"].string
        teacher_duty = decoder["teacher_duty"].string
        if decoder["pic"].array != nil {
            for childs: JSONDecoder in decoder["pic"].array!{
                self.pic.append(KeJianPicInfo(childs))
            }
        }
        

    }
    
}


class KeJianPicInfo: JSONJoy{
    var picture_url:String?
   
    init() {
        
    }
    required init(_ decoder: JSONDecoder){
        picture_url = decoder["picture_url"].string ?? ""
      
    }
        
   
}
    
