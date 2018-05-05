//
//  HDZTextImageSeparateButton.m
//  iTunesSearch
//
//  Created by 何东洲 on 2018/5/5.
//  Copyright © 2018年 何东洲. All rights reserved.
//

#import "HDZTextImageSeparateButton.h"
#import "UIView+Frame.h"
@implementation HDZTextImageSeparateButton

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    //设置label
    self.titleLabel.hdz_x = 0;
    self.titleLabel.hdz_centerY = self.hdz_centerY;
    [self.titleLabel sizeToFit];
    //设置图片位置
    self.imageView.hdz_x = CGRectGetMaxX(self.titleLabel.frame) + 5;
    self.imageView.hdz_centerY = self.hdz_centerY;
    [self.imageView sizeToFit];
}
@end
