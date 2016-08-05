//
//  BlockView.m
//  Util
//
//  Created by chenliang on 16/8/1.
//  Copyright © 2016年 chenliang. All rights reserved.
//

#import "BlockView.h"

@implementation BlockView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithBlock:(CGRect)frame  block:(cycleReference)block
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UITapGestureRecognizer* gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesClick:)];
        [self addGestureRecognizer:gesture];
        
        self.block = block;
    }
    return self;
}

-(void)gesClick:(UITapGestureRecognizer*)gesture
{
    self.block(YES);
}

- (void)dealloc {
    NSLog(@"dealloc: %@", [[self class] description]);
}
@end
