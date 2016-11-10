//
//  BlogModel.swift
//  WXT_Parents
//
//  Created by 沈晓龙 on 16/8/3.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import Foundation

class BlogModel: JSONJoy{
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

class MyBlogList: JSONJoy {
    var status:String?
    var objectlist: [MyBlogoInfo]
    
    var count: Int{
        return self.objectlist.count
    }
    init(){
        objectlist = Array<MyBlogoInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        
        objectlist = Array<MyBlogoInfo>()
        for childs: JSONDecoder in decoder.array!{
            objectlist.append(MyBlogoInfo(childs))
        }
    }
    
    func append(list: [MyBlogoInfo]){
        self.objectlist = list + self.objectlist
    }
    
}

class MyBlogoInfo: JSONJoy{
    var mid:String?
    var type:String?
    var schoolid:String?
    var classid:String?
    var userid:String?
    var name:String?
    var content:String?
    var write_time:String?
    var photo:String?
    var pic = Array<BlogPicInfo>()
    var like = Array<BlogLikeInfo>()
    var comment = Array<BlogCommentInfo>()
    var picCount: Int{
        return self.pic.count
    }

    required init(_ decoder: JSONDecoder){
        mid = decoder["mid"].string
        type = decoder["type"].string
        schoolid = decoder["schoolid"].string
        classid = decoder["classid"].string
        userid = decoder["userid"].string
        name = decoder["name"].string
        content = decoder["content"].string
        write_time = decoder["write_time"].string
        photo = decoder["photo"].string
        if decoder["pic"].array != nil {
            for childs: JSONDecoder in decoder["pic"].array!{
                self.pic.append(BlogPicInfo(childs))
            }
        }
        if decoder["like"].array != nil {
            for childs: JSONDecoder in decoder["like"].array!{
                self.like.append(BlogLikeInfo(childs))
            }
        }
        if decoder["comment"].array != nil {
            for childs: JSONDecoder in decoder["comment"].array!{
                self.comment.append(BlogCommentInfo(childs))
            }
        }
    }
    func addpend(list: [BlogPicInfo]){
        self.pic = list + self.pic
    }
    func addpend(list: [BlogLikeInfo]){
        self.like = list + self.like
    }
    func addpend(list: [BlogCommentInfo]){
        self.comment = list + self.comment
    }
    
}

class BlogPicList: JSONJoy {
    var status:String?
    var objectlist: [BlogPicInfo]
    
    var count: Int{
        return self.objectlist.count
    }
    init(){
        objectlist = Array<BlogPicInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        
        objectlist = Array<BlogPicInfo>()
        for childs: JSONDecoder in decoder.array!{
            objectlist.append(BlogPicInfo(childs))
        }
    }
    
    func append(list: [BlogPicInfo]){
        self.objectlist = list + self.objectlist
    }
}

class BlogPicInfo: JSONJoy {
    
    var pictureurl:String?
    init() {
        
    }
    required init(_ decoder: JSONDecoder){
        pictureurl = decoder["pictureurl"].string
        
    }
    
}


class BlogLikeList: JSONJoy {
    var status:String?
    var objectlist: [BlogLikeInfo]
    
    var count: Int{
        return self.objectlist.count
    }
    init(){
        objectlist = Array<BlogLikeInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        
        objectlist = Array<BlogLikeInfo>()
        for childs: JSONDecoder in decoder.array!{
            objectlist.append(BlogLikeInfo(childs))
        }
    }
    
    func append(list: [BlogLikeInfo]){
        self.objectlist = list + self.objectlist
    }
}

class BlogLikeInfo: JSONJoy {
    
    var userid:String
    var name:String
    
    required init(_ decoder: JSONDecoder){
        name = decoder["name"].string ?? ""
        userid = decoder["userid"].string ?? ""
        
    }
    
}

class BlogCommentList: JSONJoy {
    var status:String?
    var objectlist: [BlogCommentInfo]
    
    var count: Int{
        return self.objectlist.count
    }
    init(){
        objectlist = Array<BlogCommentInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        
        objectlist = Array<BlogCommentInfo>()
        for childs: JSONDecoder in decoder.array!{
            objectlist.append(BlogCommentInfo(childs))
        }
    }
    
    func append(list: [BlogCommentInfo]){
        self.objectlist = list + self.objectlist
    }
}

class BlogCommentInfo: JSONJoy {
    
    var userid:String
    var name:String
    var content:String
    var avatar:String
    var comment_time:String
    
    required init(_ decoder: JSONDecoder){
        name = decoder["name"].string ?? ""
        userid = decoder["userid"].string ?? ""
        content = decoder["content"].string ?? ""
        avatar = decoder["avatar"].string ?? ""
        comment_time = decoder["comment_time"].string ?? ""
        
    }
    
}

