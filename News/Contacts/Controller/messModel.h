//
//  messModel.h
//  QQ自动回复
//
//  Created by 冷求慧 on 15/12/7.
//  Copyright © 2015年 gdd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface messModel : NSObject
//@property (nonatomic,copy)NSString *imageName;
//@property (nonatomic,copy)UIImageView *imageview;
@property (nonatomic,copy)NSString *desc;
@property (nonatomic,copy)NSString *time;
@property (nonatomic,assign)BOOL person;
@property (nonatomic,copy)NSString *id;
@property (nonatomic,copy)NSString *send_uid;
@property (nonatomic,copy)NSString *receive_uid;
@property (nonatomic,copy)NSString *content;
@property (nonatomic,copy)NSString *status;
@property (nonatomic,copy)NSString *create_time;
@property (nonatomic,copy)NSString *send_face;
@property (nonatomic,copy)NSString *send_nickname;
@property (nonatomic,copy)NSString *receive_face;
@property (nonatomic,copy)NSString *receive_nickname;

/** 将plist里的data转为model */
-(instancetype)initWithModel:(NSDictionary *)mess;
//同理
+(instancetype)messModel:(NSDictionary *)mess;

@end
