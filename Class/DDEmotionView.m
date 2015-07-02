//
//  DDEmotionView.m
//  EmotionView
//
//  Created by lovelydd on 15/7/2.
//  Copyright (c) 2015年 xiaomutou. All rights reserved.
//

#import "DDEmotionView.h"
#import "DDMagnifierView.h"


@interface DDEmotionView() {
    
    NSInteger row;
    NSInteger colum;
    
    NSInteger rowEmotions;
    NSInteger pageEmotions;
}


@property (nonatomic, strong)   DDMagnifierView *magnifierView;
@property (nonatomic, copy)     NSString *selectEmotionName;


@end

@implementation DDEmotionView


#pragma mark - Life
- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self ) {
        
        self.backgroundColor = [UIColor clearColor];
        [self defaultConfig];
    }
    return self;
}

- (void)defaultConfig {
    
    rowEmotions = DDScreenWidth / 45;
    pageEmotions = rowEmotions * 4;
    
    CGRect rect = self.frame;
    rect.size.width = self.emotionPages.count * DDScreenWidth;
    rect.size.height = 4 * DDEmotionItemHeigth;
    self.frame = rect;
    
    [self addSubview:self.magnifierView];
  
}

-(void)drawRect:(CGRect)rect {
    
    row     = 0;
    colum   = 0;
    
    for (NSInteger i = 0 ; i < self.emotionPages.count; i++) {
        
        NSArray *items = self.emotionPages[i];
        
        for (NSInteger j = 0 ; j < items.count; j++) {
            
            NSDictionary *itemDic = items[j];
            NSString *imageName = itemDic[@"png"];
            [self drawImage:imageName
              atPositionRow:row
            atPositionColum:colum
                     atPage:i];
            
            [self updateRowAndcolum];
        }
    }
}

- (void)updateRowAndcolum {
    
    //更新列和行
//    NSInteger count = DDScreenWidth / 45;
    colum++;
    if ((colum % rowEmotions) == 0) {
        row++;
        colum=0;
    }
    if (row == 4) {
        row =  0;
    }
}

- (void)drawImage:(NSString *)imageName atPositionRow:(NSInteger)aRow atPositionColum:(NSInteger)aColum atPage:(NSInteger)pageNum{
    
    CGRect imageFrame = CGRectMake(aColum * DDEmotionItemWidth + 15, aRow * DDEmotionItemHeigth + 15, 30, 30);
    float x = imageFrame.origin.x + (pageNum * DDScreenWidth);
    imageFrame.origin.x = x;
    return [self drawImage:imageName frame:imageFrame];
}

- (void)drawImage:(NSString *)imageName frame:(CGRect)frame  {
    
    UIImage *image = [self imageWithName:imageName];
    [image drawInRect:frame];
}



- (UIImage *)imageWithName:(NSString *)imageName {
   
    NSString *imagePath = [self filePath:imageName];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    return image;
}

- (NSString *)filePath:(NSString *)fileName {
    
    NSString *path = [NSString stringWithFormat:@"%@/%@",DDEmotionBundlePath,fileName];
    return path;
}

#pragma mark - Getter And Setter
-(NSMutableArray *)emotionPages {
    
    if (!_emotionPages) {
        
        _emotionPages = [NSMutableArray array];
        
        NSString *plistPath = [self filePath:DDEmotionPlistName];
        NSArray *items = [NSArray arrayWithContentsOfFile:plistPath];
        
        NSMutableArray *items2D = nil;
        for (NSInteger i = 0; i < items.count; i++) {
            
            NSDictionary *dic = items[i];
           
            if ((i % pageEmotions) == 0) {
                
                items2D = [[NSMutableArray alloc] initWithCapacity:pageEmotions];
                [_emotionPages addObject:items2D];
            }
            [items2D addObject:dic];
        }
    }
    return _emotionPages;
}

-(DDMagnifierView *)magnifierView {
    
    if (!_magnifierView) {
        
        _magnifierView = [[DDMagnifierView alloc] initWithFrame:CGRectMake(0, 0, 64, 92)];
        _magnifierView.hidden = YES;
    
    }
    
    return _magnifierView;
}


#pragma mark - Touch Events
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
     self.magnifierView.hidden = NO;
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    [self touchEmotion:point];
    //NSLog(@"%@",NSStringFromCGPoint(point));
    
    if ([self.superview isKindOfClass:[UIScrollView class]]) {
        
        UIScrollView *scrollView = (UIScrollView *)self.superview;
        scrollView.scrollEnabled = NO;
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
   
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    [self touchEmotion:point];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    self.magnifierView.hidden = YES;
    if ([self.superview isKindOfClass:[UIScrollView class]]) {
        
        UIScrollView *scrollView = (UIScrollView *)self.superview;
        scrollView.scrollEnabled = YES;
    }
    

    if (self.selectBlock) {
        
        self.selectBlock(self.selectEmotionName);
    }
    
}

-(void)touchEmotion:(CGPoint )point{
    
    self.magnifierView.hidden = NO;
    //根据坐标获取表情的名字
    NSString *imageName = [self emotionImageName:point];
    
//    if (![self.selectFaceName isEqualToString:faceName] || self.selectFaceName == nil) {
//        
//        NSString *imageName = [item objectForKey:@"png"];
//        UIImageView *faceItem = (UIImageView*)[magnifierView viewWithTag:2013];
//        faceItem.image = [UIImage imageNamed:imageName];
//        self.selectFaceName = faceName;
//        
//        //计算放大镜的位置
//        magnifierView.left = (page*320) + colum*item_width;
//        magnifierView.bottom = row*item_height+30;
//    }
    
    }

- (NSString *)emotionImageName:(CGPoint)point {
    
    //页数
    NSInteger page = point.x / DDScreenWidth;
    
    CGFloat x = point.x - ( page * DDScreenWidth ) - 10;
    CGFloat y = point.y - 10;
    
    NSInteger aColum = x / DDEmotionItemWidth;
    NSInteger aRow = y / DDEmotionItemHeigth;
    
    if (aColum > rowEmotions - 1) {
        aColum = rowEmotions - 1;
    }
    if (aColum < 0) {
        aColum = 0;
    }
    
    if (aRow > 3) {
        aRow = 3;
    }
    if (aRow < 0) {
        aRow = 0;
    }
    
    NSInteger index = aColum + (aRow * rowEmotions);
    NSArray *items = [self.emotionPages objectAtIndex:page];
    NSDictionary *itemDic = [items objectAtIndex:index];
    NSString *emotionName = [itemDic objectForKey:@"chs"];
    
    if (![self.selectEmotionName isEqualToString:emotionName] || self.selectEmotionName == nil) {
        
        NSString *imageName = [itemDic objectForKey:@"png"];
        UIImage *image = [self imageWithName:imageName];
        self.magnifierView.image = image;
        self.magnifierView.title = emotionName;
        self.selectEmotionName = emotionName;
//
        CGRect rect = self.magnifierView.frame;
        rect.origin.x = ( page * DDScreenWidth ) + aColum * DDEmotionItemWidth;
        rect.origin.y = aRow * DDEmotionItemHeigth - 50;
        self.magnifierView.frame = rect;
    }

    return emotionName;
}


@end
