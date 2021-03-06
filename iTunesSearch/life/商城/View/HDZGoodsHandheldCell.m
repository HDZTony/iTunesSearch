//
//  HDZGoodsHandheldCell.m
//  iTunesSearch
//
//  Created by 何东洲 on 2018/4/23.
//  Copyright © 2018年 何东洲. All rights reserved.
//

#import "HDZGoodsHandheldCell.h"
#import <UIImageView+WebCache.h>
#import <Masonry.h>
@interface HDZGoodsHandheldCell()

/* 图片 */
@property (strong , nonatomic)UIImageView *handheldImageView;

@end
@implementation HDZGoodsHandheldCell

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}

#pragma mark - UI
- (void)setUpUI
{
    _handheldImageView = [[UIImageView alloc] init];
    _handheldImageView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:_handheldImageView];
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_handheldImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}

#pragma mark - Setter Getter Methods
- (void)setHandheldImage:(NSString *)handheldImage{
    _handheldImage = handheldImage;   
    [_handheldImageView sd_setImageWithURL:[NSURL URLWithString:handheldImage]];
}
@end
