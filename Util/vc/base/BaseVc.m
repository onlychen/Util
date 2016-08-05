//
//  BaseVc.m
//  Util
//
//  Created by chenliang on 16/7/19.
//  Copyright © 2016年 chenliang. All rights reserved.
//

#import "BaseVc.h"

@interface BaseVc ()

@end

@implementation BaseVc

#pragma mark -系统自带
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 左边侧滑按钮
-(void)loadNaviControl
{
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, Util_StatusBar_Height, 80, Util_NavigationBar_Height);
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btn.imageEdgeInsets = UIEdgeInsetsMake(0,-10,0,0);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
//    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(Util_StatusBar_Height);
//        make.left.mas_equalTo(0);
//        make.size.mas_equalTo(CGSizeMake(80, Util_NavigationBar_Height));
//    }];
    [btn setImage:[UIImage imageNamed:@"fanhuiqietu"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(eventLeft:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 事件处理
-(void)eventLeft:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
