//
//  DDMagnifierView.m
//  EmotionView
//
//  Created by 4399 on 15/7/2.
//  Copyright (c) 2015年 xiaomutou. All rights reserved.
//

#import "DDMagnifierView.h"

@interface DDMagnifierView() {
    
    
    UIImageView *imageView;
    UILabel *titleLbel;
}




@end
@implementation DDMagnifierView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width / 2 - 15, 10, 30, 30)];
//        imageView.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
        [self addSubview:imageView];
        
        titleLbel = [[UILabel alloc] initWithFrame:CGRectMake(0 , imageView.frame.origin.y + 30, self.bounds.size.width, 15)];
        titleLbel.textColor = [UIColor blackColor];
        titleLbel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLbel];
    }
    return self;
}

-(void)setImage:(UIImage *)image {
    
    _image = image;
    imageView.image = image;
}

- (void)setTitle:(NSString *)title {
    
    _title = title;
    titleLbel.text = title;
}
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
}



@end
