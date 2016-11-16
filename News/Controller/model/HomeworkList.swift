//
//  HomeworkList.swift
//  WXT_Parents
//
//  Created by zhang on 16/4/27.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import Foundation

class HomeworkList: JSONJoy {
    var homeworkList: [HomeworkInfo]
    var count: Int{
        return self.homeworkList.count
    }
    
    init(){
        homeworkList = Array<HomeworkInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        
        homeworkList = Array<HomeworkInfo>()
        for childs: JSONDecoder in decoder.array!{
            homeworkList.append(HomeworkInfo(childs))
        }
    }
    
    func append(list: [HomeworkInfo]){
        self.homeworkList = list + self.homeworkList
    }
}

class HomeworkInfo: JSONJoy{
    var allreader:Int?
    var content:String?
    var create_time:String?
    var id:String?
    var pic = Array<HomeworkPicInfo>()
    var readcount:Int?
    var readtag:Int?
    var userid:String?
    var username:String?
    var title:String?
    var dianzanlist:JSONDecoder?
    var comment:JSONDecoder?
    var subject:String?
    
    var receiverlist = Array<ReceiverInfo>()
    
    init() {
        
    }
    required init(_ decoder: JSONDecoder){
        allreader = decoder["allreader"].integer
        content = decoder["content"].string
        create_time = decoder["create_time"].string
        id = decoder["id"].string
        readcount = decoder["readcount"].integer
        readtag = decoder["readtag"].integer
        userid = decoder["userid"].string
        username = decoder["username"].string
        title = decoder["title"].string
        dianzanlist = decoder["like"]
        comment = decoder["comment"]
        subject = decoder["subject"].string
        if decoder["pic"].array != nil {
            for childs: JSONDecoder in decoder["pic"].array!{
                self.pic.append(HomeworkPicInfo(childs))
            }
        }
        if decoder["receiverlist"].array != nil {
            for recivers: JSONDecoder in decoder["receiverlist"].array!{
                self.receiverlist.append(ReceiverInfo(recivers))
            }
        }
    }
    func addpend(list: [HomeworkPicInfo]){
        self.pic = list + self.pic
    }
    
}
class HomeworkPicInfo: JSONJoy {
    
    var pictureurl:String
    

    required init(_ decoder: JSONDecoder){
        pictureurl = decoder["picture_url"].string ?? ""
    
        
    }
    
}

class ReceiverInfo: JSONJoy {
//    "id": "270",
//    "homework_id": "164",
//    "receiverid": "664",
//    "read_time": "1475902248",
//    "receiver_info": [
//    {
//    "name": "雷皓乐",
//    "photo": "20161017111517664.png",
//    "phone": ""
//    }
//    ]
     var id:String
     var homework_id:String
     var receiverid:String
     var read_time:String
     var name:String
     var photo:String
     var phone:String

    
    required init(_ decoder: JSONDecoder){
        id = decoder["id"].string ?? ""
        homework_id = decoder["homework_id"].string ?? ""
        receiverid = decoder["receiverid"].string ?? ""
        read_time = decoder["read_time"].string ?? ""
        if decoder["receiver_info"].array?.count>0 {
            name = decoder["receiver_info"].array?.first!["name"].string ?? ""
            photo = decoder["receiver_info"].array?.first!["photo"].string ?? ""
            phone = decoder["receiver_info"].array?.first!["phone"].string ?? ""
        }else{
            name = ""
            photo = ""
            phone = ""
        }
            
       
        
        
    }
    
}