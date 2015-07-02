//
//  DDEmotionScrollView.m
//  EmotionView
//
//  Created by 4399 on 15/7/2.
//  Copyright (c) 2015年 xiaomutou. All rights reserved.
//

#import "DDEmotionScrollView.h"


@interface DDEmotionScrollView()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView  *emotionScrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) DDEmotionView *emotionView;
@end


@implementation DDEmotionScrollView


#pragma mark - Life
-(instancetype)initWithDDEmotionSelectBlock:(DDEmotionSelectBlock)block {
    
    return [self initWithFrame:CGRectZero selectBlock:block];
}

-(instancetype)initWithFrame:(CGRect)frame selectBlock:(DDEmotionSelectBlock)block{

    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.backgroundColor = [UIColor grayColor];
        self.emotionView.selectBlock = block;
        
        [self addSubview:self.emotionScrollView];
        [self addSubview:self.pageControl];
        
        [self updateFrame:frame];
    }
    return self;
}

- (void)updateFrame:(CGRect)frame {
    
    frame.size.width = self.emotionScrollView.frame.size.width;
    frame.size.height +=self.emotionScrollView.frame.size.height + 20;
    self.frame = frame;
}


#pragma mark - scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)_scrollView{
    
    int pageNumber = _scrollView.contentOffset.x/320;
    _pageControl.currentPage = pageNumber;
}

#pragma mark - Getter And Setter

-(UIScrollView *)emotionScrollView {
    
    if (!_emotionScrollView) {
   
        _emotionScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, DDScreenWidth, self.emotionView.frame.size.height)];
        _emotionScrollView.contentSize = CGSizeMake(self.emotionView.frame.size.width, self.emotionView.frame.size.height);
        _emotionScrollView.pagingEnabled = YES;
        _emotionScrollView.showsHorizontalScrollIndicator = NO;
        _emotionScrollView.clipsToBounds = NO;
        _emotionScrollView.delegate = self;
        [_emotionScrollView addSubview:self.emotionView];
    }
    
    return _emotionScrollView;
}

- (DDEmotionView *)emotionView {
    
    if (!_emotionView) {
        _emotionView =  [[DDEmotionView alloc] initWithFrame:CGRectZero];
    }
    return _emotionView;
}

-(UIPageControl *)pageControl {
    
    if (!_pageControl) {
        
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(-20, self.emotionScrollView.frame.size.height, 40, 20)];
        _pageControl.backgroundColor = [UIColor clearColor];
        _pageControl.currentPage = 0;
        _pageControl.numberOfPages = self.emotionView.emotionPages.count;
    }
    return _pageControl;
}
@end
