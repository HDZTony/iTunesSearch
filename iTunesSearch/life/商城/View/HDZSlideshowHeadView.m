//
//  HDZSlideshowHeadView.m
//  iTunesSearch
//
//  Created by 何东洲 on 2018/4/23.
//  Copyright © 2018年 何东洲. All rights reserved.
//
#import <SDCycleScrollView.h>
#import "HDZSlideshowHeadView.h"
#import "UIView+Frame.h"
@interface HDZSlideshowHeadView()<SDCycleScrollViewDelegate>

/* 轮播图 */
@property (strong , nonatomic)SDCycleScrollView *cycleScrollView;

@end

@implementation HDZSlideshowHeadView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenW,self.hdz_height) delegate:self placeholderImage:nil];
    self.cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    self.cycleScrollView.autoScrollTimeInterval = 2;
    [self addSubview:self.cycleScrollView];
}
-(void)setImageGroupArray:(NSArray *)imageGroupArray{
    _imageGroupArray = imageGroupArray;
    _cycleScrollView.placeholderImage = [UIImage imageNamed:@"default_160"];
    if (imageGroupArray.count == 0) return;
    _cycleScrollView.imageURLStringsGroup = _imageGroupArray;
}

#pragma mark - 点击图片Bannar跳转
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"点击了%zd轮播图",index);
}

#pragma mark - 布局
//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//}
@end
