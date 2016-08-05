//
//  KeyPathX.m
//  Util
//
//  Created by chenliang on 16/7/25.
//  Copyright © 2016年 chenliang. All rights reserved.
//

#import "KeyPathX.h"

@interface KeyPathX ()
@property(nonatomic,assign)CGFloat angle;
@property(nonatomic,strong,nonnull)CALayer *myLayer;
@end

@implementation KeyPathX

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = Util_Animation_Title;
    [self loadNaviControl];
    self.angle = 1;
    // Do any additional setup after loading the view.
    
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//    CABasicAnimation *theAnimation;
//    theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
//    theAnimation.duration=8;
//    
//#pragma mark -还原到最初始状态
////    theAnimation.removedOnCompletion = YES;
//#pragma mark -不还原
//    theAnimation.fillMode = kCAFillModeForwards;
//    theAnimation.removedOnCompletion = NO;
//    
//    theAnimation.fromValue = [NSNumber numberWithFloat:1];
//    theAnimation.toValue = [NSNumber numberWithFloat:0.5];
//    [self.myLayer addAnimation:theAnimation forKey:@"animateTransform"];

    CABasicAnimation *theAnimation;
    [self.myLayer setAnchorPoint:CGPointMake(0.5, 0.5)];
//    [self.myLayer setAnchorPoint:CGPointMake(1, 1)];
//    [self.myLayer setAnchorPoint:CGPointMake(0, 0)];
    theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    theAnimation.duration=0.5;
#pragma mark -还原到最初始状态
    //    theAnimation.removedOnCompletion = YES;
#pragma mark -不还原
    theAnimation.fillMode = kCAFillModeForwards;
    theAnimation.removedOnCompletion = NO;
    
    theAnimation.fromValue = [NSNumber numberWithFloat:self.angle];
    theAnimation.toValue = [NSNumber numberWithFloat:self.angle/2];
    [self.myLayer addAnimation:theAnimation forKey:@"animateTransform"];
    
    self.angle = self.angle/2;
}


@end
