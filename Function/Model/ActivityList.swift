//
//  ActivityList.swift
//  WXT_Parents
//
//  Created by zhang on 16/5/30.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import Foundation

class ActivityList: JSONJoy {
    var activityList: [ActivityInfo]
    var count: Int{
        return self.activityList.count
    }
    
    init(){
        activityList = Array<ActivityInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        
        activityList = Array<ActivityInfo>()
        for childs: JSONDecoder in decoder.array!{
            activityList.append(ActivityInfo(childs))
        }
    }
    
    func append(list: [ActivityInfo]){
        self.activityList = list + self.activityList
    }
}

class ActivityInfo: JSONJoy{

    var id:String?
    var userid:String?
    var classid:String?
    var title:String?
    var content:String?
    var contactman:String?
    
    var contactphone:String?
    var begintime:String?
    var endtime:String?
    var starttime:String?
    var finishtime:String?
    var isapply:String?
    
    var create_time:String?
    var username:String?
    var readcount:String?
    var allreader:String?
    var readtag:String?
    
    
    var receiverlist = Array<ReciverList>()
    
    var teacher_name:String?
    var teacher_photo:String?
    var pic = Array<PiclistInfo>()
    var applylist = Array<ApplyListInfo>()
   
    init() {
        
    }
    required init(_ decoder: JSONDecoder){
        id = decoder["id"].string
        userid = decoder["userid"].string
        classid = decoder["classid"].string
        title = decoder["title"].string

        
        content = decoder["content"].string
        contactman = decoder["contactman"].string
        contactphone = decoder["contactphone"].string
        begintime = decoder["begintime"].string
        
        endtime = decoder["endtime"].string
        starttime = decoder["starttime"].string
        finishtime = decoder["finishtime"].string
        isapply = decoder["isapply"].string
        
        create_time = decoder["create_time"].string
        username = decoder["username"].string
        readcount = decoder["readcount"].string
        allreader = decoder["allreader"].string
        
        readtag = decoder["readtag"].string
        id = decoder["id"].string
        teacher_name = decoder["teacher_info"]["name"].string
        teacher_photo = decoder["teacher_info"]["photo"].string
        if decoder["receiverlist"].array != nil {
            for childs: JSONDecoder in decoder["receiverlist"].array!{
                self.receiverlist.append(ReciverList(childs))
            }
        }
        if decoder["applylist"].array != nil {
            for childs: JSONDecoder in decoder["applylist"].array!{
                self.applylist.append(ApplyListInfo(childs))
            }
        }

        if decoder["pic"].array != nil {
            for childs: JSONDecoder in decoder["pic"].array!{
                self.pic.append(PiclistInfo(childs))
            }
        }
    }
    
}


class ReciverList: JSONJoy {
    
    var id:String
    var activity_id:String
    var receiverid:String
    var read_time:String
    var name:String
    var photo:String
    var phone:String
  
    
    
    required init(_ decoder: JSONDecoder){
        id = decoder["id"].string ?? ""
        activity_id = decoder["activity_id"].string ?? ""
        receiverid = decoder["receiverid"].string ?? ""
        read_time = decoder["read_time"].string ?? ""
        if decoder["receiver_info"].array?.count>0 {
            name = decoder["receiver_info"].array![0]["name"].string!
            photo = decoder["receiver_info"].array![0]["photo"].string!
            phone = decoder["receiver_info"].array![0]["phone"].string!
        }else{
        
            name = ""
            photo = ""
            phone = ""
        
        }
       
        
    }
    
}


class ApplyListInfo: JSONJoy {
    
    var userid:String
    var avatar:String
    var name:String
    var applyid:String
    var fathername:String
    var contactphone:String
    var age:String
    var sex:String
    var create_time:String
    
    required init(_ decoder: JSONDecoder){
        userid = decoder["userid"].string ?? ""
        avatar = decoder["avatar"].string ?? ""
        name = decoder["name"].string ?? ""
        applyid = decoder["applyid"].string ?? ""
        fathername = decoder["fathername"].string ?? ""
        contactphone = decoder["contactphone"].string ?? ""
        age = decoder["age"].string ?? ""
        sex = decoder["sex"].string ?? ""
         create_time = decoder["create_time"].string ?? ""
    }
    
}
