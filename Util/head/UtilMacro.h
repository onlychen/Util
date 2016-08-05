//
//  UtilMacro.h
//  Util
//
//  Created by chenliang on 16/7/19.
//  Copyright © 2016年 chenliang. All rights reserved.
//

#ifndef UtilMacro_h
#define UtilMacro_h

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#define Util_StatusBar_Height           20
#define Util_NavigationBar_Height       44
#define Util_Up_Height                  64
#define Util_TabBar_Height              49

#define Util_View_Width                 [[UIScreen mainScreen] bounds].size.width
#define Util_View_Height                [[UIScreen mainScreen] bounds].size.height

#define RGBColor(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0]
#define RGBAColor(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

//讯飞key
#define APPID_VALUE           @"5795ccfb"
//google Admob插页式
#define GoogleAdmobFullID       @"ca-app-pub-1865351722858055/2221105720"
//横幅
#define GoogleAdmobBannerID     @"ca-app-pub-1865351722858055/7048258129"

//灰色背景
#define RGB_GRAY_BG     RGBColor(245,245,245)

#endif /* UtilMacro_h */
