//
//  ViewController.m
//  MutableLevelTableView
//
//  Created by 杨卡 on 16/9/8.
//  Copyright © 2016年 杨卡. All rights reserved.
//

#import "MAViewController.h"
#import "YKMultiLevelTableView.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "HttpModel.h"
#import "ETBaseHelper.h"
#import "ClassParentModel.h"
#import "ChetNewsViewController.h"
@interface MAViewController ()

@property(nonatomic,strong)YKMultiLevelTableView * mutableTable;

@end

@implementation MAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self returnData];
}

- (void)returnData{
    
    NSMutableArray * array = [NSMutableArray array];
    //服务器给的域名
    NSString *domainStr = @"http://wxt.xiaocool.net/index.php?g=apps&m=index&a=ParentContacts";
    NSString * userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
    //假如需要提交给服务器的参数是key＝1,class_id=100
    //创建一个可变字典
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    //往字典里面添加需要提交的参数
    [parametersDic setObject:userid forKey:@"userid"];
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    [session GET:domainStr parameters:parametersDic success:^(NSURLSessionDataTask *task, id responseObject) {
       
        NSMutableArray * modelArray = [NSMutableArray array];
        HttpModel *model = [HttpModel mj_objectWithKeyValues:responseObject];
        if ([model.status isEqualToString:@"success"]) {
            for (int i=0; i<model.data.count; i++) {
                ClassParentModel * classmodel = [ClassParentModel mj_objectWithKeyValues:model.data[i]];
                [modelArray addObject:classmodel];
            }
        }else{
           
        }
        for (ClassParentModel * classmodel in modelArray) {
            YKNodeModel * cmodel = [YKNodeModel nodeWithParentID:@"" name:classmodel.classname childrenID:classmodel.classid level:1 isExpand:NO phone:@""];
            [array addObject:cmodel];
            for (Student_List * stumodel in classmodel.student_list) {
                YKNodeModel * smodel = [YKNodeModel nodeWithParentID:classmodel.classid name:stumodel.name childrenID:stumodel.id level:2 isExpand:NO phone:@""];
                [array addObject:smodel];
                
                for (Parent_List * parentmodel in stumodel.parent_list) {
                    YKNodeModel * pmodel = [YKNodeModel nodeWithParentID:stumodel.id name:parentmodel.name childrenID:parentmodel.id level:3 isExpand:NO phone:parentmodel.phone];
                    [array addObject:pmodel];
                }
            }
        }
        CGRect rect = self.view.frame;
        CGRect frame = CGRectMake(0, 0, CGRectGetWidth(rect), CGRectGetHeight(rect)-44);
        self.mutableTable = [[YKMultiLevelTableView alloc] initWithFrame:frame
                                                                                     nodes:array
                                                                                rootNodeID:@""
                                                                          needPreservation:YES
                                                                               selectBlock:^(YKNodeModel *node) {
                                                                                
                                                                                   
                                                                               }callBlock:^(YKNodeModel *node) {
                                                                                   NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",node.phone];
                                                                                   UIWebView * callWebview = [[UIWebView alloc] init];
                                                                                   [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
                                                                                   [self.view addSubview:callWebview];
                                                                                  
                                                                                             NSLog(@"--select node phone=%@", node.phone);
                                                                               } messageBlock:^(YKNodeModel *node) {
                                                                                   ChetNewsViewController * vc = [[ChetNewsViewController alloc] init];
                                                                                   vc.usertype = @"0";
                                                                                   vc.title = node.name;
                                                                                   vc.receive_uid = node.childrenID;
                                                                                   [self.navigationController pushViewController:vc animated:true];
                                                                                            NSLog(@"--select node id=%@", node.childrenID);
                                                                               }];
        [self.view addSubview:_mutableTable];

        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"失败%@",error);
    }];

    
//    YKNodeModel *node1  = [YKNodeModel nodeWithParentID:@"" name:@"Node1" childrenID:@"1" level:1 isExpand:NO];
//    
//    YKNodeModel *node10 = [YKNodeModel nodeWithParentID:@"1" name:@"Node10" childrenID:@"10" level:2 isExpand:NO];
//    YKNodeModel *node11 = [YKNodeModel nodeWithParentID:@"1" name:@"Node11" childrenID:@"11" level:2 isExpand:NO];
//    
//    YKNodeModel *node100 = [YKNodeModel nodeWithParentID:@"10" name:@"Node100" childrenID:@"100" level:3 isExpand:NO];
//    YKNodeModel *node101 = [YKNodeModel nodeWithParentID:@"10" name:@"Node101" childrenID:@"101" level:3 isExpand:NO];
//    YKNodeModel *node110 = [YKNodeModel nodeWithParentID:@"11" name:@"Node110" childrenID:@"110" level:3 isExpand:NO];
//    YKNodeModel *node111 = [YKNodeModel nodeWithParentID:@"11" name:@"Node111" childrenID:@"111" level:3 isExpand:NO];
//    
//    YKNodeModel *node1110 = [YKNodeModel nodeWithParentID:@"111" name:@"Node1110" childrenID:@"1110" level:4 isExpand:NO];
//    YKNodeModel *node1111 = [YKNodeModel nodeWithParentID:@"111" name:@"Node1111" childrenID:@"1111" level:4 isExpand:NO];
//    
//    YKNodeModel *node2  = [YKNodeModel nodeWithParentID:@"" name:@"Node2" childrenID:@"2" level:1 isExpand:NO];
//    
//    YKNodeModel *node20 = [YKNodeModel nodeWithParentID:@"2" name:@"Node20" childrenID:@"20" level:2 isExpand:NO];
//    YKNodeModel *node200 = [YKNodeModel nodeWithParentID:@"20" name:@"Node200" childrenID:@"200" level:3 isExpand:NO];
//    YKNodeModel *node201 = [YKNodeModel nodeWithParentID:@"20" name:@"Node101" childrenID:@"201" level:3 isExpand:NO];
//    YKNodeModel *node202 = [YKNodeModel nodeWithParentID:@"20" name:@"Node202" childrenID:@"202" level:3 isExpand:NO];
//    
//    YKNodeModel *node21 = [YKNodeModel nodeWithParentID:@"2" name:@"Node21" childrenID:@"21" level:2 isExpand:NO];
//    YKNodeModel *node210 = [YKNodeModel nodeWithParentID:@"21" name:@"Node210" childrenID:@"210" level:3 isExpand:NO];
//    YKNodeModel *node211 = [YKNodeModel nodeWithParentID:@"21" name:@"Node211" childrenID:@"211" level:3 isExpand:NO];
//    YKNodeModel *node212 = [YKNodeModel nodeWithParentID:@"21" name:@"Node212" childrenID:@"212" level:3 isExpand:NO];
//    YKNodeModel *node2110 = [YKNodeModel nodeWithParentID:@"211" name:@"Node2110" childrenID:@"2110" level:4 isExpand:NO];
//    YKNodeModel *node2111 = [YKNodeModel nodeWithParentID:@"211" name:@"Node2111" childrenID:@"2111" level:4 isExpand:NO];
//    
//    return [NSMutableArray arrayWithObjects:node1,
//                                                node10,
//                                                    node100, node101,
//                                                        node1110, node1111,
//                                                node11,
//                                                    node110, node111,
//                                            node2,
//                                                node20,
//                                                    node200, node201, node202,
//                                                node21,
//                                                    node210, node211,
//                                                                node2110, node2111,
//                                                    node212,nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
