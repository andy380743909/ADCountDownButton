//
//  ADCountDownButton.m
//  MMBangADDemoProject
//
//  Created by CuiPanJun on 15-3-27.
//  Copyright (c) 2015年 CuiPanJun. All rights reserved.
//

#import "ADCountDownButton.h"

typedef NS_ENUM(NSUInteger, ADCountDownButtonState){
    ADCountDownButtonStateNormal    = 0,
    ADCountDownButtonStateCounting  = 1
};

@interface ADCountDownButton ()

@property (nonatomic, assign) ADCountDownButtonState countState;

@property (nonatomic, assign) NSTimer *timer;

@property (nonatomic, assign) BOOL didSetExpireTimeInterval;
@property (nonatomic, assign) NSTimeInterval expireTimeInterval;

@end

@implementation ADCountDownButton

- (void)dealloc{
    [self invalidTimer];
    
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self commonInit];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit{
    
//    [self addTarget:self action:@selector(countDownButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
}


#pragma mark - Action

- (void)countDownButtonClicked:(id)sender{
    [self start];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

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
    
    self.countState = ADCountDownButtonStateCounting;
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
    self.countState = ADCountDownButtonStateNormal;
    [self invalidTimer];
    __weak __typeof(self)weakSelf = self;
    if (self.finishedBlock) {
        self.finishedBlock(weakSelf, NO);
    }
}

- (void)reset{
    [self invalidTimer];
    self.countState = ADCountDownButtonStateNormal;
    self.didSetExpireTimeInterval = NO;
    
}



- (void)setupExpireTime{
    if (self.didSetExpireTimeInterval) {
        return;
    }
    self.didSetExpireTimeInterval = YES;
    self.expireTimeInterval = [[NSDate date] timeIntervalSince1970] + self.totalTime;
    
}

- (BOOL)isValid{
    return !(self.didSetExpireTimeInterval && ([self secondsLeft] <= 0));
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
        
        [self reset];
        if (self.finishedBlock) {
            self.finishedBlock(weakSelf,YES);
        }
    }
}

#pragma mark - State

- (void)setCountState:(ADCountDownButtonState)countState{
    
    switch (countState) {
        case ADCountDownButtonStateNormal:
            
            self.enabled = YES;
            
            break;
        case ADCountDownButtonStateCounting:
            
            self.enabled = NO;
            
            break;
        default:
            break;
    }
    
    
}

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
    return left;
}

- (BOOL)counting{
    return self.counting == ADCountDownButtonStateCounting;
}

@end
