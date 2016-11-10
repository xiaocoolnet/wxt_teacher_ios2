//
//  CalendarFirstViewController.m
//  HQHotel
//
//  Created by xiaocool on 16/4/22.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

#import "CalendarFirstViewController.h"
#import "CalendarHomeViewController.h"
#import "WXT_Teacher-Swift.h"
@interface CalendarFirstViewController ()
{
    
    CalendarHomeViewController *chvc;
    NSString *str1;
    NSString *str2;
    int *str3;
    
    
    
}

@end

@implementation CalendarFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    
    
    
    
    dataArray=[[NSMutableArray alloc] init];
    
    chvc = [[CalendarHomeViewController alloc]init];
    chvc.view.frame=CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:chvc.view];
    
    
    [chvc setHotelToDay:9000 ToDateforString:nil];
    
    
    [self mainViewClass:0];
    
    chvc.calendarblock = ^(CalendarDayModel *model){
        
        
        NSLog(@"%@",[model toString]);
        
        if(model.style==CellDayTypeClick)
        {
            [dataArray addObject:model.toString];
            
            NSSet *set = [NSSet setWithArray:dataArray];
            dataArray=[[set allObjects] mutableCopy];
            
            [dataArray sortUsingComparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2) {
                return [obj1 compare:obj2];
            }];
            
        }
        else
        {
            [dataArray removeObject:model.toString];
            
        }
        
        [self mainViewClass:dataArray.count];
        
    };
    
}
-(void)mainViewClass:(NSInteger)num
{
    
    [mainView removeFromSuperview];
    
    mainView=[[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-50,self.view.frame.size.width,50)];
    mainView.backgroundColor=[UIColor grayColor];
    [self.view addSubview:mainView];
    
    
    UILabel * lable =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    lable.font=[UIFont systemFontOfSize:14.0f];
    lable.textColor=[UIColor whiteColor];
    lable.textAlignment=NSTextAlignmentCenter;
    [mainView addSubview:lable];
    
    
    
    if(num==0)
    {
        lable.text=@"请选择开始时间";
    }
    if(num==1)
    {
        lable.text=@"请选择结束时间";
        
    }
    if(num==2)
    {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSDate* date1 = [formatter dateFromString:[dataArray objectAtIndex:0]];
        NSDate* date2 = [formatter dateFromString:[dataArray objectAtIndex:1]];
        
        
        NSLog(@"%@",date1);
        NSLog(@"%@",date2);
        
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *comps = [gregorian components:NSCalendarUnitDay fromDate:date1 toDate:date2  options:0];
        
        int days = [comps day];
        
        
        lable.text=[NSString stringWithFormat:@"",[dataArray objectAtIndex:0],[dataArray objectAtIndex:1],days];
        
        
            str1=[dataArray objectAtIndex:0];
            str2=[dataArray objectAtIndex:1];
            
            NSUserDefaults *chuanzhi = NSUserDefaults.standardUserDefaults;
            
            [chuanzhi setObject:str1 forKey:@"startTime"];
            [chuanzhi setObject:str2 forKey:@"endTime"];
        
            [chuanzhi synchronize];
            [self dismissViewControllerAnimated:true completion:nil];
  
        
    }
    
    

}
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
