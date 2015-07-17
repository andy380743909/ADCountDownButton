//
//  ADCountDowner.h
//  ADCountDownButtonDEMO
//
//  Created by CuiPanJun on 15/5/21.
//  Copyright (c) 2015年 CuiPanJun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class ADCountDowner;

typedef void(^ADCountDownerWillStartBlock) (ADCountDowner *countdowner);
typedef void(^ADCountDownerDidStartBlock) (ADCountDowner *countdowner);
typedef void(^ADCountDownerUpdatedBlock) (ADCountDowner *countdowner);
typedef void(^ADCountDownerFinishedBlock) (ADCountDowner *countdowner, BOOL finished);

@interface ADCountDowner : NSObject

@property (nonatomic, assign) NSTimeInterval totalTime;
@property (nonatomic, readonly) NSTimeInterval secondsLeft;
@property (nonatomic, readonly) BOOL counting;

@property (nonatomic, copy) ADCountDownerWillStartBlock willStartBlock;
@property (nonatomic, copy) ADCountDownerDidStartBlock didStartBlock;
@property (nonatomic, copy) ADCountDownerUpdatedBlock updatedBlock;
@property (nonatomic, copy) ADCountDownerFinishedBlock finishedBlock;

- (void)start;
- (void)stop; // pause
- (void)reset;

@end
