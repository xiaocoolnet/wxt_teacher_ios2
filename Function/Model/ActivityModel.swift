//
//  ActivityModel.swift
//  WXT_Parents
//
//  Created by 沈晓龙 on 16/7/27.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import Foundation

class ActModel: JSONJoy{
    var status:String?
    var data: JSONDecoder?
    var array : Array<JSONDecoder>?
    var errorData:String?
    init(){
    }
    required init(_ decoder:JSONDecoder){
        
        status = decoder["status"].string
        if status == "success" {
            data = decoder["data"]
        }
        else{
            errorData = decoder["data"].string
        }
    }
}

class ActList: JSONJoy {
    var status:String?
    var objectlist: [ActInfo]
    
    var count: Int{
        return self.objectlist.count
    }
    init(){
        objectlist = Array<ActInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        
        objectlist = Array<ActInfo>()
        for childs: JSONDecoder in decoder.array!{
            objectlist.append(ActInfo(childs))
        }
    }
    
    func append(list: [ActInfo]){
        self.objectlist = list + self.objectlist
    }
    
}

class ActInfo: JSONJoy{
    var activity_id:String?
    var id:String?
    var receiverid:String?
    var read_time:String?
    var activity_list = Array<act_listInfo>()
//    var pic = Array<ActPicInfo>()
//    var apply_count = Array<app_countInfo>()
    
    
    required init(_ decoder: JSONDecoder){
        activity_id = decoder["activity_id"].string
        id = decoder["id"].string
        read_time = decoder["read_time"].string
        receiverid = decoder["receiverid"].string
        if decoder["activity_list"].array != nil {
            for childs: JSONDecoder in decoder["activity_list"].array!{
                self.activity_list.append(act_listInfo(childs))
            }
        }
//        if decoder["pic"].array != nil {
//            for childs: JSONDecoder in decoder["pic"].array!{
//                self.pic.append(ActPicInfo(childs))
//            }
//        }
//        if decoder["apply_count"].array != nil {
//            for childs: JSONDecoder in decoder["apply_count"].array!{
//                self.apply_count.append(app_countInfo(childs))
//            }
//        }

    }
    func addpend(list: [act_listInfo]){
        self.activity_list = list + self.activity_list
    }
//    func addpend(list: [ActPicInfo]){
//        self.pic = list + self.pic
//    }
//    func addpend(list: [app_countInfo]){
//        self.apply_count = list + self.apply_count
//    }
    
}

class act_listList: JSONJoy {
    var status:String?
    var objectlist: [act_listInfo]
    
    var count: Int{
        return self.objectlist.count
    }
    init(){
        objectlist = Array<act_listInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        
        objectlist = Array<act_listInfo>()
        for childs: JSONDecoder in decoder.array!{
            objectlist.append(act_listInfo(childs))
        }
    }
    
    func append(list: [act_listInfo]){
        self.objectlist = list + self.objectlist
    }
}

class act_listInfo: JSONJoy {
    
    var content:String?
    var create_time:String?
    var id:String?
    var name:String?
    var photo:String?
    var subject:String?
    var title:String?
    var userid:String?
    
    
    init() {
        
    }
    required init(_ decoder: JSONDecoder){
        content = decoder["content"].string
        id = decoder["id"].string
        create_time = decoder["create_time"].string
        subject = decoder["subject"].string
        name = decoder["name"].string
        photo = decoder["photo"].string
        title = decoder["title"].string
        userid = decoder["userid"].string
        
    }
    
}


//class PiList: JSONJoy {
//    var status:String?
//    var objectlist: [PiInfo]
//    
//    var count: Int{
//        return self.objectlist.count
//    }
//    init(){
//        objectlist = Array<PiInfo>()
//    }
//    required init(_ decoder: JSONDecoder) {
//        
//        objectlist = Array<PiInfo>()
//        for childs: JSONDecoder in decoder.array!{
//            objectlist.append(PiInfo(childs))
//        }
//    }
//    
//    func append(list: [PiInfo]){
//        self.objectlist = list + self.objectlist
//    }
//}
//
//class PiInfo: JSONJoy {
//    
//    var picture_url:String
//    
//    
//    //    init() {
//    //
//    //    }
//    required init(_ decoder: JSONDecoder){
//        picture_url = decoder["picture_url"].string ?? ""
//        
//    }
//    
//}