//
//  NormalOperation.m
//  Util
//
//  Created by chenliang on 16/8/2.
//  Copyright © 2016年 chenliang. All rights reserved.
//

#import "NormalOperation.h"

@interface NormalOperation () {
    BOOL _isFinished;
    BOOL _isExecuting;
}

@end

@implementation NormalOperation

- (instancetype)initWithUrl:(NSString *)url completion:(NormalDownloadReponse)completion {
    if (self = [super init]) {
        self.url = url;
        self.responseBlock = completion;
    }
    
    return self;
}

// 必须重写这个主方法
- (void)main {
    // 新建一个自动释放池，如果是异步执行操作，那么将无法访问到主线程的自动释放池
    @autoreleasepool {
        // 提供一个变量标识，来表示我们需要执行的操作是否完成了，当然，没开始执行之前，为NO
        BOOL taskIsFinished = NO;
        UIImage *image = nil;
        
        // while 保证：只有当没有执行完成和没有被取消，才执行我们自定义的相应操作
        while (taskIsFinished == NO && [self isCancelled] == NO){
            // 获取图片数据
            NSURL *url = [NSURL URLWithString:self.url];
            NSData *imageData = [NSData dataWithContentsOfURL:url];
            image = [UIImage imageWithData:imageData];
            NSLog(@"Current Thread = %@", [NSThread currentThread]);
            
            // 这里，设置我们相应的操作都已经完成，后面就是要通知KVO我们的操作完成了。
            
            taskIsFinished = YES;
        }
        
        // KVO 生成通知，告诉其他线程，该operation 执行完了
        [self willChangeValueForKey:@"isFinished"];
        [self willChangeValueForKey:@"isExecuting"];
        _isFinished = YES;
        _isExecuting = NO;
        [self didChangeValueForKey:@"isFinished"];
        [self didChangeValueForKey:@"isExecuting"];
        
        if (self.responseBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.responseBlock(image);
            });
        }
    }
}

- (void)start {
    // 如果我们取消了在开始之前，我们就立即返回并生成所需的KVO通知
    if ([self isCancelled]){
        // 我们取消了该 operation，那么就要告诉KVO，该operation已经执行完成（isFinished）
        // 这样，调用的队列（或者线程）会继续执行。
        [self willChangeValueForKey:@"isFinished"];
        _isFinished = NO;
        [self didChangeValueForKey:@"isFinished"];
    } else {
        // 没有取消，那就要告诉KVO，该队列开始执行了（isExecuting）！那么，就会调用main方法，进行同步执行。
        [self willChangeValueForKey:@"isExecuting"];
        _isExecuting = YES;
        [NSThread detachNewThreadSelector:@selector(main) toTarget:self withObject:nil];
        [self didChangeValueForKey:@"isExecuting"];
    }
}

- (BOOL)isExecuting {
    return _isExecuting;
}

- (BOOL)isFinished {
    return _isFinished;
}

@end
