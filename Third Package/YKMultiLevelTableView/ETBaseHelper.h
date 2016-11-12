//
//  ETBaseHelper.h
//  ETong_ios
//
//  Created by xiaocool on 16/7/25.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//
#import "AFNetworking.h"
#import "HttpModel.h"

typedef void (^ETResponseBlock)(NSDictionary *response);
typedef void (^ETResponseErrorBlock)(NSString *response, NSError *error);
typedef void (^ResponseBlock)(NSArray *response);

@interface ETBaseHelper : NSObject
@property (nonatomic, strong) AFHTTPSessionManager *manager;

+(instancetype)helper;

@end
