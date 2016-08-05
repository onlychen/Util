//
//  UIBezierPathVc.m
//  Util
//
//  Created by chenliang on 16/8/1.
//  Copyright © 2016年 chenliang. All rights reserved.
//

#import "UIBezierPathVc.h"

#define kPhotoWidth 100
@interface UIBezierPathVc()
@property (nonatomic, strong) CALayer *movableCircleLayer;
@end

@implementation UIBezierPathVc
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = Util_UIBezierPathVc_Title;
    [self loadNaviControl];
    
    [self drawImageWithContent];
//    [self cakLayer];
//    [self drawSecondBezierPath];
}

-(void)cakLayer
{
    self.movableCircleLayer = [CALayer layer];
    // 指定大小
    self.movableCircleLayer.bounds = CGRectMake(0, 0, kPhotoWidth, kPhotoWidth);
    // 指定中心点
    self.movableCircleLayer.position = self.view.center;
    // 变成圆形
    self.movableCircleLayer.cornerRadius = kPhotoWidth / 2;
    // 指定背景色
    self.movableCircleLayer.backgroundColor = [UIColor blueColor].CGColor;
    // 设置阴影
    self.movableCircleLayer.shadowColor = [UIColor redColor].CGColor;
    self.movableCircleLayer.shadowOffset = CGSizeMake(3, 3);
    self.movableCircleLayer.shadowOpacity = 0.8;
    
    [self.view.layer addSublayer:self.movableCircleLayer];
}

- (void)drawSecondBezierPath {
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // 首先设置一个起始点
    [path moveToPoint:CGPointMake(20, self.view.frame.size.height - 100)];
    
    // 添加二次曲线
    [path addQuadCurveToPoint:CGPointMake(self.view.frame.size.width - 20, self.view.frame.size.height - 100)
                 controlPoint:CGPointMake(self.view.frame.size.width / 2, 0)];
    
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineWidth = 5.0;
    
    UIColor *strokeColor = [UIColor redColor];
    [strokeColor set];
    
    [path stroke];
}


- (void)drawImageWithContent {
    CALayer *layer = [CALayer layer];
    layer.bounds = CGRectMake(0, 0, kPhotoWidth, kPhotoWidth);
    layer.position = self.view.center;
    layer.cornerRadius = kPhotoWidth / 2;
    // 要设置此属性才能裁剪成圆形，但是添加此属性后，下面设置的阴影就没有了。
    layer.masksToBounds = YES;
    layer.borderColor = [UIColor whiteColor].CGColor;
    layer.borderWidth = 1;
    
    // 如果只是显示图片，不做其它处理，直接设置contents就可以了，也就不会出现
    // 绘图和图像倒立的问题了
    layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"123"].CGImage);
    
    [self.view.layer addSublayer:layer];
}

@end
