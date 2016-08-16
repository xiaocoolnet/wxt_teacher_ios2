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
    var activity_id:String?
    var id:String?
    var read_time:String?
    var receiverid:String?

    
    var activity_list:JSONDecoder?
    var apply_count:JSONDecoder?
    var pic:JSONDecoder?
    
    init() {
        
    }
    required init(_ decoder: JSONDecoder){
        activity_id = decoder["activity_id"].string
        id = decoder["id"].string
        read_time = decoder["read_time"].string
        receiverid = decoder["receiverid"].string

        
        activity_list = decoder["activity_list"]
        apply_count = decoder["apply_count"]
        pic = decoder["pic"]
    }
    
}


/*
 
    activity_list = decoder["activity_list"]

 */
class activity_listList: JSONJoy {
    var activityList: [activity_listInfo]
    var count: Int{
        return self.activityList.count
    }
    
    init(){
        activityList = Array<activity_listInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        
        activityList = Array<activity_listInfo>()
        for childs: JSONDecoder in decoder.array!{
            activityList.append(activity_listInfo(childs))
        }
    }
    
    func append(list: [activity_listInfo]){
        self.activityList = list + self.activityList
    }
}

class activity_listInfo: JSONJoy{
    var begintime:String?
    var classid:String?
    var contactman:String?
    var contactphone:String?
    
    var content:String?
    var create_time:String?
    var endtime:String?
    var finishtime:String?
    
    var id:String?
    var isapply:String?
    var starttime:String?
    var title:String?
    var userid:String?
    
    var user_info:JSONDecoder?
    
    init() {
        
    }
    required init(_ decoder: JSONDecoder){
        
        begintime = decoder["begintime"].string
        classid = decoder["classid"].string
        contactman = decoder["contactman"].string
        contactphone = decoder["contactphone"].string
        content = decoder["content"].string
        create_time = decoder["create_time"].string
        endtime = decoder["endtime"].string
        
        finishtime = decoder["finishtime"].string
        id = decoder["id"].string
        isapply = decoder["isapply"].string
        starttime = decoder["starttime"].string
        title = decoder["title"].string
        userid = decoder["userid"].string
        
        user_info = decoder["user_info"]
        
    
    }
    
}

/*
 
    apply_count = decoder["apply_count"]
 
 */
class apply_countList: JSONJoy {
    var activityList: [apply_countInfo]
    var count: Int{
        return self.activityList.count
    }
    
    init(){
        activityList = Array<apply_countInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        
        activityList = Array<apply_countInfo>()
        for childs: JSONDecoder in decoder.array!{
            activityList.append(apply_countInfo(childs))
        }
    }
    
    func append(list: [apply_countInfo]){
        self.activityList = list + self.activityList
    }
}

class apply_countInfo: JSONJoy{
    var userid:String?

    
    init() {
        
    }
    required init(_ decoder: JSONDecoder){
        userid = decoder["userid"].string

    }
    
}

/*
 
    pic = decoder["pic"]
 
 */

class picList: JSONJoy {
    var activityList: [picInfo]
    var count: Int{
        return self.activityList.count
    }
    
    init(){
        activityList = Array<picInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        
        activityList = Array<picInfo>()
        for childs: JSONDecoder in decoder.array!{
            activityList.append(picInfo(childs))
        }
    }
    
    func append(list: [picInfo]){
        self.activityList = list + self.activityList
    }
}

class picInfo: JSONJoy{
    var picture_url:String?

    
    init() {
        
    }
    required init(_ decoder: JSONDecoder){
        picture_url = decoder["picture_url"].string

    }
}
/*
 
 user_info = decoder["user_info"]
 
 */

class user_List: JSONJoy {
    var activityList: [user_Info]
    var count: Int{
        return self.activityList.count
    }
    
    init(){
        activityList = Array<user_Info>()
    }
    required init(_ decoder: JSONDecoder) {
        
        activityList = Array<user_Info>()
        for childs: JSONDecoder in decoder.array!{
            activityList.append(user_Info(childs))
        }
    }
    
    func append(list: [user_Info]){
        self.activityList = list + self.activityList
    }
}

class user_Info: JSONJoy{
    var name:String?
    var photo:String?
    
    init() {
        
    }
    required init(_ decoder: JSONDecoder){
        name = decoder["name"].string
        photo = decoder["photo"].string
        
    }
}

