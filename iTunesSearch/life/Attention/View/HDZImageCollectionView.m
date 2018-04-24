//
//  HDZImageCollectionView.m
//  iTunesSearch
//
//  Created by 何东洲 on 2018/4/15.
//  Copyright © 2018年 何东洲. All rights reserved.
//

#import "HDZImageCollectionView.h"
#import "HDZImageCollectionLayout.h"
#import "HDZImageCollectionCell.h"
#import "HDZSearch.h"
@interface HDZImageCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)HDZSearch *search;
@end
@implementation HDZImageCollectionView
-(void)setThumbImages:(NSArray<NSString *> *)thumbImages{
    _thumbImages = thumbImages;
    [self reloadData];
}
-(void)awakeFromNib{
    [super awakeFromNib];
    self.search = [[HDZSearch alloc] init];
    self.delegate = self;
    self.dataSource = self;
    self.backgroundColor = [UIColor clearColor];
    [self registerNib:[UINib nibWithNibName:@"HDZImageCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"HDZImageCollectionCell"];
    self.collectionViewLayout = [[HDZImageCollectionLayout alloc] init];

}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    HDZImageCollectionCell * cell = [self dequeueReusableCellWithReuseIdentifier:@"HDZImageCollectionCell" forIndexPath:indexPath];
    HDZSearchResult *searchResult = self.search.searchResults[indexPath.item];
    [cell configureForResult:searchResult];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.thumbImages.count;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGSize size = CGSizeZero;
    switch (self.thumbImages.count) {
        case 1:
        {   size = CGSizeMake(screenWidth-30, screenWidth-30);}
            break;
        case 2: case 4:
        {
            CGFloat iamgeWidth = (screenWidth-35)*0.5;
            size = CGSizeMake(iamgeWidth, iamgeWidth);
        }
            break;
        case 3: case 5: case 6: case 7: case 8: case 9:
        {
            CGFloat iamgeWidth = (screenWidth - 40) / 3;
            size = CGSizeMake(iamgeWidth, iamgeWidth);
        }
            break;
    }
    return size;
}



@end
