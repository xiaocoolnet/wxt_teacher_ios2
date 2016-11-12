//
//  ClassParentModel.m
//  MutableLevelTableView
//
//  Created by xiaocool on 16/11/12.
//  Copyright © 2016年 杨卡. All rights reserved.
//

#import "ClassParentModel.h"
@implementation ClassParentModel

+ (NSDictionary *)objectClassInArray{
    return @{@"student_list" : [Student_List class]};
}
@end
@implementation Student_List

+ (NSDictionary *)objectClassInArray{
    return @{@"parent_list" : [Parent_List class]};
}

@end


@implementation Parent_List

@end


