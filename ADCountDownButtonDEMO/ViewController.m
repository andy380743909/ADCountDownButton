//
//  ViewController.m
//  ADCountDownButtonDEMO
//
//  Created by CuiPanJun on 15-3-27.
//  Copyright (c) 2015年 CuiPanJun. All rights reserved.
//

#import "ViewController.h"
#import "ADCountDownButton.h"

#import "ADCountDowner.h"

@interface ViewController ()<UIAlertViewDelegate>

@property (nonatomic, strong) ADCountDowner *countdowner;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    ADCountDownButton *countButton = [[ADCountDownButton alloc] initWithFrame:CGRectMake(60, 100, 60, 21)];
    countButton.backgroundColor = [UIColor yellowColor];
    CALayer *layer = countButton.layer;
    layer.cornerRadius = 10;
    countButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    countButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    [countButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [countButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [countButton setTitle:@"验证码" forState:UIControlStateNormal];
    countButton.totalTime = 6;
    countButton.didStartBlock = ^(ADCountDownButton *abutton){
        NSString *timeLeftString = [NSString stringWithFormat:@"重新发送(%0.f)",abutton.secondsLeft];
        [abutton setTitle:timeLeftString forState:UIControlStateNormal];
        [abutton setTitle:timeLeftString forState:UIControlStateDisabled];
    };
    countButton.updatedBlock = ^(ADCountDownButton *abutton){
        NSString *timeLeftString = [NSString stringWithFormat:@"重新发送(%0.f)",abutton.secondsLeft];
        [abutton setTitle:timeLeftString forState:UIControlStateNormal];
        [abutton setTitle:timeLeftString forState:UIControlStateDisabled];
    };
    countButton.finishedBlock = ^(ADCountDownButton *abutton, BOOL finished){
        NSString *titleString = @"验证码";
        [abutton setTitle:titleString forState:UIControlStateNormal];
        [abutton setTitle:titleString forState:UIControlStateDisabled];
        [abutton reset];
    };
    
    [countButton addTarget:self action:@selector(getCaptcha:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:countButton];
    
    countButton = [[ADCountDownButton alloc] initWithFrame:CGRectMake(60, 180, 60, 21)];
    countButton.backgroundColor = [UIColor yellowColor];
    layer = countButton.layer;
    layer.cornerRadius = 10;
    countButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    countButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    [countButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [countButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [countButton setTitle:@"验证码" forState:UIControlStateNormal];
    countButton.totalTime = 6;
    countButton.didStartBlock = ^(ADCountDownButton *abutton){
        NSString *timeLeftString = [NSString stringWithFormat:@"重新发送(%0.f)",abutton.secondsLeft];
        [abutton setTitle:timeLeftString forState:UIControlStateNormal];
        [abutton setTitle:timeLeftString forState:UIControlStateDisabled];
    };
    countButton.updatedBlock = ^(ADCountDownButton *abutton){
        NSString *timeLeftString = [NSString stringWithFormat:@"重新发送(%0.f)",abutton.secondsLeft];
        [abutton setTitle:timeLeftString forState:UIControlStateNormal];
        [abutton setTitle:timeLeftString forState:UIControlStateDisabled];
    };
    countButton.finishedBlock = ^(ADCountDownButton *abutton, BOOL finished){
        NSString *titleString = @"验证码";
        [abutton setTitle:titleString forState:UIControlStateNormal];
        [abutton setTitle:titleString forState:UIControlStateDisabled];
        [abutton reset];
    };
    
    [countButton addTarget:self action:@selector(getCaptcha:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:countButton];
    
    
    CGRect bounds = self.view.bounds;
    
    UIButton *skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
    skipButton.frame = CGRectMake(CGRectGetWidth(bounds) - 100 - 30, 20, 100, 26);
    skipButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
    
    [skipButton setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.3]];
    CALayer *buttonLayer = skipButton.layer;
    buttonLayer.cornerRadius = 5;
    buttonLayer.masksToBounds = YES;
    
    [skipButton addTarget:self action:@selector(skipButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:skipButton];
    
    // ADCountDowner
    
    self.countdowner = [[ADCountDowner alloc] init];
    self.countdowner.totalTime = 10.0f;
    
    self.countdowner.willStartBlock = ^(ADCountDowner *counter){
    
    };
    
    self.countdowner.didStartBlock = ^(ADCountDowner *counter){
        NSString *timeLeftString = [NSString stringWithFormat:@"%0.f 跳过",counter.secondsLeft];
        [skipButton setTitle:timeLeftString forState:UIControlStateNormal];
        [skipButton setTitle:timeLeftString forState:UIControlStateDisabled];
    };
    self.countdowner.updatedBlock = ^(ADCountDowner *counter){
        NSString *timeLeftString = [NSString stringWithFormat:@"%0.f 跳过",counter.secondsLeft];
        [skipButton setTitle:timeLeftString forState:UIControlStateNormal];
        [skipButton setTitle:timeLeftString forState:UIControlStateDisabled];
    };
    self.countdowner.finishedBlock = ^(ADCountDowner *counter, BOOL finished){
        NSString *titleString = @"跳过";
        [skipButton setTitle:titleString forState:UIControlStateNormal];
        [skipButton setTitle:titleString forState:UIControlStateDisabled];
        
        // 如果是调用stop方法 导致finishedBlock被触发，
        if (!finished) {
            [counter reset];
        }
    };
    
    [self.countdowner start];
    
    
}

- (void)updateTimer{
    static NSTimeInterval seconds = 1;
    self.title = [NSString stringWithFormat:@"%.0f",seconds];
    seconds++;
}

- (void)getCaptcha:(id)sender{
    
    ADCountDownButton *button = (ADCountDownButton *)sender;
    [button start];
    
    NSLog(@"send request ..........");
    
}

- (void)skipButtonClicked:(id)sender{
    
    if ([self.countdowner counting]) {
        UIAlertView *skipAlert = [[UIAlertView alloc] initWithTitle:@""
                                                            message:@"你确定要跳过吗？"
                                                           delegate:self
                                                  cancelButtonTitle:@"不，谢谢"
                                                  otherButtonTitles:@"跳过", nil];
        
        [skipAlert show];
    }else{
        [self.countdowner start];
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex != alertView.cancelButtonIndex) {
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
