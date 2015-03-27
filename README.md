# ADCountDownButton
a subclass of UIButton with a countdown NSTimer to change the button title

Usage
#####

```

ADCountDownButton *countButton = [[ADCountDownButton alloc] initWithFrame:CGRectMake(30, 100, 60, 21)];
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
    ```
    
