//
//  HDZNewWelfareCell.m
//  iTunesSearch
//
//  Created by 何东洲 on 2018/4/23.
//  Copyright © 2018年 何东洲. All rights reserved.
//

#import "HDZNewWelfareCell.h"
#import "HDZNewWelfareLayout.h"
#import "HDZGoodsHandheldCell.h"
static NSString *const HDZGoodsHandheldCellID = @"HDZGoodsHandheldCell";
@interface HDZNewWelfareCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,HDZNewWelfareLayoutDelegate>
@property (nonatomic, strong)UICollectionView *collectionView;
@end
@implementation HDZNewWelfareCell
#pragma mark lazyload
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        HDZNewWelfareLayout *layout = [HDZNewWelfareLayout new];
        layout.delegate = self;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.frame = self.bounds;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self addSubview:_collectionView];
        [_collectionView registerClass:[HDZGoodsHandheldCell class] forCellWithReuseIdentifier:HDZGoodsHandheldCellID];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderReusableView"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterReusableView"];
    }
    return _collectionView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpBase];
    }
    return self;
}

#pragma mark - initialize
- (void)setUpBase
{
    self.backgroundColor = [UIColor clearColor];
    self.collectionView.backgroundColor = self.backgroundColor;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    HDZGoodsHandheldCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HDZGoodsHandheldCellID forIndexPath:indexPath];
    NSArray *images = GoodsNewWelfareImagesArray;
    cell.handheldImage = images[indexPath.row];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HeaderReusableView" forIndexPath:indexPath];
        headerView.backgroundColor = HDZRandomColor;
        return headerView;
    } else if (kind == UICollectionElementKindSectionFooter){
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"FooterReusableView" forIndexPath:indexPath];
        footerView.backgroundColor = HDZRandomColor;
        return footerView;
    }
    return [UICollectionReusableView new];
}

#pragma mark - item点击
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"第%zd个item",indexPath.row);
}

#pragma mark - 头部高度
-(CGFloat)hdz_HeightOfSectionHeaderForIndexPath:(NSIndexPath *)indexPath{
    return 0;
}

#pragma mark - 底部高度
-(CGFloat)dc_HeightOfSectionFooterForIndexPath:(NSIndexPath *)indexPath {
    return HDZMargin;
}
@end
