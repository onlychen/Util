//
//  CenterViewVc.m
//  Util
//
//  Created by chenliang on 16/8/1.
//  Copyright © 2016年 chenliang. All rights reserved.
//

#import "CenterViewVc.h"

@implementation CenterViewVc
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = Util_CenterViewVc_Title;
    [self loadNaviControl];
    self.view.backgroundColor = RGB_GRAY_BG;
    self.tbView.frame = CGRectMake(0, 0, Util_View_Width, Util_View_Height-Util_TabBar_Height);
    self.tbView.rowHeight = 44;
    
    self.arrSource = @[@"CollectionViewVc"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
#pragma mark - UITableViewDelegate/UITableViewDataSource
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* identy = @"indenty";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identy];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundColor = [UIColor whiteColor];
    }
    cell.textLabel.text = self.arrSource[indexPath.section];
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.arrSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Util_View_Width, 10)];
    view.backgroundColor = RGB_GRAY_BG;
    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSArray* arr = @[@"CollectionViewVc"];
    [self.navigationController pushViewController:[NSClassFromString(arr[indexPath.section]) new] animated:YES];
}
@end
