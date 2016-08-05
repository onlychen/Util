//
//  FlySoundView.m
//  Util
//
//  Created by chenliang on 16/7/28.
//  Copyright © 2016年 chenliang. All rights reserved.
//

#import "FlySoundView.h"

@interface FlySoundView()
@property(nonatomic,assign)CGFloat   nCurrIndex;
@property(nonatomic,strong)NSTimer*     nTimer;
@property(nonatomic,strong)UIImageView* imgBg;
@end

@implementation FlySoundView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor grayColor];
        
        self.layer.cornerRadius =5.0;
        self.layer.masksToBounds = YES;
        self.layer.borderWidth = 5;
        self.layer.borderColor = [UIColor redColor].CGColor;
        self.nCurrIndex = 0;
        
        UIImage*  imgRecord = [UIImage imageNamed:@"record_animate_01"];
        CGFloat itemY = (frame.size.height - imgRecord.size.height - 40)/3;
//        CGFloat off_y = frame.size.height - 2*itemY/3 - imgRecord.size.height - 40;
        UIImageView* imgSound = [[UIImageView alloc] initWithImage:imgRecord];
        [self addSubview:imgSound];
        [imgSound mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo((frame.size.width - imgRecord.size.width)/2);
            make.top.mas_equalTo(itemY);
            make.size.mas_equalTo(imgRecord.size);
        }];
        self.imgBg = imgSound;
        
        UIButton* btnFin = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btnFin];
        [btnFin mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(imgSound.mas_bottom).offset(itemY);
            make.size.mas_equalTo(CGSizeMake(((frame.size.width - 30)/2), 40));
        }];
        [btnFin setBackgroundColor:[UIColor yellowColor]];
        [btnFin setTitle:@"完成" forState:UIControlStateNormal];
        [btnFin addTarget:self action:@selector(completeAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton* btnCanCel = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btnCanCel];
        [btnCanCel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(btnFin.mas_right).offset(10);
            make.top.mas_equalTo(btnFin.mas_top);
            make.size.mas_equalTo(CGSizeMake(((frame.size.width - 30)/2), 40));
        }];
        [btnCanCel setBackgroundColor:[UIColor yellowColor]];
        [btnCanCel setTitle:@"取消" forState:UIControlStateNormal];
        [btnCanCel addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        
        WS(weakSelf);
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
           NSTimer* timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(detectionVoice) userInfo:nil repeats:YES];
           weakSelf.nTimer = timer;
            
          [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
          [[NSRunLoop currentRunLoop] run];
        });
    }
    return self;
}

-(void)detectionVoice
{
    WS(weakSelf);
    dispatch_queue_t  mainQueue = dispatch_get_main_queue();
    dispatch_async(mainQueue, ^{
        NSInteger nIndex = arc4random_uniform(15);
        if (nIndex == 0)
        {
            return ;
        }
        else
        {
            NSString* strName = @"";
            if (nIndex < 10)
            {
                strName = [NSString stringWithFormat:@"record_animate_0%zd",nIndex];
            }
            else
            {
                strName = [NSString stringWithFormat:@"record_animate_%zd",nIndex];
            }
            self.imgBg.image = [UIImage imageNamed:strName];
        }
        //30s自动消失
        weakSelf.nCurrIndex += 0.5;
        if (self.nCurrIndex >= 15)
        {
            [weakSelf.nTimer setFireDate:[NSDate distantFuture]];
            if ([weakSelf.delegate respondsToSelector:@selector(timerActionCallBack)])
            {
                [weakSelf.delegate timerActionCallBack];
            }
        }
    });
}

-(void)completeAction:(UIButton*)sender
{
    [self.nTimer setFireDate:[NSDate distantFuture]];
    if ([self.delegate respondsToSelector:@selector(timerActionCallBack)])
    {
        [self.delegate timerActionCallBack];
    }
}

-(void)cancelAction:(UIButton*)sender
{
    [self.nTimer setFireDate:[NSDate distantFuture]];
    if ([self.delegate respondsToSelector:@selector(timerActionCallBack)])
    {
        [self.delegate timerActionCallBack];
    }
}

-(void)resumerTimer
{
    [self.nTimer setFireDate:[NSDate distantPast]]; 
}

-(void)dealloc
{
    [self.nTimer invalidate];
    self.nTimer = nil;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
