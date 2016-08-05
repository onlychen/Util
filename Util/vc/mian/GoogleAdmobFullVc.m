//
//  GoogleAdmobFullVc.m
//  Util
//
//  Created by chenliang on 16/8/3.
//  Copyright © 2016年 chenliang. All rights reserved.
//

#import "GoogleAdmobFullVc.h"
#import <GoogleMobileAds/GADBannerView.h>

@interface GoogleAdmobFullVc ()<GADInterstitialDelegate>
@property(nonatomic,strong)GADInterstitial* interstitial;
@end

@implementation GoogleAdmobFullVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = Util_GoogleAdmobFullVc_Title;
    [self loadNaviControl];

    [self createAndLoadInterstitial];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(GADInterstitial*)createAndLoadInterstitial
{
    GADRequest *request = [GADRequest request];
//    request.testDevices = @[ @"1983a510e0667c39b4fb3e5f0e6e4582" ];
    GADInterstitial *interstitial = [[GADInterstitial alloc] initWithAdUnitID:GoogleAdmobFullID];
    interstitial.delegate = self;
    [interstitial loadRequest:request];
    
    self.interstitial = interstitial;
    return interstitial;
    
}

- (void)interstitialDidReceiveAd:(GADInterstitial *)ad
{
    [self.interstitial presentFromRootViewController:self];
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
