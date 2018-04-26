//
//  HDZGoodsGridCell.m
//  iTunesSearch
//
//  Created by 何东洲 on 2018/4/23.
//  Copyright © 2018年 何东洲. All rights reserved.
//

#import "HDZGoodsGridCell.h"
#import "HDZGridItem.h"
#import <Masonry.h>
#import "UIColor+HDZColorTranslation.h"
#import <UIImageView+WebCache.h>
#import "HDZSpeedy.h"
@interface HDZGoodsGridCell()

/* imageView */
@property (strong , nonatomic)UIImageView *gridImageView;
/* gridLabel */
@property (strong , nonatomic)UILabel *gridLabel;
/* tagLabel */
@property (strong , nonatomic)UILabel *tagLabel;

@end
@implementation HDZGoodsGridCell
#pragma mark - Setter Getter Methods
- (void)setGridItem:(HDZGridItem *)gridItem
{
    _gridItem = gridItem;
    //_gridLabel.text = gridItem.gridTitle;有问题
    /*Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '-[__NSCFDictionary gridTitle]: unrecognized selector sent to instance 0x1c4a76ec0'
     *** First throw call stack:
     (0x1829dad8c 0x181b945ec 0x1829e8098 0x1829e05c8 0x1828c641c 0x100e8712c 0x100e8a4f0 0x18c701fb8 0x18c6e7454 0x18c6e0790 0x18c5af770 0x186b5125c 0x186b553ec 0x186ac1aa0 0x186ae95d0 0x186aea450 0x182982910 0x182980238 0x182980884 0x1828a0da8 0x184883020 0x18c88178c 0x100e6ae54 0x182331fc0)
     libc++abi.dylib: terminating with uncaught exception of type NSException*/
    _gridLabel.text = gridItem.gridTitle;
    _tagLabel.text = gridItem.gridTag;
    _tagLabel.hidden = (gridItem.gridTag.length == 0) ? YES : NO;
    _tagLabel.textColor = [UIColor hdz_colorWithHexString:gridItem.gridColor];
    [HDZSpeedy hdz_changeControlCircularWith:_tagLabel AndSetCornerRadius:5 SetBorderWidth:1 SetBorderColor:_tagLabel.textColor canMasksToBounds:YES];
    if (_gridItem.iconImage.length == 0) return;
    if ([[_gridItem.iconImage substringToIndex:4] isEqualToString:@"http"]) {
        [_gridImageView sd_setImageWithURL:[NSURL URLWithString:gridItem.iconImage]placeholderImage:[UIImage imageNamed:@"default_49_11"]];
    }else{
        _gridImageView.image = [UIImage imageNamed:_gridItem.iconImage];
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    _gridImageView = [[UIImageView alloc] init];
    _gridImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_gridImageView];
    
    _gridLabel = [[UILabel alloc] init];
    _gridLabel.font = Font13;
    _gridLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_gridLabel];
    
    _tagLabel = [[UILabel alloc] init];
    _tagLabel.font = [UIFont systemFontOfSize:8];
    _tagLabel.backgroundColor = [UIColor whiteColor];
    _tagLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_tagLabel];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.gridImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.top.mas_equalTo(self)setOffset:HDZMargin];
        if (iphone47) {
            make.size.mas_equalTo(CGSizeMake(38, 38));
        }else{
            make.size.mas_equalTo(CGSizeMake(45, 45));
        }
        make.centerX.mas_equalTo(self);
    }];
    [self.gridLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        [make.top.mas_equalTo(self.gridImageView.mas_bottom)setOffset:5];
    }];

    [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.gridImageView.mas_centerX);
        make.top.mas_equalTo(self.gridImageView);
        make.size.mas_equalTo(CGSizeMake(35, 15));
    }];
}
@end
