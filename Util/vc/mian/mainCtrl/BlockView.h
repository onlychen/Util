//
//  BlockView.h
//  Util
//
//  Created by chenliang on 16/8/1.
//  Copyright © 2016年 chenliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlockView : UIView
@property(nonatomic,strong)cycleReference  block;
-(instancetype)initWithBlock:(CGRect)frame  block:(cycleReference)block;
@end
