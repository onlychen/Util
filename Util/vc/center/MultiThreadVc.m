//
//  MultiThreadVc.m
//  Util
//
//  Created by chenliang on 16/8/2.
//  Copyright © 2016年 chenliang. All rights reserved.
//

#import "MultiThreadVc.h"
#import "NormalOperation.h"

#define Img_Url @"https://mmbiz.qlogo.cn/mmbiz/sia5QxFVcFD0wkCgnmf6DVxI6fVewNS8rhtZb71v2DMpDy8jIdtviaetzicwQzTEoKKyHAN96Beibk2G61tZpezQ0Q/0?wx_fmt=png"

@interface MultiThreadVc()
@property(nonatomic,strong)UIImageView*  imgProperty;
@end

@implementation MultiThreadVc
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = Util_MultiThreadVc_Title;
    [self loadNaviControl];
    self.view.backgroundColor = [UIColor whiteColor];//RGB_GRAY_BG;

    // Do any additional setup after loading the view.
    UIImageView* imgView = [UIImageView new];
    [self.view addSubview:imgView];
    self.imgProperty = imgView;
    
    NSLog(@"begin");
    WS(weakSelf);
    NormalOperation* operation = [[NormalOperation alloc] initWithUrl:Img_Url completion:^(UIImage *image) {
        weakSelf.imgProperty.image = image;
        [weakSelf.imgProperty mas_makeConstraints:^(MASConstraintMaker *make) {
            weakSelf.imgProperty.frame = CGRectMake((Util_View_Width-image.size.width)/2, 0, image.size.width, image.size.height);
            weakSelf.imgProperty.center = CGPointMake(Util_View_Width/2, Util_Up_Height/2);
        }];
    }];
    [operation start];
    NSLog(@"end");
}

@end
