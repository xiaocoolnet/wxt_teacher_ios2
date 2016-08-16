//
//  SubjectListModel.swift
//  WXT_Teacher
//
//  Created by xiaocool on 16/8/12.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import Foundation
class SubjectListModel: JSONJoy {
    var objectlist: [SubjectInfo]
    var count: Int{
        return self.objectlist.count
    }
    
    init(){
        objectlist = Array<SubjectInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        //        status = decoder["status"].string
        objectlist = Array<SubjectInfo>()
        for childs: JSONDecoder in decoder.array!{
            objectlist.append(SubjectInfo(childs))
        }
    }
    
    func append(list: [SubjectInfo]){
        self.objectlist = list + self.objectlist
    }
}
class SubjectInfo: JSONJoy{
    var id:String?
    var schoolid: String?
    var subject:String?
    
    init() {
        
    }
    required init(_ decoder: JSONDecoder){
        id = decoder["id"].string
        schoolid = decoder["schoolid"].string
        subject = decoder["subject"].string
        
    }
    
}
