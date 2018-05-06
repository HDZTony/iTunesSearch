//
//  HDZExceedApplianceCell.m
//  iTunesSearch
//
//  Created by 何东洲 on 2018/4/23.
//  Copyright © 2018年 何东洲. All rights reserved.
//

#import "HDZExceedApplianceCell.h"

#import "HDZGoodsHandheldCell.h"
#import <UIImageView+WebCache.h>
#import <Masonry.h>
static NSString *const HDZGoodsHandheldCellID = @"HDZGoodsHandheldCell";

@interface HDZExceedApplianceCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

/* collectionView */
@property (strong , nonatomic)UICollectionView *collectionView;
/* 头部ImageView */
@property (strong , nonatomic)UIImageView *headImageView;
/* 图片数组 */
@property (copy , nonatomic)NSArray *imagesArray;

@end

@implementation HDZExceedApplianceCell

#pragma mark - lazyload
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(100, 100);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self addSubview:_collectionView];
        _collectionView.frame = CGRectMake(0, ScreenW * 0.35 + HDZMargin, ScreenW, 100);
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[HDZGoodsHandheldCell class] forCellWithReuseIdentifier:HDZGoodsHandheldCellID];
    }
    return _collectionView;
}

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
    self.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = self.backgroundColor;
    
    _headImageView = [[UIImageView alloc] init];
    [self addSubview:_headImageView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.left.mas_equalTo(self);
        make.width.mas_equalTo(self);
        make.height.mas_equalTo(ScreenW * 0.32);
    }];
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _imagesArray.count - 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HDZGoodsHandheldCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HDZGoodsHandheldCellID forIndexPath:indexPath];
    cell.handheldImage = _imagesArray[indexPath.row + 1];
    return cell;
}

-(void)setGoodExceedArray:(NSArray *)goodExceedArray{
    _goodExceedArray = goodExceedArray;
    _imagesArray = goodExceedArray;
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:goodExceedArray[0]]];
}
@end
