//
//  FSendMessageModel.swift
//  WXT_Parents
//
//  Created by 沈晓龙 on 16/7/26.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import Foundation

class FSendModel: JSONJoy{
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
class FSendList: JSONJoy {
    var status:String?
    var objectlist: [FSendInfo]
    
    var count: Int{
        return self.objectlist.count
    }
    init(){
        objectlist = Array<FSendInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        
        objectlist = Array<FSendInfo>()
        for childs: JSONDecoder in decoder.array!{
            objectlist.append(FSendInfo(childs))
        }
    }
    
    func append(list: [FSendInfo]){
        self.objectlist = list + self.objectlist
    }
    
}

class FSendInfo: JSONJoy{
    var id:String?
    var message_id:String?
    var receiver_user_id: String?
    var receiver_user_name:String?
    var message_type:String?
    var read_time:String?
    var send_message = Array<send_messageInfo>()
    var picture = Array<FSendPicInfo>()
    var receiver = Array<FSendReceiverInfo>()
    
    
    
    required init(_ decoder: JSONDecoder){
        id = decoder["id"].string
        message_id = decoder["message_id"].string
        receiver_user_id = decoder["receiver_user_id"].string
        receiver_user_name = decoder["receiver_user_name"].string
        message_type = decoder["message_type"].string
        read_time = decoder["read_time"].string ?? ""
        if decoder["send_message"].array != nil {
            for childs: JSONDecoder in decoder["send_message"].array!{
                self.send_message.append(send_messageInfo(childs))
            }
        }
        if decoder["pic"].array != nil {
            for childs: JSONDecoder in decoder["pic"].array!{
                self.picture.append(FSendPicInfo(childs))
            }
        }
        if decoder["receiver"].array != nil {
            for childs: JSONDecoder in decoder["receiver"].array!{
                self.receiver.append(FSendReceiverInfo(childs))
            }
        }
    }
    func addpend(list: [send_messageInfo]){
        self.send_message = list + self.send_message
    }
    func addpend(list: [FSendPicInfo]){
        self.picture = list + self.picture
    }
    func addpend(list: [FSendReceiverInfo]){
        self.receiver = list + self.receiver
    }
    
}

class send_messageList: JSONJoy {
    var status:String?
    var objectlist: [send_messageInfo]
    
    var count: Int{
        return self.objectlist.count
    }
    init(){
        objectlist = Array<send_messageInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        
        objectlist = Array<send_messageInfo>()
        for childs: JSONDecoder in decoder.array!{
            objectlist.append(send_messageInfo(childs))
        }
    }
    
    func append(list: [send_messageInfo]){
        self.objectlist = list + self.objectlist
    }
}

class send_messageInfo: JSONJoy {

    var id:String?
    var schoolid:String?
    var send_user_id:String?
    var send_user_name:String?
    var message_content:String?
    var message_time:String?
    
    
    init() {
        
    }
    required init(_ decoder: JSONDecoder){
        id = decoder["id"].string
        schoolid = decoder["schoolid"].string
        send_user_id = decoder["send_user_id"].string
        send_user_name = decoder["send_user_name"].string
        message_content = decoder["message_content"].string
        message_time = decoder["message_time"].string ?? ""
        
    }
    
}


class FSendPicList: JSONJoy {
    var status:String?
    var objectlist: [FSendPicInfo]
    
    var count: Int{
        return self.objectlist.count
    }
    init(){
        objectlist = Array<FSendPicInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        
        objectlist = Array<FSendPicInfo>()
        for childs: JSONDecoder in decoder.array!{
            objectlist.append(FSendPicInfo(childs))
        }
    }
    
    func append(list: [FSendPicInfo]){
        self.objectlist = list + self.objectlist
    }
}

class FSendPicInfo: JSONJoy {
    
    var picture_url:String
    
    required init(_ decoder: JSONDecoder){
        picture_url = decoder["picture_url"].string ?? ""
        
    }
    
}


class FSendReceiverList: JSONJoy {
    var status:String?
    var objectlist: [FSendReceiverInfo]
    
    var count: Int{
        return self.objectlist.count
    }
    init(){
        objectlist = Array<FSendReceiverInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        
        objectlist = Array<FSendReceiverInfo>()
        for childs: JSONDecoder in decoder.array!{
            objectlist.append(FSendReceiverInfo(childs))
        }
    }
    
    func append(list: [FSendReceiverInfo]){
        self.objectlist = list + self.objectlist
    }
}

class FSendReceiverInfo: JSONJoy {
    
    var message_id:String
    var receiver_user_id:String
    var receiver_user_name:String
    var read_time:String
    
    required init(_ decoder: JSONDecoder){
        message_id = decoder["message_id"].string ?? ""
        receiver_user_id = decoder["receiver_user_id"].string ?? ""
        receiver_user_name = decoder["receiver_user_name"].string ?? ""
        read_time = decoder["read_time"].string ?? ""
        
    }
    
}
