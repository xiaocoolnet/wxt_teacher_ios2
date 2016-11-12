//
//  ClassParentModel.h
//  MutableLevelTableView
//
//  Created by xiaocool on 16/11/12.
//  Copyright © 2016年 杨卡. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Student_List,Parent_List;
@interface ClassParentModel : NSObject

@property (nonatomic, copy) NSString *classid;

@property (nonatomic, copy) NSString *classname;

@property (nonatomic, copy) NSString *teacherid;

@property (nonatomic, strong) NSArray<Student_List *> *student_list;

@end
@interface Student_List : NSObject

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *photo;

@property (nonatomic, strong) NSArray<Parent_List *> *parent_list;

@end

@interface Parent_List : NSObject

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *appellation;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *photo;

@end

