//
//  ViewController.m
//  ADCountDownButtonDEMO
//
//  Created by CuiPanJun on 15-3-27.
//  Copyright (c) 2015年 CuiPanJun. All rights reserved.
//

#import "ViewController.h"
#import "ADCountDownButton.h"

@interface ViewController ()

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
    
}

- (void)updateTimer{
    static NSTimeInterval seconds = 1;
    self.title = [NSString stringWithFormat:@"%.0f",seconds];
    seconds++;
}

- (void)getCaptcha:(id)sender{
    
    NSLog(@"send request ..........");
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
