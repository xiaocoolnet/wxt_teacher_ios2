//
//  TeacherModel.swift
//  WXT_Teacher
//
//  Created by xiaocool on 16/6/23.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import Foundation
class TeacherModel: JSONJoy {
var objectlist: [TeacherListInfo]
var count: Int{
    return self.objectlist.count
}

init(){
    objectlist = Array<TeacherListInfo>()
}
required init(_ decoder: JSONDecoder) {
    //        status = decoder["status"].string
    objectlist = Array<TeacherListInfo>()
    for childs: JSONDecoder in decoder.array!{
        objectlist.append(TeacherListInfo(childs))
    }
}

func append(list: [TeacherListInfo]){
    self.objectlist = list + self.objectlist
}
}
class TeacherListInfo: JSONJoy{
    var id:String?
    var schoolid: String?
    var post_title:String?
    var post_keywords:String?
    var post_date:String?
    var post_excerpt : String?
    
    var thumb : String?
    
    
    var type:Int?
    init() {
        
    }
    required init(_ decoder: JSONDecoder){
        id = decoder["id"].string
        schoolid = decoder["schoolid"].string
        post_title = decoder["post_title"].string
        post_date = decoder["post_date"].string
        post_excerpt=decoder["post_excerpt"].string
        thumb = decoder["thumb"].string
        
    }
    
}
