//
//  ExpandVc.m
//  Util
//
//  Created by chenliang on 16/7/25.
//  Copyright © 2016年 chenliang. All rights reserved.
//

#import "ExpandVc.h"

@interface ExpandVc ()
@property(nonatomic,strong,nonnull)CALayer *myLayer;
@end

@implementation ExpandVc

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = Util_ExpandVc_Title;
    [self loadNaviControl];
    
    //创建layer
    CALayer *myLayer=[CALayer layer];
    //设置layer的属性
    myLayer.bounds=CGRectMake(0, 60, 60, 60);
    myLayer.backgroundColor=[UIColor yellowColor].CGColor;
    myLayer.position=CGPointMake(100, 100);
    myLayer.anchorPoint=CGPointMake(0, 0);
    myLayer.cornerRadius=30;
    //添加layer
    [self.view.layer addSublayer:myLayer];
    self.myLayer=myLayer;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //1.创建动画
    CABasicAnimation *anima=[CABasicAnimation animationWithKeyPath:@"bounds"];
    //1.1设置动画执行时间
    anima.duration=0.1;
    //1.2设置动画执行完毕后不删除动画
    anima.removedOnCompletion=NO;
    //1.3设置保存动画的最新状态
    anima.fillMode=kCAFillModeForwards;
    //1.4修改属性，执行动画
    anima.toValue=[NSValue valueWithCGRect:CGRectMake(0, 0, 200, 200)];
    //2.添加动画到layer
    [self.myLayer addAnimation:anima forKey:nil];
    
    
    
//    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
//    
//    // 设置动画属性
//    anim.keyPath = @"position";
//    
//    NSValue *v1 = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
//    
//    NSValue *v2 = [NSValue valueWithCGPoint:CGPointMake(100, 200)];
//    
//    NSValue *v3 = [NSValue valueWithCGPoint:CGPointMake(200, 200)];
//    
//    NSValue *v4 = [NSValue valueWithCGPoint:CGPointMake(200, 100)];
//    
//    anim.values = @[v1,v2,v3,v4];
//    
//    anim.duration = 2;
//    
//    [self.myLayer addAnimation:anim forKey:nil];
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
