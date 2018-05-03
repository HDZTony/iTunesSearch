//
//  HDZTopLineFootView.m
//  iTunesSearch
//
//  Created by 何东洲 on 2018/4/23.
//  Copyright © 2018年 何东洲. All rights reserved.
//

#import "HDZTopLineFootView.h"
#import "DCTitleRolling.h"
#import <UIImageView+WebCache.h>
#import "UIView+Frame.h"
#import <Masonry.h>
@interface HDZTopLineFootView()<UIScrollViewDelegate,CDDRollingDelegate>
/* 滚动 */
@property (strong , nonatomic)DCTitleRolling *numericalScrollView;
/* 底部 */
@property (strong , nonatomic)UIView *bottomLineView;
/* 顶部广告宣传图片 */
@property (strong , nonatomic)UIImageView *topAdImageView;
@end
@implementation HDZTopLineFootView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    self.topAdImageView = [[UIImageView alloc] init];
    [self.topAdImageView sd_setImageWithURL:[NSURL URLWithString:HomeBottomViewGIFImage]];
    self.topAdImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.topAdImageView];
    
    self.numericalScrollView = [[DCTitleRolling alloc]initWithFrame:CGRectMake(0, self.hdz_height - 50, self.hdz_width, 50) WithTitleData:^(CDDRollingGroupStyle *rollingGroupStyle, NSString *__autoreleasing *leftImage, NSArray *__autoreleasing *rolTitles, NSArray *__autoreleasing *rolTags, NSArray *__autoreleasing *rightImages, NSString *__autoreleasing *rightbuttonTitle, NSInteger *interval, float *rollingTime, NSInteger *titleFont, UIColor *__autoreleasing *titleColor, BOOL *isShowTagBorder) {
        *rollingTime = 0.25;
        *rolTags = @[@"冬季健康日",@"新手上路",@"年终内购会",@"GitHub星星走一波"];
        *rolTitles = @[@"先领券在购物，一元抢？",@"2000元热门手机推荐",@"好奇么？点进去哈",@"这套家具比房子还贵"];
        *leftImage = @"shouye_img_toutiao";
        *interval = 6.0;
        *titleFont = 14;
        *isShowTagBorder = YES;
        *titleColor = [UIColor darkGrayColor];
    }];
    
    self.numericalScrollView.moreClickBlock = ^{
        NSLog(@"mall----more");
    };
    [self.numericalScrollView dc_beginRolling];
    //self.numericalScrollView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.numericalScrollView];
    
    self.bottomLineView = [[UIView alloc]init];
    self.bottomLineView.backgroundColor = HDZRandomColor;
    [self addSubview:self.bottomLineView];
    self.bottomLineView.frame = CGRectMake(0, self.hdz_height - 8, ScreenW, 8);
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.topAdImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.top.mas_equalTo(self);
        make.width.mas_equalTo(self);
        [make.bottom.mas_equalTo(self)setOffset:-50];
    }];
}
#pragma mark - Setter Getter Methods

#pragma mark - 滚动条点击事件
- (void)dc_RollingViewSelectWithActionAtIndex:(NSInteger)index {
    NSLog(@"点击了第%zd头条滚动条",index);
}


@end
