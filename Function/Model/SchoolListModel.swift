//
//  SchoolListModel.swift
//  WXT_Teacher
//
//  Created by xiaocool on 16/7/19.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import Foundation
class SchoolListModel: JSONJoy {
    var objectlist: [SchoolListInfo]
    var count: Int{
        return self.objectlist.count
    }
    
    init(){
        objectlist = Array<SchoolListInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        //        status = decoder["status"].string
        objectlist = Array<SchoolListInfo>()
        for childs: JSONDecoder in decoder.array!{
            objectlist.append(SchoolListInfo(childs))
        }
    }
    
    func append(list: [SchoolListInfo]){
        self.objectlist = list + self.objectlist
    }
}
class SchoolListInfo: JSONJoy{
    var id:String?
    var schoolid: String?
    var post_title:String?
    var post_excerpt:String?
    var post_date:String?
    var smeta : String?
    var thumb : String?
    
    
    
    var type:Int?
    init() {
        
    }
    required init(_ decoder: JSONDecoder){
        id = decoder["id"].string
        schoolid = decoder["schoolid"].string
        post_title = decoder["post_title"].string
        post_excerpt = decoder["post_excerpt"].string
        type = decoder["type"].integer
        post_date=decoder["post_date"].string
        smeta=decoder["smeta"].string
        thumb=decoder["thumb"].string
    }
    
}
