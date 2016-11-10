//
//  ClassHistroy.swift
//  WXT_Teacher
//
//  Created by qiang on 16/8/30.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class ClassHistroy: JSONJoy {
    var status:String?
    var objectlist: [ClassHistroyInfo]
    
    var count: Int{
        return self.objectlist.count
    }
    init(){
        objectlist = Array<ClassHistroyInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        
        objectlist = Array<ClassHistroyInfo>()
        for childs: JSONDecoder in decoder.array!{
            objectlist.append(ClassHistroyInfo(childs))
        }
    }
    
    func append(list: [ClassHistroyInfo]){
        self.objectlist = list + self.objectlist
    }

}
class ClassHistroyInfo: JSONJoy{
   
//    "id": "647",
//    "photo": "weixiaotong.png",
//    "name": "随便1",
//    "arrive_count": "1"
    
    var id:String?
    var photo:String?
    var name:String?
    var arrive_count:String?
    
    required init(_ decoder: JSONDecoder){
        id = decoder["id"].string
        photo = decoder["photo"].string
        name = decoder["name"].string
        arrive_count = decoder["arrive_count"].string

    }
        
}