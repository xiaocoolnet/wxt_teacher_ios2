//
//  ClassModel.swift
//  WXT_Parents
//
//  Created by 沈晓龙 on 16/7/28.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import Foundation


class BabyClassModel: JSONJoy{
    var status:String?
    var data:BabyClassInfo?
    var errorData:String?
    var datastring:String?
    init(){
    }
    required init(_ decoder:JSONDecoder){
        status = decoder["status"].string
        if status == "success"{
            data = BabyClassInfo(decoder["data"])
        }else{
            errorData = decoder["data"].string
        }
        
    }
}

class BabyClassInfo: JSONJoy{
    
//    var mon = Array<MonInfo>()
    var mon = [[String:JSONDecoder]]()
    var tu = [[String:JSONDecoder]]()
    var we = [[String:JSONDecoder]]()
    var th = [[String:JSONDecoder]]()
    var fri = [[String:JSONDecoder]]()
    var sat = [[String:JSONDecoder]]()
    var sun = [[String:JSONDecoder]]()
    
    
    required init(_ decoder: JSONDecoder){
        if decoder["mon"].array != nil {
            for childs: JSONDecoder in decoder["mon"].array!{
//                self.mon.append(MonInfo(childs))
                self.mon.append(childs.dictionary!)
            }
        }
        if decoder["tu"].array != nil {
            for childs: JSONDecoder in decoder["tu"].array!{
                self.tu.append(childs.dictionary!)
            }
        }
        if decoder["we"].array != nil {
            for childs: JSONDecoder in decoder["we"].array!{
                self.we.append(childs.dictionary!)
            }
        }
        if decoder["th"].array != nil {
            for childs: JSONDecoder in decoder["th"].array!{
                self.th.append(childs.dictionary!)
            }
        }
        if decoder["fri"].array != nil {
            for childs: JSONDecoder in decoder["fri"].array!{
                self.fri.append(childs.dictionary!)
            }
        }
        if decoder["sat"].array != nil {
            for childs: JSONDecoder in decoder["sat"].array!{
                self.sat.append(childs.dictionary!)
            }
        }
        if decoder["sun"].array != nil {
            for childs: JSONDecoder in decoder["sun"].array!{
                self.sun.append(childs.dictionary!)
            }
        }
        
    }
//    func addpend(list: [MonInfo]){
//        self.mon = list + self.mon
//    }
    
    
}

class MonList: JSONJoy {
    var status:String?
    var objectlist: [MonInfo]
    
    var count: Int{
        return self.objectlist.count
    }
    init(){
        objectlist = Array<MonInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        
        objectlist = Array<MonInfo>()
        for childs: JSONDecoder in decoder.array!{
            objectlist.append(MonInfo(childs))
        }
    }
    
    func append(list: [MonInfo]){
        self.objectlist = list + self.objectlist
    }
}

class MonInfo: JSONJoy {
    
    var one:String?
    var two:String?
    var three:String?
    var four:String?
    var five:String?
    var six:String?
    var seven:String?
    var eight:String?
    
    
    init() {
        
    }
    required init(_ decoder: JSONDecoder){
        one = decoder["1"].string
        two = decoder["2"].string
        three = decoder["3"].string
        four = decoder["4"].string
        five = decoder["5"].string
        six = decoder["6"].string
        seven = decoder["7"].string
        eight = decoder["8"].string
        
    }
    
}
