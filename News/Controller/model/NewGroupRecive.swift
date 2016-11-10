//
//  NewGroupRecive.swift
//  WXT_Teacher
//
//  Created by qiang on 16/8/17.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class NewGroupRecive: JSONJoy{
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
class NSendList: JSONJoy {
    var status:String?
    var objectlist: [NSendInfo]
    
    var count: Int{
        return self.objectlist.count
    }
    init(){
        objectlist = Array<NSendInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        
        objectlist = Array<NSendInfo>()
        for childs: JSONDecoder in decoder.array!{
            objectlist.append(NSendInfo(childs))
        }
    }
    
    func append(list: [NSendInfo]){
        self.objectlist = list + self.objectlist
    }
    
}

class NSendInfo: JSONJoy{
    var id:String?
    var send_user_id:String?
    var schoolid: String?
    var send_user_name:String?
    var message_content:String?
    var message_time:String?
    var receiver = Array<NSReciverInfo>()
    var picture = Array<NSendPicInfo>()
    
    
    
    required init(_ decoder: JSONDecoder){
        id = decoder["id"].string
        send_user_id = decoder["send_user_id"].string
        schoolid = decoder["schoolid"].string
        send_user_name = decoder["send_user_name"].string
        message_content = decoder["message_content"].string
        message_time = decoder["message_time"].string
        if decoder["receiver"].array != nil {
            for childs: JSONDecoder in decoder["receiver"].array!{
                self.receiver.append(NSReciverInfo(childs))
            }
        }
        if decoder["picture"].array != nil {
            for childs: JSONDecoder in decoder["picture"].array!{
                self.picture.append(NSendPicInfo(childs))
            }
        }

        }
    
}

class NSendReceiverList: JSONJoy {
    var status:String?
    var objectlist: [NSReciverInfo]
    
    var count: Int{
        return self.objectlist.count
    }
    init(){
        objectlist = Array<NSReciverInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        
        objectlist = Array<NSReciverInfo>()
        for childs: JSONDecoder in decoder.array!{
            objectlist.append(NSReciverInfo(childs))
        }
    }
    
    func append(list: [NSReciverInfo]){
        self.objectlist = list + self.objectlist
    }
}

class NSReciverInfo: JSONJoy {
    
    var photo:String
    var receiver_user_id:String
    var receiver_user_name:String
    var read_time:String
    var phone:String
    
    required init(_ decoder: JSONDecoder){
        photo = decoder["photo"].string ?? ""
        receiver_user_id = decoder["receiver_user_id"].string ?? ""
        receiver_user_name = decoder["receiver_user_name"].string ?? ""
        read_time = decoder["read_time"].string ?? ""
        phone = decoder["phone"].string ?? ""
    }
    
}


class NSendPicList: JSONJoy {
    var status:String?
    var objectlist: [NSendPicInfo]
    
    var count: Int{
        return self.objectlist.count
    }
    init(){
        objectlist = Array<NSendPicInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        
        objectlist = Array<NSendPicInfo>()
        for childs: JSONDecoder in decoder.array!{
            objectlist.append(NSendPicInfo(childs))
        }
    }
    
    func append(list: [NSendPicInfo]){
        self.objectlist = list + self.objectlist
    }
}

class NSendPicInfo: JSONJoy {
    
    var picture_url:String
    
    required init(_ decoder: JSONDecoder){
        picture_url = decoder["picture_url"].string ?? ""
        
    }
    
}



