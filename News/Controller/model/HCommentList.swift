//
//  HCommentList.swift
//  WXT_Parents
//
//  Created by zhang on 16/5/18.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import Foundation
class HCommentList: JSONJoy {
    var commentlist: [HCommentInfo]
    var count: Int{
        return self.commentlist.count
    }
    
    init(){
        commentlist = Array<HCommentInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        //        status = decoder["status"].string
        commentlist = Array<HCommentInfo>()
        for childs: JSONDecoder in decoder.array!{
            commentlist.append(HCommentInfo(childs))
        }
    }
    
    func append(list: [HCommentInfo]){
        self.commentlist = list + self.commentlist
    }
}
class HCommentInfo: JSONJoy{
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