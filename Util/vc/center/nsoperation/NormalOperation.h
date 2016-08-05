//
//  NormalOperation.h
//  Util
//
//  Created by chenliang on 16/8/2.
//  Copyright © 2016年 chenliang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^NormalDownloadReponse)(UIImage *image);

@interface NormalOperation : NSOperation

@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NormalDownloadReponse responseBlock;

-(instancetype)initWithUrl:(NSString *)url completion:(NormalDownloadReponse)completion;
@end

