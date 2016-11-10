//
//  KaoqinModel.swift
//  WXT_Parents
//
//  Created by 沈晓龙 on 16/8/11.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import Foundation

class KaoqinModel: JSONJoy{
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

class KaoqinList: JSONJoy {
    var status:String?
    var objectlist: [KaoqinInfo]
    
    var count: Int{
        return self.objectlist.count
    }
    init(){
        objectlist = Array<KaoqinInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        
        objectlist = Array<KaoqinInfo>()
        for childs: JSONDecoder in decoder.array!{
            objectlist.append(KaoqinInfo(childs))
        }
    }
    
    func append(list: [KaoqinInfo]){
        self.objectlist = list + self.objectlist
    }
    
}

class KaoqinInfo: JSONJoy{
    var userid:String?
    var id:String?
    var name:String?
    var photo:String?
    var schoolid:String?
    var arrivetime:String?
    var leavetime:String?
    var arrivepicture:String?
    var leavepicture:String?
    var arrivevideo:String?
    var leavevideo:String?
    var create_time:String?
    var type:String?
    
    
    required init(_ decoder: JSONDecoder){
        userid = decoder["userid"].string
        id = decoder["id"].string
        name = decoder["name"].string
        photo = decoder["photo"].string
        schoolid = decoder["schoolid"].string
        arrivetime = decoder["arrivetime"].string
        leavetime = decoder["leavetime"].string
        arrivepicture = decoder["arrivepicture"].string
        leavepicture = decoder["leavepicture"].string
        arrivevideo = decoder["arrivevideo"].string
        leavevideo = decoder["leavevideo"].string
        create_time = decoder["create_time"].string
        type = decoder["type"].string
    }
    
}
