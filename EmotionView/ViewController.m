//
//  ViewController.m
//  EmotionView
//
//  Created by lovelydd on 15/7/2.
//  Copyright (c) 2015年 xiaomutou. All rights reserved.
//

#import "ViewController.h"
#import "DDEmotionScrollView.h"
#import "DDMagnifierView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    DDEmotionScrollView *scrollView = [[DDEmotionScrollView alloc] initWithDDEmotionSelectBlock:^(NSString *emotionName) {
        
        
        NSLog(@"选择的表情名字是:%@",emotionName);
    }];
    
    CGRect frame = scrollView.frame;
    frame.origin.y = 200;
    scrollView.frame = frame;
    [self.view addSubview:scrollView];
    
//    self.view.backgroundColor = [UIColor grayColor];
//    DDMagnifierView *magnifierView = [[DDMagnifierView alloc] init];
//    [self.view addSubview:magnifierView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
