//
//  UtilTool.m
//  Util
//
//  Created by chenliang on 16/7/28.
//  Copyright © 2016年 chenliang. All rights reserved.
//

#import "UtilTool.h"

@implementation UtilTool

/**
 *  初始化UIlabel
 *
 *  @param strTitle  标签文本
 *  @param font      标签字体
 *  @param textColor 标签文本
 *
 *  @return Label对象
 */
+(UILabel*)newLabel:(NSString*)strTitle font:(float)font color:(UIColor*)textColor
{
    UILabel* label = [UILabel new];
    label.text = strTitle;
    label.textColor = textColor;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:font];
    return label;
}

@end
