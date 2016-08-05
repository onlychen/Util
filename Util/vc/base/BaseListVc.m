//
//  BaseListVc.m
//  Util
//
//  Created by chenliang on 16/7/19.
//  Copyright © 2016年 chenliang. All rights reserved.
//

#import "BaseListVc.h"

@interface BaseListVc ()<UITableViewDelegate,UITableViewDataSource>
@end

@implementation BaseListVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -初始化
-(void)initView
{
    self.tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, Util_Up_Height, Util_View_Width, Util_View_Height-Util_Up_Height)];
    self.tbView.delegate = self;
    self.tbView.dataSource = self;
    self.tbView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tbView];
    
    self.tbView.rowHeight = self.cellHeight;
    [self setExtraCellLineHidden];
}

-(NSMutableArray*)arrSource
{
    if (!_arrSource)
    {
        _arrSource = [NSMutableArray array];
    }
    return _arrSource;
}

#pragma mark - 去除TabView多余的分割线
- (void)setExtraCellLineHidden
{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [self.tbView setTableFooterView:view];
}

#pragma mark - UITableViewDelegate/UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrSource.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* identy = @"indenty";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identy];
    }
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
