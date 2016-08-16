//
//  TakeChilrenList.swift
//  WXT_Parents
//
//  Created by zhang on 16/5/4.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import Foundation


class TakeListModel: JSONJoy {
    var takeList: [TakeListInfo]
    var count: Int{
        return self.takeList.count
    }
    
    init(){
        takeList = Array<TakeListInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        
        takeList = Array<TakeListInfo>()
        for childs: JSONDecoder in decoder.array!{
            takeList.append(TakeListInfo(childs))
        }
    }
    
    func append(list: [TakeListInfo]){
        self.takeList = list + self.takeList
    }
}

class TakeListInfo: JSONJoy{
    var delivery_status = String()
    var delivery_time:String?
    var id:String?
//    var parentavatar:String?
    var parentid:String?
//    var parentname:String?
//    var parentphone:String?
    var parenttime:String?
    var photo:String?
    var teacheravatar:String?
    var teacherid:String?
    var teachername:String?
    var teacherphone:String?
    var userid:String?
    
    init() {
        
    }
    required init(_ decoder: JSONDecoder){
        delivery_status = decoder["delivery_status"].string!
        delivery_time = decoder["delivery_time"].string
        id = decoder["id"].string
//        parentavatar = decoder["parentavatar"].string
        parentid = decoder["parentid"].string
//        parentname = decoder["parentname"].string
//        parentphone = decoder["parentphone"].string
        parenttime = decoder["parenttime"].string
        photo = decoder["photo"].string
        teacheravatar = decoder["teacheravatar"].string
        teacherid = decoder["teacherid"].string
        teachername = decoder["teachername"].string
        teacherphone = decoder["teacherphone"].string
        userid = decoder["userid"].string
        
    }
    
}