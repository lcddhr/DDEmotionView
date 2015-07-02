//
//  DDEmotionView.h
//  EmotionView
//
//  Created by lovelydd on 15/7/2.
//  Copyright (c) 2015年 xiaomutou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDEmotionViewConfig.h"


typedef void(^DDEmotionSelectBlock)(NSString *emotionName);

@interface DDEmotionView : UIView

@property (nonatomic, strong)  NSMutableArray *emotionPages;

@property (nonatomic, copy) DDEmotionSelectBlock selectBlock;

@end
