//
//  ADCountDownButton.h
//  MMBangADDemoProject
//
//  Created by CuiPanJun on 15-3-27.
//  Copyright (c) 2015年 CuiPanJun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ADCountDownButton;

typedef void(^ADCountDownButtonWillStartBlock) (ADCountDownButton *button);
typedef void(^ADCountDownButtonDidStartBlock) (ADCountDownButton *button);
typedef void(^ADCountDownButtonUpdatedBlock) (ADCountDownButton *button);
typedef void(^ADCountDownButtonFinishedBlock) (ADCountDownButton *button, BOOL finished);

@interface ADCountDownButton : UIButton

@property (nonatomic, assign) NSTimeInterval totalTime;
@property (nonatomic, readonly) NSTimeInterval secondsLeft;
@property (nonatomic, readonly) BOOL counting;

@property (nonatomic, copy) ADCountDownButtonWillStartBlock willStartBlock;
@property (nonatomic, copy) ADCountDownButtonDidStartBlock didStartBlock;
@property (nonatomic, copy) ADCountDownButtonUpdatedBlock updatedBlock;
@property (nonatomic, copy) ADCountDownButtonFinishedBlock finishedBlock;

- (void)start;
- (void)stop;
- (void)reset;

@end
