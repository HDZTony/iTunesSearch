//
//  HDZYouLikeHeadView.m
//  iTunesSearch
//
//  Created by 何东洲 on 2018/4/23.
//  Copyright © 2018年 何东洲. All rights reserved.
//

#import "HDZYouLikeHeadView.h"
#import <Masonry.h>
@implementation HDZYouLikeHeadView
#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    _likeImageView = [[UIImageView alloc] init];
    _likeImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_likeImageView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_likeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(150, 25));
    }];
}

@end
