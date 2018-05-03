//
//  HDZGoodsSurplusCell.m
//  iTunesSearch
//
//  Created by 何东洲 on 2018/5/2.
//  Copyright © 2018年 何东洲. All rights reserved.
//

#import "HDZGoodsSurplusCell.h"
#import <Masonry.h>
#import "UIView+Frame.h"
#import <UIImageView+WebCache.h>
#import "HDZRecommendItem.h"
@interface HDZGoodsSurplusCell()
/* 图片 */
@property (strong , nonatomic)UIImageView *goodsImageView;
/* 价格 */
@property (strong , nonatomic)UILabel *priceLabel;
/* 剩余 */
@property (strong , nonatomic)UILabel *stockLabel;
/* 属性 */
@property (strong , nonatomic)UILabel *natureLabel;
@end
@implementation HDZGoodsSurplusCell
#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}
#pragma mark -UI
- (void)setUpUI{
    self.goodsImageView = [[UIImageView alloc] init];
    self.goodsImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_goodsImageView];
    
    self.priceLabel = [[UILabel alloc] init];
    self.priceLabel.font = Font12;
    self.priceLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_priceLabel];
    
    self.stockLabel = [[UILabel alloc] init];
    self.stockLabel.textColor = [UIColor darkGrayColor];
    self.stockLabel.font = Font10;
    self.stockLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_stockLabel];
    
    self.natureLabel = [[UILabel alloc] init];
    self.natureLabel.textAlignment = NSTextAlignmentCenter;
    self.natureLabel.backgroundColor = [UIColor redColor];
    self.natureLabel.font = Font10;
    self.natureLabel.textColor = [UIColor whiteColor];
    [self.goodsImageView addSubview:_natureLabel];
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self);
        make.width.mas_equalTo(self).multipliedBy(0.8);
        make.height.mas_equalTo(self.hdz_width * 0.8);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.top.mas_equalTo(self.goodsImageView.mas_bottom)setOffset:2];
        make.centerX.mas_equalTo(self);
    }];
    
    [self.stockLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.top.mas_equalTo(self.priceLabel.mas_bottom)setOffset:2];
        make.centerX.mas_equalTo(self);
    }];
    
    [self.natureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.goodsImageView.mas_bottom);
        make.left.mas_equalTo(self.goodsImageView);
        make.size.mas_equalTo(CGSizeMake(30, 15));
    }];
}

#pragma mark - Setter Getter Methods
- (void)setRecommendItem:(HDZRecommendItem *)recommendItem
{
    _recommendItem = recommendItem;
    
    [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:recommendItem.image_url]];
    
    _priceLabel.text = ([recommendItem.price integerValue] >= 10000) ? [NSString stringWithFormat:@"¥ %.2f万",[recommendItem.price floatValue] / 10000.0] : [NSString stringWithFormat:@"¥ %.2f",[recommendItem.price floatValue]];
    
    _stockLabel.text = [NSString stringWithFormat:@"仅剩：%@件",recommendItem.stock];
    _natureLabel.text = recommendItem.nature;
}
@end
