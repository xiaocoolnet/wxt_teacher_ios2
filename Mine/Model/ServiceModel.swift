//
//  ServiceModel.swift
//  WXT_Parents
//
//  Created by 李春波 on 16/1/21.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import Foundation


class ServiceModel: JSONJoy{
    var status:String?
    var data:ServiceInfo?
    var errorData:String?
    var datastring:String?
    init(){
    }
    required init(_ decoder:JSONDecoder){
        status = decoder["status"].string
        if status == "success"{
            data = ServiceInfo(decoder["data"])
        }else{
            errorData = decoder["data"].string
        }
        
    }
}
class ServiceInfo: JSONJoy {
    var status:String?
    var endtime:String?
    var phone:String?
    init(){
    }
    required init(_ decoder:JSONDecoder){
        status = decoder["status"].string
        endtime = decoder["endtime"].string
        phone = decoder["phone"].string
        
    }
}