//
//  HDZCountDownHeadView.m
//  iTunesSearch
//
//  Created by 何东洲 on 2018/4/23.
//  Copyright © 2018年 何东洲. All rights reserved.
//

#import "HDZCountDownHeadView.h"
#import "HDZTextImageSeparateButton.h"
#import "UIView+Frame.h"
@interface HDZCountDownHeadView()
/* 红色块 */
@property (strong , nonatomic)UIView *redView;
/* 时间 */
@property (strong , nonatomic)UILabel *timeLabel;
/* 倒计时 */
@property (strong , nonatomic)UILabel *countDownLabel;
/* 好货秒抢 */
@property (strong , nonatomic)UIButton *quickButton;
@end
@implementation HDZCountDownHeadView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    self.backgroundColor = [UIColor whiteColor];
    _redView = [[UIView alloc] init];
    _redView.backgroundColor = [UIColor redColor];
    [self addSubview:_redView];
    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.text = @"6点场";
    _timeLabel.font = Font16;
    [self addSubview:_timeLabel];
    
    _countDownLabel = [[UILabel alloc] init];
    _countDownLabel.textColor = [UIColor redColor];
    _countDownLabel.text = @"05 : 58 : 33";
    _countDownLabel.font = Font14;
    [self addSubview:_countDownLabel];
    
    _quickButton = [HDZTextImageSeparateButton buttonWithType:UIButtonTypeCustom];
    _quickButton.titleLabel.font = Font12;
    [_quickButton setImage:[UIImage imageNamed:@"shouye_icon_jiantou"] forState:UIControlStateNormal];
    [_quickButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_quickButton setTitle:@"好货秒抢" forState:UIControlStateNormal];
    _quickButton.backgroundColor = HDZRandomColor;
    [self addSubview:_quickButton];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    _redView.frame = CGRectMake(0, 10, 8, 20);
    _timeLabel.frame = CGRectMake(20, 0, 60, self.hdz_height);
    _countDownLabel.frame = CGRectMake(CGRectGetMaxX(_timeLabel.frame), 0, 100, self.hdz_height);
    _quickButton.frame = CGRectMake(self.hdz_width - 70, 0, 70, self.hdz_height);
}
@end
