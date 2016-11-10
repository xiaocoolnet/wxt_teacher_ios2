//
//  DaijieModel.swift
//  WXT_Teacher
//
//  Created by xiaocool on 16/7/29.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import Foundation
class DaijieModel: JSONJoy {
    var parentsExhortList: [DaijieInfo]
    var count: Int{
        return self.parentsExhortList.count
    }
    init(){
        parentsExhortList = Array<DaijieInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        
        parentsExhortList = Array<DaijieInfo>()
        for childs: JSONDecoder in decoder.array!{
            parentsExhortList.append(DaijieInfo(childs))
        }
    }
    func append(list: [DaijieInfo]){
        self.parentsExhortList = list + self.parentsExhortList
    }
}
class DaijieInfo: JSONJoy{
    var id:String?
    var teacherid:String?
    var studentid:String?
    var photo:String?
    var content:String?
    var delivery_time:String?
    var delivery_status:String?
    var parentid:String?
    var parenttime:String?
    var classname:String?
    var teachername:String?
    var teacheravatar:String?
    var teacherphone:String?
    var parentname:String?
    var parentavatar:String?
    var parentphone:String?
    var studentname:String?
    var studentavatar:String?
    var studentphone:String?
    

    init() {
     
    }
    required init(_ decoder: JSONDecoder){
        studentid = decoder["studentid"].string ?? ""
        id = decoder["id"].string ?? ""
        teacherid = decoder["teacherid"].string ?? ""
        photo = decoder["photo"].string ?? ""
        content = decoder["content"].string ?? ""
        delivery_time = decoder["delivery_time"].string ?? ""
        delivery_status = decoder["delivery_status"].string ?? ""
        parentid = decoder["parentid"].string ?? ""
        parenttime = decoder["parenttime"].string ?? ""
        classname = decoder["classname"].string ?? ""
        teachername = decoder["teachername"].string ?? ""
        teacheravatar = decoder["teacheravatar"].string ?? ""
        teacherphone = decoder["teacherphone"].string ?? ""
        parentname = decoder["parentname"].string ?? ""
        parentavatar = decoder["parentavatar"].string ?? ""
        parentphone = decoder["parentphone"].string
        studentname = decoder["studentname"].string ?? ""
        studentavatar = decoder["studentavatar"].string ?? ""
        studentphone = decoder["studentphone"].string ?? ""
        
    }
   
}


