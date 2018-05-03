//
//  HDZGoodsCountDownCell.m
//  iTunesSearch
//
//  Created by 何东洲 on 2018/4/23.
//  Copyright © 2018年 何东洲. All rights reserved.
//

#import "HDZGoodsCountDownCell.h"
#import "HDZGoodsSurplusCell.h"
#import "HDZRecommendItem.h"
#import "UIView+Frame.h"
#import <MJExtension.h>
static NSString *const HDZGoodsSurplusCellID = @"HDZGoodsSurplusCell";
@interface HDZGoodsCountDownCell()<UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout>
/* collection */
@property (nonatomic, strong) UICollectionView *collectionView;
/* 推荐商品数据 */
@property (nonatomic, strong) NSMutableArray<HDZRecommendItem *> *countDownItem;
/* 底部 */
@property (strong , nonatomic)UIView *bottomLineView;
@end
@implementation HDZGoodsCountDownCell

#pragma mark - lazyload
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 1;
        layout.itemSize = CGSizeMake(self.hdz_height * 0.65, self.hdz_height * 0.9);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self addSubview:_collectionView];
        _collectionView.frame = self.bounds;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[HDZGoodsSurplusCell class] forCellWithReuseIdentifier:HDZGoodsSurplusCellID];
    }
    return _collectionView;
}
- (NSMutableArray<HDZRecommendItem *> *)countDownItem
{
    if (!_countDownItem) {
        _countDownItem = [NSMutableArray array];
    }
    return _countDownItem;
}

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    self.collectionView.backgroundColor = self.backgroundColor;
    NSArray *countDownArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CountDownShop.plist" ofType:nil]];
    self.countDownItem = [HDZRecommendItem mj_objectArrayWithKeyValuesArray:countDownArray];
    self.bottomLineView = [[UIView alloc] init];
    self.bottomLineView.backgroundColor = HDZRandomColor;
    [self addSubview:self.bottomLineView];
    self.bottomLineView.frame = CGRectMake(0, self.hdz_height - 8, ScreenW, 8);
    
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
}


- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.countDownItem.count;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    HDZGoodsSurplusCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HDZGoodsSurplusCellID forIndexPath:indexPath];
    cell.recommendItem = self.countDownItem[indexPath.row];
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"点击了计时商品%zd",indexPath.row);
    
}

@end
