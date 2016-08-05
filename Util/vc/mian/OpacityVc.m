//
//  OpacityVc.m
//  Util
//
//  Created by chenliang on 16/7/25.
//  Copyright © 2016年 chenliang. All rights reserved.
//

#import "OpacityVc.h"

@interface OpacityVc ()
@property(nonatomic,strong,nonnull)CALayer *myLayer;
@end

@implementation OpacityVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = Util_Opacity_Title;
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
    CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    theAnimation.fromValue = [NSNumber numberWithFloat:0];
    theAnimation.toValue = [NSNumber numberWithFloat:M_PI];
    [self.myLayer addAnimation:theAnimation forKey:@"animateTransform"];
    
    CAKeyframeAnimation*  opacityAnimation = [CAKeyframeAnimation animation];
    opacityAnimation.keyPath = @"opacity";
    opacityAnimation.values = @[@(1.0),
                                @(0.5),
                                @(0.0),
                                @(0.5),
                                @(1.0)];
    opacityAnimation.calculationMode = kCAAnimationPaced;
    [self.myLayer addAnimation:opacityAnimation forKey:@"OpacityAnination"];
    
    
    CAAnimationGroup * animationGroup = [[CAAnimationGroup alloc] init];
    animationGroup.animations = @[theAnimation,opacityAnimation];
    animationGroup.duration = 4.0;
    animationGroup.removedOnCompletion = NO;
    animationGroup.fillMode = kCAFillModeForwards;
    [self.myLayer addAnimation:animationGroup forKey:@"GroupAnimation"];
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
