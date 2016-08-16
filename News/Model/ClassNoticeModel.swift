//
//  ClassNoticeModel.swift
//  WXT_Parents
//
//  Created by 沈晓龙 on 16/8/1.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import Foundation

class ClassNoticeModel: JSONJoy{
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

class ClassNoticeList: JSONJoy {
    var status:String?
    var objectlist: [ClassNoticeInfo]
    
    var count: Int{
        return self.objectlist.count
    }
    init(){
        objectlist = Array<ClassNoticeInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        
        objectlist = Array<ClassNoticeInfo>()
        for childs: JSONDecoder in decoder.array!{
            objectlist.append(ClassNoticeInfo(childs))
        }
    }
    
    func append(list: [ClassNoticeInfo]){
        self.objectlist = list + self.objectlist
    }
    
}

class ClassNoticeInfo: JSONJoy{
    var userid:String?
    var id:String?
    var title:String?
    var content:String?
    var type:String?
    var create_time:String?
    var username:String?
    var avatar:String?
    //    var homework_info:JSONDecoder?
    //    var pictur:JSONDecoder?
    var receive_list = Array<ClassReceive_listInfo>()
    var pic = Array<ClassPicInfo>()
    
    
    required init(_ decoder: JSONDecoder){
        userid = decoder["userid"].string
        id = decoder["id"].string
        title = decoder["title"].string
        content = decoder["content"].string
        type = decoder["type"].string
        create_time = decoder["create_time"].string
        username = decoder["username"].string
        avatar = decoder["avatar"].string
        if decoder["receive_list"].array != nil {
            for childs: JSONDecoder in decoder["receive_list"].array!{
                self.receive_list.append(ClassReceive_listInfo(childs))
            }
        }
        if decoder["pic"].array != nil {
            for childs: JSONDecoder in decoder["pic"].array!{
                self.pic.append(ClassPicInfo(childs))
            }
        }
    }
    func addpend(list: [ClassReceive_listInfo]){
        self.receive_list = list + self.receive_list
    }
    func addpend(list: [ClassPicInfo]){
        self.pic = list + self.pic
    }
    
}

class ClassReceive_listList: JSONJoy {
    var status:String?
    var objectlist: [ClassReceive_listInfo]
    
    var count: Int{
        return self.objectlist.count
    }
    init(){
        objectlist = Array<ClassReceive_listInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        
        objectlist = Array<ClassReceive_listInfo>()
        for childs: JSONDecoder in decoder.array!{
            objectlist.append(ClassReceive_listInfo(childs))
        }
    }
    
    func append(list: [ClassReceive_listInfo]){
        self.objectlist = list + self.objectlist
    }
}

class ClassReceive_listInfo: JSONJoy {
    
    var name:String
    var photo:String
    var phone:String
    var receiverid:String
    var id:String
    var noticeid:String
    var receivertype:String
    var create_time:String
    
    
    required init(_ decoder: JSONDecoder){
        name = decoder["name"].string ?? ""
        photo = decoder["photo"].string ?? ""
        phone = decoder["phone"].string ?? ""
        receiverid = decoder["receiverid"].string ?? ""
        id = decoder["id"].string ?? ""
        noticeid = decoder["noticeid"].string ?? ""
        receivertype = decoder["receivertype"].string ?? ""
        create_time = decoder["create_time"].string ?? ""
        
    }
    
}


class ClassPicList: JSONJoy {
    var status:String?
    var objectlist: [ClassPicInfo]
    
    var count: Int{
        return self.objectlist.count
    }
    init(){
        objectlist = Array<ClassPicInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        
        objectlist = Array<ClassPicInfo>()
        for childs: JSONDecoder in decoder.array!{
            objectlist.append(ClassPicInfo(childs))
        }
    }
    
    func append(list: [ClassPicInfo]){
        self.objectlist = list + self.objectlist
    }
}

class ClassPicInfo: JSONJoy {
    
    var pictureurl:String
    var id:String
    var create_time:String
    //    init() {
    //
    //    }
    required init(_ decoder: JSONDecoder){
        pictureurl = decoder["pictureurl"].string ?? ""
        id = decoder["id"].string ?? ""
        create_time = decoder["create_time"].string ?? ""
        
    }
    
}
