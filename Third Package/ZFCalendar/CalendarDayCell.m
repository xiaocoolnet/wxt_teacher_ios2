
#import "CalendarDayCell.h"

@implementation CalendarDayCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView{
    
    //选中时显示的图片
    imgview = [[UIImageView alloc]initWithFrame:CGRectMake(10, 20, self.bounds.size.width-20, self.bounds.size.width-20)];
    imgview.image = [UIImage imageNamed:@"chack.png"];
    [self addSubview:imgview];
    
    //日期
    day_lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, self.bounds.size.width, self.bounds.size.width-10)];
    day_lab.textAlignment = NSTextAlignmentCenter;
    day_lab.font = [UIFont systemFontOfSize:15];

    [self addSubview:day_lab];

    //农历
    day_title = [[UILabel alloc]initWithFrame:CGRectMake(0, self.bounds.size.height-15, self.bounds.size.width, 13)];
    day_title.textColor = [UIColor lightGrayColor];
    day_title.font = [UIFont boldSystemFontOfSize:12];
    day_title.textAlignment = NSTextAlignmentCenter;
    [self addSubview:day_title];
    

}


- (void)setModel:(CalendarDayModel *)model
{
    
    if(model.style==CellDayTypeEmpty)
    {
        [self hidden_YES];

        return;
    }
    else if (model.style==CellDayTypePast)
    {
        [self hidden_NO];
        if (model.holiday) {
            day_lab.text = model.holiday;
        }else{
            day_lab.text = [NSString stringWithFormat:@"%d",model.day];
        }
        
        day_lab.textColor = [UIColor lightGrayColor];
        day_title.text = model.Chinese_calendar;
        imgview.hidden = YES;


        return;
    }
    else if (model.style==CellDayTypeFutur)
    {
        [self hidden_NO];
        
        if (model.holiday) {
            day_lab.text = model.holiday;
            day_lab.textColor = [UIColor orangeColor];
        }else{
            day_lab.text = [NSString stringWithFormat:@"%d",model.day];
            day_lab.textColor = COLOR_THEME;
        }
        
        day_title.text = model.Chinese_calendar;
        imgview.hidden = YES;
        
        return;
    }
    else if(model.style==CellDayTypeWeek)
    {
        [self hidden_NO];
        
        if (model.holiday) {
            day_lab.text = model.holiday;
            day_lab.textColor = [UIColor orangeColor];
        }else{
            day_lab.text = [NSString stringWithFormat:@"%d",model.day];
            day_lab.textColor = COLOR_THEME1;
        }
        
        day_title.text = model.Chinese_calendar;
        imgview.hidden = YES;
        return;
    }
    else if(model.style==CellDayTypeClick)
    {
        [self hidden_NO];
        
        day_lab.text = [NSString stringWithFormat:@"%d",model.day];
        day_lab.textColor = [UIColor whiteColor];
        day_title.text = model.Chinese_calendar;
        imgview.hidden = NO;
        
        return;
    }

}



- (void)hidden_YES{
    
    day_lab.hidden = YES;
    day_title.hidden = YES;
    imgview.hidden = YES;
    
}


- (void)hidden_NO{
    
    day_lab.hidden = NO;
    day_title.hidden = NO;

    
}


@end
