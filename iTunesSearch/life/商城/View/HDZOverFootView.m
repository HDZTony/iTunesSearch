//
//  HDZOverFootView.m
//  iTunesSearch
//
//  Created by 何东洲 on 2018/4/23.
//  Copyright © 2018年 何东洲. All rights reserved.
//

#import "HDZOverFootView.h"
#import <Masonry.h>
@interface HDZOverFootView ()


/* label */
@property (strong , nonatomic)UILabel *overLabel;

@end
@implementation HDZOverFootView
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
    _overLabel = [[UILabel alloc] init];
    _overLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_overLabel];
    _overLabel.font = Font16;
    _overLabel.textColor = [UIColor darkGrayColor];
    _overLabel.text = @"看完喽，下次在逛吧";
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_overLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
    }];
}
@end
