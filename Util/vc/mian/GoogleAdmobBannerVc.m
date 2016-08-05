//
//  GoogleAdmobBannerVc.m
//  Util
//
//  Created by chenliang on 16/8/3.
//  Copyright © 2016年 chenliang. All rights reserved.
//

#import "GoogleAdmobBannerVc.h"
#import <GoogleMobileAds/GADBannerView.h>

@interface GoogleAdmobBannerVc ()<GADBannerViewDelegate>
@property(nonatomic,strong)GADBannerView* bannerView;
@end

@implementation GoogleAdmobBannerVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = Util_GoogleAdmobBannerVc_Title;
    [self loadNaviControl];

    [self loadBanner];
    // Do any additional setup after loading the view.
}

-(void)loadBanner
{
    GADRequest *request = [GADRequest request];
    CGPoint origin = CGPointMake(0.0, 64.0);

    //GADAdSizeFromCGSize(CGSizeMake([UIScreen mainScreen].bounds.size.width, 50))
    GADBannerView* view = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner origin:origin];
    view.adUnitID = GoogleAdmobBannerID;
    view.delegate = self;
    [view setRootViewController:self];
    [self.view addSubview:view];
    [view loadRequest:request];
    
    self.bannerView = view;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)adView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error
{
    NSLog(@"%@",error);
}

- (void)adViewDidReceiveAd:(GADBannerView *)bannerView
{
    NSLog(@"%@",[self class]);
}

- (void)adViewWillPresentScreen:(GADBannerView *)bannerView
{
    NSLog(@"1111");
}

/// Tells the delegate that the full screen view will be dismissed.
- (void)adViewWillDismissScreen:(GADBannerView *)bannerView
{
    NSLog(@"2222");
}

/// Tells the delegate that the full screen view has been dismissed. The delegate should restart
/// anything paused while handling adViewWillPresentScreen:.
- (void)adViewDidDismissScreen:(GADBannerView *)bannerView
{
    NSLog(@"3333");
}

/// Tells the delegate that the user click will open another app, backgrounding the current
/// application. The standard UIApplicationDelegate methods, like applicationDidEnterBackground:,
/// are called immediately before this method is called.
- (void)adViewWillLeaveApplication:(GADBannerView *)bannerView
{
    [self.bannerView removeFromSuperview];
    NSLog(@"4444");
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
