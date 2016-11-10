//
//  DaiBanModel.swift
//  WXT_Teacher
//
//  Created by xiaocool on 16/7/22.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import Foundation
class DaiBanModel: JSONJoy {
        var parentsExhortList: [DaibanInfo]
        var count: Int{
            return self.parentsExhortList.count
        }
        init(){
            parentsExhortList = Array<DaibanInfo>()
        }
        required init(_ decoder: JSONDecoder) {
            
            parentsExhortList = Array<DaibanInfo>()
            for childs: JSONDecoder in decoder.array!{
                parentsExhortList.append(DaibanInfo(childs))
            }
        }
        func append(list: [DaibanInfo]){
            self.parentsExhortList = list + self.parentsExhortList
        }
    }
    class DaibanInfo: JSONJoy{
        var id:String?
        var userid:String?
        var name:String?
        var photo:String?
        var title:String?
        var content:String?
        var create_time:String?
        var  status : String?
        
        
        var pic : [piclistInfo]
        var reciverlist : [reciverlistInfo]
        
        
        
        var picCount: Int{
            return self.pic.count
        }
        init() {
            pic=Array<piclistInfo>()
            reciverlist=Array<reciverlistInfo>()
            
        }
        required init(_ decoder: JSONDecoder){
            name = decoder["name"].string
            id = decoder["id"].string
            userid = decoder["userid"].string
            photo = decoder["photo"].string
            title = decoder["title"].string
            content = decoder["content"].string
            create_time = decoder["create_time"].string
            status=decoder["status"].string
            
            reciverlist=Array<reciverlistInfo>()
            
            pic=Array<piclistInfo>()
            if decoder["piclist"].array != nil{
                for childs: JSONDecoder in decoder["piclist"].array!{
                    pic.append(piclistInfo(childs))
                }}
            for childs:JSONDecoder in decoder["reciverlist"].array! {
                reciverlist.append(reciverlistInfo(childs))
            }
            
            
        }
        func addpend(list:[piclistInfo]){
            self.pic=list+self.pic
        }
        func addpend(list:[reciverlistInfo]){
            self.reciverlist=list+self.reciverlist
        }
        
        
    }
    class piclistInfo: JSONJoy{
        var id:String?
        var picture_url:String?
        
        
        
        init() {
            
        }
        required init(_ decoder: JSONDecoder){
            picture_url = decoder["picture_url"].string ?? ""
            id = decoder["id"].string ?? ""
            
            
        }}
    class reciverlistInfo: JSONJoy{
        var userid:String?
        var scheduleid:String?
        var previousid : String?
        var name : String?
        var photo : String?
        var feedback : String?
        var finish : String?
        var read_time : String?
        var create_time : String?
        
        init() {
            
        }
        required init(_ decoder: JSONDecoder){
            userid = decoder["userid"].string ?? ""
            scheduleid = decoder["scheduleid"].string ?? ""
            previousid=decoder["previousid"].string ?? ""
            name=decoder["name"].string ?? ""
            photo=decoder["photo"].string ?? ""
            feedback=decoder["feedback"].string ?? ""
            finish=decoder["finish"].string ?? ""
            read_time=decoder["read_time"].string ?? ""
            create_time=decoder["create_time"].string ?? ""
            
        }}
