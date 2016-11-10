//
//  MineModel.swift
//  WXT_Parents
//
//  Created by 李春波 on 16/1/20.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import Foundation
//
//  Httpresult.swift
//  yunzhuyangche_shop
//
//  Created by LCB on 15/8/21.
//  Copyright (c) 2015年 lcb. All rights reserved.
//

import Foundation
class MineModel: JSONJoy{
    var status:String?
    var data:UserInfomation?
    var errorData:String?
    var datastring:String?
    init(){
    }
    required init(_ decoder:JSONDecoder){
        status = decoder["status"].string
        if status == "success"{
            data = UserInfomation(decoder["data"])
        }else{
            errorData = decoder["data"].string
        }
        
    }
}
class UserInfomation: JSONJoy {
    var id:String?
    var name:String?
    var avatar:String?
    var phoneNumber:String?
    var url:String?
    
    init(){
    }
    required init(_ decoder:JSONDecoder){
        id = decoder["id"].string
        name = decoder["name"].string
        avatar = decoder["photo"].string
        phoneNumber = decoder["phone"].string
        url=decoder["url"].string
        
    }
}