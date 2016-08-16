//
//  PhotoModel.swift
//  WXT_Teacher
//
//  Created by xiaocool on 16/7/23.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import Foundation
class PhotoModel: JSONJoy {
    var parentsExhortList: [PhotoInfo]
    var count: Int{
        return self.parentsExhortList.count
    }
    init(){
        parentsExhortList = Array<PhotoInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        
        parentsExhortList = Array<PhotoInfo>()
        for childs: JSONDecoder in decoder.array!{
            parentsExhortList.append(PhotoInfo(childs))
        }
    }
    func append(list: [PhotoInfo]){
        self.parentsExhortList = list + self.parentsExhortList
    }
}
class PhotoInfo: JSONJoy{
    var mid:String?
    var type:String?
    var name:String?
    var photo:String?
    var content:String?
    var write_time:String?
    
    var pic : [photopicInfo]
    var photolikelist : [photolikeInfo]
    
    
    
    var picCount: Int{
        return self.pic.count
    }
    init() {
        pic=Array<photopicInfo>()
        photolikelist=Array<photolikeInfo>()
        
    }
    required init(_ decoder: JSONDecoder){
        name = decoder["name"].string
        mid = decoder["mid"].string
        type = decoder["type"].string
        photo = decoder["photo"].string
        content = decoder["content"].string
        write_time = decoder["write_time"].string
        
        photolikelist=Array<photolikeInfo>()
        
        pic=Array<photopicInfo>()
        if decoder["pic"].array != nil{
            for childs: JSONDecoder in decoder["pic"].array!{
                pic.append(photopicInfo(childs))
            }}
        for childs:JSONDecoder in decoder["like"].array! {
            photolikelist.append(photolikeInfo(childs))
        }
        
        
    }
    func addpend(list:[photopicInfo]){
        self.pic=list+self.pic
    }
    func addpend(list:[photolikeInfo]){
        self.photolikelist=list+self.photolikelist
    }
    
    
}
class photopicInfo: JSONJoy{
    
    var pictureurl:String?
    
    
    
    init() {
        
    }
    required init(_ decoder: JSONDecoder){
        pictureurl = decoder["pictureurl"].string
        
        
        
    }}
class photolikeInfo: JSONJoy{
    var userid:String?
    
    var name : String?
    
    
    
    
    init() {
        
    }
    required init(_ decoder: JSONDecoder){
        userid = decoder["userid"].string
        
        name=decoder["name"].string
        
        
        
        
    }}
