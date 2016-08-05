//
//  UIColor+HexValue.h
//  browserHD
//
//  Created by 羽扁豆 on 12-9-3.
//  Copyright (c) 2012年 2345. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexValue)
+ (UIColor*)colorWithHexValue:(NSString*)hex;
+ (UIColor *)colorWithHex:(uint)hex alpha:(CGFloat)alpha;

@end
