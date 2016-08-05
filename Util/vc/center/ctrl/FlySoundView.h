//
//  FlySoundView.h
//  Util
//
//  Created by chenliang on 16/7/28.
//  Copyright © 2016年 chenliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FlySoundViewDelegate <NSObject>
-(void)timerActionCallBack;
@end


@interface FlySoundView : UIView
@property(nonatomic,weak)id<FlySoundViewDelegate> delegate;
-(void)resumerTimer;
@end
