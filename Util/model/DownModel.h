//
//  DownModel.h
//  DownTaskDemo
//
//  Created by chenliang on 16/6/24.
//  Copyright © 2016年 chenliang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class DownModel;

typedef NS_ENUM(NSInteger,DownStatus){
    DownStatusNone = 0,         //默认状态,初始化默认值
    DownStatusRunning = 1,      //下载中
    DownStatusSuspended = 2,    //下载暂停
    DownStatusCompleted = 3,    //下载完成
    DownStatusFailed = 4,       //下载失败
    DownStatusWaiting = 5,      //等待下载
    DownStatusCancel = 6        //取消下载
};

//下载进度和状态  实时更新
typedef void(^HYBVideoStatusChanged)(DownModel *model);         //下载状态
typedef void(^HYBVideoProgressChanged)(DownModel *model);       //下载进度


@interface DownModel : NSObject
/**
 *  下载Url
 */
@property(nonatomic,strong)NSString*  nUrl;
/**
 *  文件Id
 */
@property(nonatomic,strong)NSString*  fielId;
/**
 *  文件name
 */
@property(nonatomic,strong)NSString*  fileName;
/**
 *  文件logo
 */
@property(nonatomic,strong)NSString*  fileImage;
/**
 *  缓存data,用于断点下载
 */
@property(nonatomic,strong)NSData*   resume;
/**
 *  缓存路径,用于断点下载(退出App之后下次下载)
 */
@property(nonatomic,strong)NSString* filePathResume;
/**
 *  下载完成后路径
 */
@property(nonatomic,strong)NSString* filePath;
/**
 *  下载进度文本
 */
@property(nonatomic,strong)NSString* progressText;
/**
 *  下载进度
 */
@property(nonatomic,assign)CGFloat progress;
/**
 *  当前下载状态
 */
@property(nonatomic,assign)DownStatus status;
/**
 *  当前下载状态文本(显示)
 */
@property(nonatomic,strong)NSString* statusText;

@property (nonatomic, copy) HYBVideoStatusChanged onStatusChanged;
@property (nonatomic, copy) HYBVideoProgressChanged onProgressChanged;

/**
 *  task
 *  NSURLSessionDownloadTask *task;
 */
@property(nonatomic,strong)NSURLSessionDownloadTask *task;
@end
