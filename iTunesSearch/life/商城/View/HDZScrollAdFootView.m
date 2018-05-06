//
//  HDZScrollAdFootView.m
//  iTunesSearch
//
//  Created by 何东洲 on 2018/4/23.
//  Copyright © 2018年 何东洲. All rights reserved.
//

#import "HDZScrollAdFootView.h"
#import <SDCycleScrollView.h>
#import "UIView+Frame.h"
@interface HDZScrollAdFootView()<SDCycleScrollViewDelegate>
@property (nonatomic, strong)SDCycleScrollView *cycleScrollView;
@end
@implementation HDZScrollAdFootView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenW, self.hdz_height) delegate:self placeholderImage:nil];
    [self addSubview:_cycleScrollView];
    _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    _cycleScrollView.autoScrollTimeInterval = 5;
    _cycleScrollView.imageURLStringsGroup = GoodsFooterImagesArray;
}

#pragma mark - 点击广告跳转
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"点击了%zd广告图",index);
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
}

@end
