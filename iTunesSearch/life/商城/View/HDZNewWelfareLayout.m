//
//  HDZNewWelfareLayout.m
//  iTunesSearch
//
//  Created by 何东洲 on 2018/4/30.
//  Copyright © 2018年 何东洲. All rights reserved.
//

#import "HDZNewWelfareLayout.h"
@interface HDZNewWelfareLayout()
@property (nonatomic, assign) CGFloat overallHeight;     //整体高
@property (nonatomic, strong) NSMutableArray *attrsArray;  //布局数组
@end
@implementation HDZNewWelfareLayout
/**
 1.一个Cell对应一个UICollectionViewLayoutAttributes对象
 2.UICollectionViewLayoutAttributes对象决定了cell的摆设位置（frame）
 */
#pragma mark - 初始化layout的结构和初始需要的参数
-(void)prepareLayout{
    [super prepareLayout];
    [self setUpAttributes];//初始化属性
}

#pragma mark - 初始化属性（section/item）
- (void)setUpAttributes{
    NSMutableArray *attributesArray = [NSMutableArray array];
    NSInteger sectionCount = [self.collectionView numberOfSections];
    for (int i = 0; i < sectionCount; i++) {
        //Header
        NSIndexPath *indexPath = [NSIndexPath indexPathWithIndex:i];
        UICollectionViewLayoutAttributes *attribute = [self.collectionView layoutAttributesForSupplementaryElementOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
        [attributesArray addObject:attribute];
        //Item
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:i];
        for (int j = 0; j < itemCount; j++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:j inSection:i];
            UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:indexPath];
            [attributesArray addObject:attribute];
        }
        //Footer
        attribute = [self.collectionView layoutAttributesForSupplementaryElementOfKind:UICollectionElementKindSectionFooter atIndexPath:indexPath];
        [attributesArray addObject:attribute];
    }
    self.attrsArray = [NSMutableArray arrayWithArray:attributesArray];
}
-(CGSize)collectionViewContentSize{
    return CGSizeMake(self.collectionView.bounds.size.width,self.overallHeight);
}
#pragma mark - 对应indexPath的位置的追加视图的布局属性
- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];
    CGFloat height = 0;
    if (elementKind == UICollectionElementKindSectionHeader) {
        if (self.delegate != nil && [self.delegate respondsToSelector:@selector ( hdz_HeightOfSectionHeaderForIndexPath:)]) {
            height = [self.delegate hdz_HeightOfSectionHeaderForIndexPath:indexPath];
        }
    }else{
            if (self.delegate != nil && [self.delegate respondsToSelector:@selector(hdz_HeightOfSectionFooterForIndexPath:)]) {
                height = [_delegate hdz_HeightOfSectionFooterForIndexPath:indexPath];
            }
        }
    attribute.frame = CGRectMake(0, self.overallHeight, ScreenW, height);
    self.overallHeight += height;
    return attribute;
}

#pragma mark - 返回rect中的所有的元素的布局属性
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attrsArray;
}

#pragma mark - 返回对应于indexPath的位置的cell的布局属性
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    switch (indexPath.section) {
        case 0:
            [self layoutAttributesForCustomOneLayout:attributes indexPath:indexPath];
            break;

    }
    return attributes;
}

#pragma mark - 自定义第一组section
- (void)layoutAttributesForCustomOneLayout:(UICollectionViewLayoutAttributes *)layoutAttributes indexPath: (NSIndexPath *) indexPath {
    if (indexPath.item > 3) return;
    CGFloat itemY = self.overallHeight;
    CGFloat itemH = 85;
    CGFloat itemW = ScreenW /2.0;
    switch (indexPath.item) {
        case 0:
        layoutAttributes.frame = CGRectMake(0, itemY, itemW, itemH);
            break;
        case 1:
            layoutAttributes.frame = CGRectMake(itemW, itemY, itemW, itemH);
            break;
        case 2:
            self.overallHeight += itemH;
            layoutAttributes.frame = CGRectMake(0, itemH, ScreenW, itemH);
            self.overallHeight += itemH;
            break;
    }
}
@end
