//
//  FoodMenuModel.swift
//  WXT_Teacher
//
//  Created by xiaocool on 16/7/21.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import Foundation
class FoodMenuModel: JSONJoy {
    var objectlist: [FoodMenuInfo]
    var count: Int{
        return self.objectlist.count
    }
    
    init(){
        objectlist = Array<FoodMenuInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        //        status = decoder["status"].string
        objectlist = Array<FoodMenuInfo>()
        for childs: JSONDecoder in decoder.array!{
            objectlist.append(FoodMenuInfo(childs))
        }
    }
    
    func append(list: [FoodMenuInfo]){
        self.objectlist = list + self.objectlist
    }
}
class FoodMenuInfo: JSONJoy{
    var id:String?
    var title: String?
    var content:String?
    var photo:String?
    var date:String?
    
    
    var create_time:String?
    init() {
        
    }
    required init(_ decoder: JSONDecoder){
        id = decoder["id"].string
        title = decoder["title"].string
        content = decoder["content"].string
        photo = decoder["photo"].string
        create_time = decoder["create_time"].string
        date=decoder["date"].string
    }
    
}
