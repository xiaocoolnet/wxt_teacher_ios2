//
//  SendMessageModel.swift
//  WXT_Parents
//
//  Created by 沈晓龙 on 16/11/9.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import Foundation

class SendMessageModel: JSONJoy{
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
class AirlinesList: JSONJoy {
    var status:String?
    var objectlist: [AirlinesInfo]
    
    var count: Int{
        return self.objectlist.count
    }
    init(){
        objectlist = Array<AirlinesInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        
        objectlist = Array<AirlinesInfo>()
        for childs: JSONDecoder in decoder.array!{
            objectlist.append(AirlinesInfo(childs))
        }
    }
    
    func append(list: [AirlinesInfo]){
        self.objectlist = list + self.objectlist
    }
    
}

class AirlinesInfo: JSONJoy{
    var id:String?
    var userid:String?
    var create_time: String?
    var message:String?
    var feed_userid:String?
    var feed_back:String?
    var feed_time: String?
    
    required init(_ decoder: JSONDecoder){
        id = decoder["id"].string
        userid = decoder["userid"].string
        create_time = decoder["create_time"].string
        message = decoder["message"].string
        feed_userid = decoder["feed_userid"].string
        feed_back = decoder["feed_back"].string
        feed_time = decoder["feed_time"].string
    }
    
}