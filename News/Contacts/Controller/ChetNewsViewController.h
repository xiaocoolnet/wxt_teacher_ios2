//
//  ChetNewsViewController.h
//  WXT_Parents
//
//  Created by 沈晓龙 on 16/11/16.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChetNewsViewController : UIViewController

@property (nonatomic,strong)NSString *receive_uid;
@property (nonatomic,strong)UITableView *customTableView;
@property (nonatomic, strong) NSString *navgationType;
@property (nonatomic,copy)NSString * usertype;

@end
