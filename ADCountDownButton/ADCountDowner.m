//
//  ADCountDowner.m
//  ADCountDownButtonDEMO
//
//  Created by CuiPanJun on 15/5/21.
//  Copyright (c) 2015年 CuiPanJun. All rights reserved.
//


#import "ADCountDowner.h"

typedef NS_ENUM(NSUInteger, ADCountDownerState){
    ADCountDownerStateNormal    = 0,
    ADCountDownerStateCounting  = 1,
    ADCountDownerStateStop      = 2
};

@interface ADCountDowner ()

@property (nonatomic, assign) ADCountDownerState countState;

@property (nonatomic, assign) NSTimer *timer;

@property (nonatomic, assign) BOOL didSetExpireTimeInterval;
@property (nonatomic, assign) NSTimeInterval expireTimeInterval;

@end

@implementation ADCountDowner

- (void)commonInit{
    
}

- (void)setupTimer{
    if (_timer) {
        [_timer invalidate];
    }
    
    // see http://stackoverflow.com/a/4949665
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR )
    // fire while tracking touches
    [[NSRunLoop mainRunLoop] addTimer: _timer
                              forMode: UITrackingRunLoopMode];
#else
    // fire while tracking mouse events
    [[NSRunLoop mainRunLoop] addTimer: _timer
                              forMode: NSEventTrackingRunLoopMode];
    // fire while showing application-modal panels/alerts
    [[NSRunLoop mainRunLoop] addTimer: _timer
                              forMode: NSModalPanelRunLoopMode];
#endif
}

- (void)invalidTimer{
    if ([_timer isValid]) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)start{
    if (![self isValid]) {
        return;
    }
    
    self.countState = ADCountDownerStateCounting;
    [self setupExpireTime];
    __weak __typeof(self)weakSelf = self;
    if (self.willStartBlock) {
        self.willStartBlock(weakSelf);
    }
    [self setupTimer];
    if (self.didStartBlock) {
        self.didStartBlock(weakSelf);
    }
}

- (void)stop
{
    [self stopCount];
    __weak __typeof(self)weakSelf = self;
    if (self.finishedBlock) {
        self.finishedBlock(weakSelf, NO);
    }
}

- (void)reset{
    [self invalidTimer];
    self.countState = ADCountDownerStateNormal;
    self.didSetExpireTimeInterval = NO;
    
}

- (BOOL)isValid{
    return !(self.didSetExpireTimeInterval && ([self secondsLeft] <= 0));
}

// private
- (void)stopCount{
    [self invalidTimer];
    self.countState = ADCountDownerStateStop;
}

- (void)setupExpireTime{
    if (self.didSetExpireTimeInterval) {
        return;
    }
    self.didSetExpireTimeInterval = YES;
    self.expireTimeInterval = [[NSDate date] timeIntervalSince1970] + self.totalTime;
    
}


- (void)updateTimer
{
    
    NSTimeInterval left = [self secondsLeft];
    NSLog(@"left:%.0f",left);
    __weak __typeof(self)weakSelf = self;
    if (left > 0) {
        
        if (self.updatedBlock) {
            self.updatedBlock(weakSelf);
        }
        
    }else{
        
        [self stopCount];
        if (self.finishedBlock) {
            self.finishedBlock(weakSelf,YES);
        }
    }
}

#pragma mark - State

#pragma mark - Property

- (void)setTotalTime:(NSTimeInterval)totalTime{
    if (totalTime < 0) return;
    _totalTime = totalTime;
    self.didSetExpireTimeInterval = NO;
    [self invalidTimer];
}

- (NSTimeInterval)secondsLeft{
    NSTimeInterval left = self.totalTime;
    if (self.didSetExpireTimeInterval) {
        left  = self.expireTimeInterval - [[NSDate date] timeIntervalSince1970];
    }
    if (left <= 0.0f) {
        left = 0.0f;
    }
    return left;
}

- (BOOL)counting{
    return self.countState == ADCountDownerStateCounting;
}

- (BOOL)stopped{
    return self.countState == ADCountDownerStateStop;
}

@end
