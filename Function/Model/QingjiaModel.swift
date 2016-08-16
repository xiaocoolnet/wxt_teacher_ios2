//
//  QingjiaModel.swift
//  WXT_Teacher
//
//  Created by xiaocool on 16/7/25.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import Foundation
class QingjiaModel: JSONJoy {
    var parentsExhortList: [QingjiaInfo]
    var count: Int{
        return self.parentsExhortList.count
    }
    init(){
        parentsExhortList = Array<QingjiaInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        
        parentsExhortList = Array<QingjiaInfo>()
        for childs: JSONDecoder in decoder.array!{
            parentsExhortList.append(QingjiaInfo(childs))
        }
    }
    func append(list: [QingjiaInfo]){
        self.parentsExhortList = list + self.parentsExhortList
    }
}
class QingjiaInfo: JSONJoy{
    var id:String?
    var studentid:String?
    var parentid:String?
    var teacherid:String?
    var create_time:String?
    var begintime:String?
    var endtime : String?
    var reason : String?
    var status : String?
    var feedback : String?
    var deal_time : String?
    var classname : String?
    var teachername : String?
    var teacheravatar : String?
    var teacherphone : String?
    var parentname : String?
    var parentavatar : String?
    var parentphone : String?
    var studentname : String?
    var studentavatar : String?
    
    
    
    
 
    var pic : [QJphotopicInfo]

    var picCount: Int{
        return self.pic.count
    }
    init() {
        pic=Array<QJphotopicInfo>()

        
    }
    required init(_ decoder: JSONDecoder){
        parentid = decoder["parentid"].string
        id = decoder["id"].string
        studentid = decoder["studentid"].string
        teacherid = decoder["teacherid"].string
        create_time = decoder["create_time"].string
        begintime = decoder["begintime"].string
        endtime=decoder["endtime"].string
        reason=decoder["reason"].string
        status=decoder["status"].string
        feedback=decoder["feedback"].string
        deal_time=decoder["deal_time"].string
        classname=decoder["classname"].string
        teachername=decoder["teachername"].string
        teacheravatar=decoder["teacheravatar"].string
        teacherphone=decoder["teacherphone"].string
        parentname=decoder["parentname"].string
        parentavatar=decoder["parentavatar"].string
        parentphone=decoder["parentphone"].string
        studentname=decoder["studentname"].string
        studentavatar=decoder["studentavatar"].string
        
        
        
        
        
      
        
        pic=Array<QJphotopicInfo>()
        if decoder["pic"].array != nil{
            for childs: JSONDecoder in decoder["pic"].array!{
                pic.append(QJphotopicInfo(childs))
            }}
      
        
        
    }
    func addpend(list:[QJphotopicInfo]){
        self.pic=list+self.pic
    }
  
    
    
}
class QJphotopicInfo: JSONJoy{
    
    var pictureurl:String?
    
    
    
    init() {
        
    }
    required init(_ decoder: JSONDecoder){
        pictureurl = decoder["picture_url"].string
        
        
        
    }}
