//
//  ReciveAnnounceModel.swift
//  WXT_Teacher
//
//  Created by xiaocool on 16/8/14.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import Foundation
class ReciveAnnounceModel: JSONJoy {
    var activityList: [ReciveAnnounceInfo]
    var count: Int{
        return self.activityList.count
    }
    
    init(){
        activityList = Array<ReciveAnnounceInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        
        activityList = Array<ReciveAnnounceInfo>()
        for childs: JSONDecoder in decoder.array!{
            activityList.append(ReciveAnnounceInfo(childs))
        }
    }
    
    func append(list: [ReciveAnnounceInfo]){
        self.activityList = list + self.activityList
    }
}


class ReciveNoticeList: JSONJoy {
    var status:String?
    var objectlist: [ReciveAnnounceInfo]
    
    var count: Int{
        return self.objectlist.count
    }
    init(){
        objectlist = Array<ReciveAnnounceInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        
        objectlist = Array<ReciveAnnounceInfo>()
        for childs: JSONDecoder in decoder.array!{
            objectlist.append(ReciveAnnounceInfo(childs))
        }
    }
    
    func append(list: [ReciveAnnounceInfo]){
        self.objectlist = list + self.objectlist
    }
    
}
class ReciveAnnounceInfo: JSONJoy{
    
    var content:String?
    var create_time:String?
    var id:String?
    
    var userid:String?
    var username:String?
    var title:String?
    var type : String?
    var avatar : String?
    var pic = Array<RApiclistInfo>()
    var reciver_list = Array<RecivelistInfo>()
    
    
    
    var dianzanlist:JSONDecoder?
    var comment:JSONDecoder?
    
    init() {
        pic=Array<RApiclistInfo>()
        reciver_list = Array<RecivelistInfo>()
    }
    required init(_ decoder: JSONDecoder){
        
        content = decoder["notice_info"].array?.first?["content"].string ?? ""
        create_time = decoder["notice_info"].array?.first?["create_time"].string ?? ""
        id = decoder["noticeid"].string ?? ""
        avatar = decoder["notice_info"].array?.first?["photo"].string ?? ""
        userid = decoder["receiverid"].string ?? ""
        username = decoder["notice_info"].array?.first?["name"].string ?? ""
        title = decoder["notice_info"].array?.first?["title"].string ?? ""
        pic=Array<RApiclistInfo>()
        if decoder["pic"].array != nil{
            for childs: JSONDecoder in decoder["pic"].array!{
                pic.append(RApiclistInfo(childs))
            }}
        reciver_list = Array<RecivelistInfo>()
        if decoder["receiv_list"].array != nil{
            for childs: JSONDecoder in decoder["receiv_list"].array!{
                reciver_list.append(RecivelistInfo(childs))
            }
        }
        
    }}
class RApiclistInfo: JSONJoy{
    var id:String?
    var pictureurl:String?
    var create_time : String?
    init() {
    }
    required init(_ decoder: JSONDecoder){
        pictureurl = decoder["photo"].string ?? ""
        
        
        
    }}
class RecivelistInfo: JSONJoy{
    var id:String?
    var create_time : String?
    init() {
    }
    required init(_ decoder: JSONDecoder){
        create_time = decoder["create_time"].string ?? ""
        
        
    }}