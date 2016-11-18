//
//  NewsList.swift
//  WXT_Teacher
//
//  Created by 李春波 on 16/3/7.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import Foundation

class NewsList: JSONJoy {
    var objectlist: [NewsInfo]
    var count: Int{
        return self.objectlist.count
    }
    
    init(){
        objectlist = Array<NewsInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        //        status = decoder["status"].string
        objectlist = Array<NewsInfo>()
        for childs: JSONDecoder in decoder.array!{
            objectlist.append(NewsInfo(childs))
        }
    }
    
    func append(list: [NewsInfo]){
        self.objectlist = list + self.objectlist
    }
}
class NewsInfo: JSONJoy{
    var sendName:String?
    var send_user_id: String?
    var message_time:String?
    var message_content:String?
//    "id": "5",
//    "uid": "605",
//    "chat_uid": "597",
//    "last_content": "Jshdkjskdj",
//    "status": 2,
//    "last_chat_id": "23",
//    "send_type": "0",
//    "receive_type": "0",
//    "create_time": "19分钟前",
//    "my_face": "newsgroup6171473498324434.jpg",
//    "my_nickname": "再见十八岁",
//    "other_face": "newsgroup9281472003298107.jpg",
//    "other_nickname": "Gfh"
    
    var id:String?
    var uid: String?
    var chat_uid:String?
    var last_content:String?
    var last_chat_id: String?
    var send_type:String?
    var receive_type:String?
    var create_time:String?
    var my_face: String?
    var my_nickname:String?
    var other_face:String?
    var other_nickname:String?
    
    init() {
        
    }
    required init(_ decoder: JSONDecoder){
        sendName = decoder["receive_user_name"].string
        send_user_id = decoder["send_user_id"].string
        message_time = decoder["message_time"].string
        message_content = decoder["message_content"].string
        
        
        
        id = decoder["id"].string
        uid = decoder["uid"].string
        chat_uid = decoder["chat_uid"].string
        last_content = decoder["last_content"].string
        last_chat_id = decoder["last_chat_id"].string
        send_type = decoder["send_type"].string
        receive_type = decoder["receive_type"].string
        create_time = decoder["create_time"].string
        my_face = decoder["my_face"].string
        my_nickname = decoder["my_nickname"].string
        other_face = decoder["other_face"].string
        other_nickname = decoder["other_nickname"].string
    
    }
    
}
