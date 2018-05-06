//
//  HDZGoodsYouLikeCell.m
//  iTunesSearch
//
//  Created by 何东洲 on 2018/4/23.
//  Copyright © 2018年 何东洲. All rights reserved.
//

#import "HDZGoodsYouLikeCell.h"
#import "HDZRecommendItem.h"
#import <UIImageView+WebCache.h>
#import "HDZSpeedy.h"
#import <Masonry.h>
#define cellWH ScreenW * 0.5 - 50
@interface HDZGoodsYouLikeCell()

/* 图片 */
@property (strong , nonatomic)UIImageView *goodsImageView;
/* 标题 */
@property (strong , nonatomic)UILabel *goodsLabel;
/* 价格 */
@property (strong , nonatomic)UILabel *priceLabel;

@end
@implementation HDZGoodsYouLikeCell

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}

- (void) setUpUI{
    _goodsImageView = [[UIImageView alloc] init];
    _goodsImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_goodsImageView];
    
    _goodsLabel = [[UILabel alloc] init];
    _goodsLabel.font = Font12;
    _goodsLabel.numberOfLines = 2;
    [self addSubview:_goodsLabel];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.textColor = [UIColor redColor];
    _priceLabel.font = Font15;
    [self addSubview:_priceLabel];
    
    _sameButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _sameButton.titleLabel.font = Font10;
    [_sameButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_sameButton setTitle:@"看相似" forState:UIControlStateNormal];
    [_sameButton addTarget:self action:@selector(lookSameGoods) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_sameButton];
    [HDZSpeedy hdz_changeControlCircularWith:_sameButton AndSetCornerRadius:0 SetBorderWidth:1.0 SetBorderColor:[UIColor darkGrayColor] canMasksToBounds:YES];
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        [make.top.mas_equalTo(self)setOffset:HDZMargin];
        make.size.mas_equalTo(CGSizeMake(cellWH , cellWH));
        
    }];
    
    [_goodsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(self).multipliedBy(0.8);
        make.height.mas_equalTo(40);
        [make.top.mas_equalTo(_goodsImageView.mas_bottom)setOffset:HDZMargin];
        
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_goodsImageView);
        make.width.mas_equalTo(self).multipliedBy(0.5);
        make.top.mas_equalTo(_goodsLabel.mas_bottom);
        
    }];
    
    [_sameButton mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.right.mas_equalTo(self)setOffset:-HDZMargin];
        make.centerY.mas_equalTo(_priceLabel);
        make.size.mas_equalTo(CGSizeMake(35, 18));
    }];
}

#pragma mark - Setter Getter Methods
- (void)setYouLikeItem:(HDZRecommendItem *)youLikeItem
{
    [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:youLikeItem.image_url]];
    _priceLabel.text = [NSString stringWithFormat:@"¥ %.2f",[youLikeItem.price floatValue]];
    _goodsLabel.text = youLikeItem.main_title;
}

#pragma mark - 点击事件
- (void)lookSameGoods
{
    !_lookSameBlock ? : _lookSameBlock();
}

@end
