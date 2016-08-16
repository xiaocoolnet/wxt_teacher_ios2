//
//  ACommentList.swift
//  WXT_Teacher
//
//  Created by xiaocool on 16/6/2.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import Foundation
class ACommentList: JSONJoy {
    var commentlist: [ACommentInfo]
    var count: Int{
        return self.commentlist.count
    }
    
    init(){
        commentlist = Array<ACommentInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        //        status = decoder["status"].string
        commentlist = Array<ACommentInfo>()
        for childs: JSONDecoder in decoder.array!{
            commentlist.append(ACommentInfo(childs))
        }
    }
    
    func append(list: [ACommentInfo]){
        self.commentlist = list + self.commentlist
    }
}
class ACommentInfo: JSONJoy{
    var avatar:String?
    var content:String?
    var userid:String?
    var name:String?
    var photo:String?
    var comment_time:String?
    
    init() {
        
    }
    required init(_ decoder: JSONDecoder){
        avatar = decoder["avatar"].string
        content = decoder["content"].string
        userid = decoder["userid"].string
        name = decoder["name"].string
        photo = decoder["photo"].string
        comment_time = decoder["comment_time"].string
    }
    
}
