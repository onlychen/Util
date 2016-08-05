//
//  BaseListVc.h
//  Util
//
//  Created by chenliang on 16/7/19.
//  Copyright © 2016年 chenliang. All rights reserved.
//

#import "BaseVc.h"

@interface BaseListVc : BaseVc
/*基类TabView**/
@property(nonnull,nonatomic,strong)UITableView*  tbView;
/*Tab数据源**/
@property(nonnull,nonatomic,strong)NSMutableArray* arrSource;
/*cell行高*/
@property(nonatomic,assign)CGFloat  cellHeight;

@end
