//
//  ClassAlbumIntrouce.swift
//  WXT_Teacher
//
//  Created by xiaocool on 16/9/4.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
class ClassAlbumIntrouce: JSONJoy{
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

class ClassAlbumList: JSONJoy {
    var status:String?
    var objectlist: [ClassAlbumListInfo]
    
    var count: Int{
        return self.objectlist.count
    }
    init(){
        objectlist = Array<ClassAlbumListInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        
        objectlist = Array<ClassAlbumListInfo>()
        for childs: JSONDecoder in decoder.array!{
            objectlist.append(ClassAlbumListInfo(childs))
        }
    }
    
    func append(list: [ClassAlbumListInfo]){
        self.objectlist = list + self.objectlist
    }
    
}
class ClassAlbumListInfo: JSONJoy{
    var id:String?
    var classname:String?
    var class_count:String?
    var teacher_info = Array<ClassAlbumInfo>()
    
    
    required init(_ decoder: JSONDecoder){
       
        
        id = decoder["id"].string
        classname = decoder["classname"].string
        class_count = decoder["class_count"].string
        if decoder["teacher_info"].array != nil{
            for childs: JSONDecoder in decoder["teacher_info"].array!{
                teacher_info.append(ClassAlbumInfo(childs))
            }
        }
    }
    
}
    class ClassAlbumInfo: JSONJoy{
        var classid:String?
        var id:String?
        var name:String?
        var teacher_count:String?
        
        required init(_ decoder: JSONDecoder){
            classid = decoder["classid"].string
            id = decoder["id"].string
            name = decoder["name"].string
            teacher_count = decoder["teacher_count"].string
            
        }
        
}
