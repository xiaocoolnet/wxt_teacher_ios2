//
//  JZdingzhuModel.swift
//  WXT_Teacher
//
//  Created by xiaocool on 16/6/1.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import Foundation
class JZdingzhuModel: JSONJoy {
    var parentsExhortList: [ExhortInfo]
    var count: Int{
        return self.parentsExhortList.count
    }
    init(){
        parentsExhortList = Array<ExhortInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        
        parentsExhortList = Array<ExhortInfo>()
        for childs: JSONDecoder in decoder.array!{
            parentsExhortList.append(ExhortInfo(childs))
        }
    }
    func append(list: [ExhortInfo]){
        self.parentsExhortList = list + self.parentsExhortList
    }
}
class ExhortInfo: JSONJoy{
    var content:String?
    var create_time:String?
    var studentid:String?
    var id:String?
    var teacherid:String?
    var userid:String?
    var studentname:String?
    var teachername:String?
    var username:String?
    var feed_time:String?
    var feedback:String?
    var photo:String?
    var studentavatar:String?
    var teacheravatar:String?
    var pic : [PiclistInfo]
    var comment : [CommentlistInfo]
    var like : [LikelistInfo]
    
    var useravatar : String?
    var picCount: Int{
        return self.pic.count
    }
    init() {
        pic=Array<PiclistInfo>()
        comment=Array<CommentlistInfo>()
        like=Array<LikelistInfo>()
    }
    required init(_ decoder: JSONDecoder){
        studentid = decoder["studentid"].string
        content = decoder["content"].string
        create_time = decoder["create_time"].string
        id = decoder["id"].string
        teacherid = decoder["teacherid"].string
        userid = decoder["userid"].string
        studentname = decoder["studentname"].string
        teachername = decoder["teachername"].string
        username = decoder["username"].string
        feed_time = decoder["feed_time"].string
        feedback = decoder["feedback"].string
        photo = decoder["photo"].string
        studentavatar = decoder["studentavatar"].string
        teacheravatar = decoder["teacheravatar"].string
        useravatar = decoder["useravatar"].string
        comment=Array<CommentlistInfo>()
        like=Array<LikelistInfo>()
        pic=Array<PiclistInfo>()
        if decoder["pic"].array != nil{
            for childs: JSONDecoder in decoder["pic"].array!{
                pic.append(PiclistInfo(childs))
            }}
        for childs:JSONDecoder in decoder["comment"].array! {
            comment.append(CommentlistInfo(childs))
        }
        for childs:JSONDecoder in decoder["like"].array! {
            like.append(LikelistInfo(childs))
        }
        
    }
    func addpend(list:[PiclistInfo]){
        self.pic=list+self.pic
    }
    func addpend(list:[CommentlistInfo]){
        self.comment=list+self.comment
    }
    func addpend(list:[LikelistInfo]){
        self.like=list+self.like
    }
    
}
class PiclistInfo: JSONJoy{
    var id:String?
    var pictureurl:String?
    var create_time : String?
    
    
    init() {
        
    }
    required init(_ decoder: JSONDecoder){
        pictureurl = decoder["picture_url"].string
       
        
    }}
class CommentlistInfo: JSONJoy{
    var userid:String?
    var avatar:String?
    var name : String?
    var content : String?
    var photo : String?
    var comment_time : String?
    
    init() {
        
    }
    required init(_ decoder: JSONDecoder){
        userid = decoder["userid"].string
        avatar = decoder["avatar"].string
        name=decoder["name"].string
        content=decoder["content"].string
        photo=decoder["photo"].string
        comment_time=decoder["comment_time"].string
        
    }}
class LikelistInfo: JSONJoy{
    var userid:String?
    var avatar:String?
    var name : String?
    var content : String?
    var photo : String?
    var comment_time : String?
    
    init() {
        
    }
    required init(_ decoder: JSONDecoder){
        userid = decoder["userid"].string
        avatar = decoder["avatar"].string
        name=decoder["name"].string
        content=decoder["content"].string
        photo=decoder["photo"].string
        comment_time=decoder["comment_time"].string
        
    }}