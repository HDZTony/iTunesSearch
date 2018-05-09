//
//  HDZGoodDetailViewController.m
//  iTunesSearch
//
//  Created by 何东洲 on 2018/5/7.
//  Copyright © 2018年 何东洲. All rights reserved.
//

#import "HDZGoodDetailViewController.h"
#import "HDZGoodBaseViewController.h"
#import "UIView+Frame.h"
@interface HDZGoodDetailViewController ()<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollerView;
@property (strong, nonatomic) UIView *bgView;
/** 记录上一次选中的Button */
@property (nonatomic , weak) UIButton *selectBtn;
/* 标题按钮地下的指示器 */
@property (weak ,nonatomic) UIView *indicatorView;
@end

@implementation HDZGoodDetailViewController

#pragma mark lazyload
- (UIScrollView *)scrollerView{
    if (!_scrollerView) {
        _scrollerView = [[UIScrollView alloc] init];
        _scrollerView.frame = self.view.bounds;
        _scrollerView.showsVerticalScrollIndicator = NO;
        _scrollerView.showsHorizontalScrollIndicator = YES;
        _scrollerView.bounces = NO;
        _scrollerView.delegate = self;
        _scrollerView.backgroundColor = HDZRandomColor;
        [self.view addSubview:_scrollerView];
    }
    return _scrollerView;
}

- (void) setUpChildViewControllers{
    __weak typeof(self) weakSelf = self;
    HDZGoodBaseViewController *goodBaseVC = [[HDZGoodBaseViewController alloc] init];
    [self addChildViewController:goodBaseVC];
    UIViewController *V2 = [[UIViewController alloc] init];
    [self addChildViewController:V2];
    
}

#pragma mark - 底部按钮(收藏 购物车 加入购物车 立即购买)
- (void)setUpBottomButton
{
    [self setUpLeftTwoButton];//收藏 购物车
    
    [self setUpRightTwoButton];//加入购物车 立即购买
}
#pragma mark - 收藏 购物车
- (void)setUpLeftTwoButton
{
    NSArray *imagesNor = @[@"tabr_07shoucang_up",@"tabr_08gouwuche"];
    NSArray *imagesSel = @[@"tabr_07shoucang_down",@"tabr_08gouwuche"];
    CGFloat buttonW = ScreenW * 0.2;
    CGFloat buttonH = 50;
    CGFloat buttonY = ScreenH - buttonH;
    
    for (NSInteger i = 0; i < imagesNor.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:imagesNor[i]] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor whiteColor];
        [button setImage:[UIImage imageNamed:imagesSel[i]] forState:UIControlStateSelected];
        button.tag = i;
        [button addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat buttonX = (buttonW * i);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        [self.view addSubview:button];
    }
}
#pragma mark - 加入购物车 立即购买
- (void)setUpRightTwoButton
{
    NSArray *titles = @[@"加入购物车",@"立即购买"];
    CGFloat buttonW = ScreenW * 0.6 * 0.5;
    CGFloat buttonH = 50;
    CGFloat buttonY = ScreenH - buttonH;
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = Font16;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.tag = i + 2;
        [button setTitle:titles[i] forState:UIControlStateNormal];
        button.backgroundColor = (i == 0) ? [UIColor redColor] : [UIColor colorWithRed:249 green:125 blue:10 alpha:1];
        [button addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat buttonX = ScreenW * 0.4 + (buttonW * i);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        [self.view addSubview:button];
    }
}

#pragma mark - 点击事件
#pragma mark - 头部按钮点击
- (void)topBottonClick:(UIButton *)button{
    button.selected = !button.selected;
    [_selectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _selectBtn = button;
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.indicatorView.hdz_width = button.hdz_width;
        weakSelf.indicatorView.hdz_centerX = button.hdz_centerX;
    }];
    CGPoint offset = self.scrollerView.contentOffset;
    offset.x = _scrollerView.hdz_width * button.tag;
    [_scrollerView setContentOffset:offset animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollerView.contentSize = CGSizeMake(self.view.hdz_width * self.childViewControllers.count, 0);
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    [self setUpTopButtonView];
}

- (void)setUpTopButtonView{
    NSArray *titles = @[@"商品",@"详情"];
    CGFloat margin = 5;
    _bgView = [[UIView alloc] init];
    _bgView.hdz_centerX = ScreenW * 0.5;
    _bgView.hdz_height = 44;
    _bgView.hdz_width = (_bgView.hdz_height + margin) * titles.count;
    _bgView.hdz_y = 0;
    self.navigationItem.titleView = _bgView;
    CGFloat buttonW = _bgView.hdz_height;
    CGFloat buttonH = _bgView.hdz_height;
    CGFloat buttonY = _bgView.hdz_y;
    for (NSInteger i = 0; i < titles.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:titles[i] forState:0];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.tag = i;
        button.titleLabel.font = Font16;
        [button addTarget:self action:@selector(topBottonClick:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat buttonX = i * (buttonW + margin);
        
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        [_bgView addSubview:button];
    }
    UIButton *firstButton = _bgView.subviews[0];
    [self topBottonClick:firstButton]; //默认选择第一个
    
    UIView *indicatorView = [[UIView alloc]init];
    self.indicatorView = indicatorView;
    indicatorView.backgroundColor = [firstButton titleColorForState:UIControlStateSelected];
    
    indicatorView.hdz_height = 2;
    indicatorView.hdz_y = _bgView.hdz_height - indicatorView.hdz_height;
    
    [firstButton.titleLabel sizeToFit];
    indicatorView.hdz_width = firstButton.titleLabel.hdz_width;
    indicatorView.hdz_centerX = firstButton.hdz_centerX;
    
    [_bgView addSubview:indicatorView];
    
}
#pragma mark scrollview delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / scrollView.hdz_width;
    UIButton *button = _bgView.subviews[index];
    [self topBottonClick:button];
}
#pragma mark TabBar
-(BOOL)hidesBottomBarWhenPushed{
    return YES;
}
@end
