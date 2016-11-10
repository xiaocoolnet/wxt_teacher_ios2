//
//  ClassKaoQin.swift
//  WXT_Teacher
//
//  Created by qiang on 16/8/29.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class ClassKaoQin: JSONJoy{
    var status:String?
    var data: JSONDecoder?
    var array : Array<JSONDecoder>?
    var errorData:String?
    init(){
    }
    required init(_ decoder:JSONDecoder){
        
        status = decoder["status"].string
        if status == "success" {
            data = decoder["data"]
        }
        else{
            errorData = decoder["data"].string
        }
    }
}
class ClassKaoQinList: JSONJoy {
    var status:String?
    var objectlist: [ClassKaoQinInfo]
    
    var count: Int{
        return self.objectlist.count
    }
    init(){
        objectlist = Array<ClassKaoQinInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        
        objectlist = Array<ClassKaoQinInfo>()
        for childs: JSONDecoder in decoder.array!{
            objectlist.append(ClassKaoQinInfo(childs))
        }
    }
    
    func append(list: [ClassKaoQinInfo]){
        self.objectlist = list + self.objectlist
    }
    
}

class ClassKaoQinInfo: JSONJoy{
//    "userid": "647",
//    "name": "随便1",
//    "phone": "",
//    "photo": "weixiaotong.png",
//    "studentid": "",
//    "arrivetime": "",
//    "leavetime": "",
//    "type": "",
//    "arrivepicture": "",
//    "leavepicture": "",
//    "arrivevideo": "",
//    "leavevideo": "",
//    "sign_date": "",
//    "create_time": "",
//    "status": "0"
    var userid:String?
    var name:String?
    var phone: String?
    var photo:String?
    var studentid:String?
    var arrivetime:String?
    var leavetime :String?
    var type :String?
    var arrivepicture :String?
    var leavepicture:String?
    var arrivevideo:String?
    var leavevideo:String?
    var sign_date :String?
    var create_time :String?
    var status :String?
    
    
    var checkedType :String?
    var checkedTypeT : String?
    
    required init(_ decoder: JSONDecoder){
        userid = decoder["userid"].string
        name = decoder["name"].string
        phone = decoder["phone"].string
        photo = decoder["photo"].string
        studentid = decoder["studentid"].string
        arrivetime = decoder["arrivetime"].string ?? ""
        leavetime = decoder["leavetime"].string
        type = decoder["type"].string
        arrivepicture = decoder["arrivepicture"].string
        leavepicture = decoder["leavepicture"].string
        arrivevideo = decoder["arrivevideo"].string
        leavevideo = decoder["leavevideo"].string ?? ""
        sign_date = decoder["sign_date"].string
        create_time = decoder["create_time"].string
        status = decoder["status"].string ?? ""
       
        
        if (status=="1"){
            checkedType = "3"
        }else if (sign_date==nil||sign_date=="0"||sign_date==""){
            checkedType = "1"
        }else{
            checkedType = "0"
        }
        
        
        
        
        if (status=="1"){
            checkedTypeT = "3"
        }else if (leavetime==nil||leavetime=="0"||leavetime==""){
            checkedTypeT = "1"
        }else{
            checkedTypeT = "0"
        }
        
        
    
    }
    
}


    


