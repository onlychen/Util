//
//  BlockVc.m
//  Util
//
//  Created by chenliang on 16/8/1.
//  Copyright © 2016年 chenliang. All rights reserved.
//

#import "BlockVc.h"
#import "BlockView.h"

@interface BlockVc ()

@end

@implementation BlockVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = Util_BlockVc_Title;
    [self loadNaviControl];
    
    currPage = @"1";
    //成员变量循环引用引起的内容泄露解决方案
    __block __weak __typeof(currPage) weakModel = currPage;
    //成员变量循环引用引起的内容泄露解决方案
    BlockView*  bkView = [[BlockView alloc] initWithBlock:CGRectMake(0, Util_Up_Height, Util_View_Width, Util_View_Height - Util_Up_Height) block:^(BOOL flag) {
//        currPage = 2;
        weakModel = @"2";
    }];
    [self.view addSubview:bkView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"进入控制器：%@", [[self class] description]);
}

- (void)dealloc {
    NSLog(@"控制器被dealloc: %@", [[self class] description]);
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
