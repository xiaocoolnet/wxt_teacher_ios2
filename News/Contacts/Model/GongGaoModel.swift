//
//  GongGaoModel.swift
//  WXT_Teacher
//
//  Created by xiaocool on 16/6/1.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import Foundation


class GongGaoModel: JSONJoy {
    var activityList: [GgongGaoInfo]
    var count: Int{
        return self.activityList.count
    }
    
    init(){
        activityList = Array<GgongGaoInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        
        activityList = Array<GgongGaoInfo>()
        for childs: JSONDecoder in decoder.array!{
            activityList.append(GgongGaoInfo(childs))
        }
    }
    
    func append(list: [GgongGaoInfo]){
        self.activityList = list + self.activityList
    }
}

class GgongGaoInfo: JSONJoy{
    
    var content:String?
    var create_time:String?
    var id:String?
    
    var userid:String?
    var username:String?
    var title:String?
    var type : String?
    var avatar : String?
    var pic : [JZpiclistInfo]
    
    
    
    var dianzanlist:JSONDecoder?
    var comment:JSONDecoder?
    
    init() {
        pic=Array<JZpiclistInfo>()
    }
    required init(_ decoder: JSONDecoder){
        
        content = decoder["content"].string
        create_time = decoder["create_time"].string
        id = decoder["id"].string
        
        userid = decoder["userid"].string
        username = decoder["username"].string
        title = decoder["title"].string
        dianzanlist = decoder["like"]
        comment = decoder["comment"]
        pic=Array<JZpiclistInfo>()
        if decoder["pic"].array != nil{
            for childs: JSONDecoder in decoder["pic"].array!{
                pic.append(JZpiclistInfo(childs))
            }}
    }}
class JZpiclistInfo: JSONJoy{
    var id:String?
    var pictureurl:String?
    var create_time : String?
    init() {
        }
    required init(_ decoder: JSONDecoder){
        pictureurl = decoder["pictureurl"].string
        
        
        
        }}
