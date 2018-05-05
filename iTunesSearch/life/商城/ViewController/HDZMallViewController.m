//
//  HDZMallViewController.m
//  iTunesSearch
//
//  Created by 何东洲 on 2018/4/22.
//  Copyright © 2018年 何东洲. All rights reserved.
//

#import "HDZMallViewController.h"
#import "HDZGridItem.h"
#import "HDZRecommendItem.h"
/* cell */
#import "HDZGoodsCountDownCell.h" //倒计时商品
#import "HDZNewWelfareCell.h"     //新人福利
#import "HDZGoodsHandheldCell.h"  //掌上专享
#import "HDZExceedApplianceCell.h"//不止
#import "HDZGoodsYouLikeCell.h"   //猜你喜欢商品
#import "HDZGoodsGridCell.h"      //10个选项
/* head */
#import "HDZSlideshowHeadView.h"  //轮播图
#import "HDZCountDownHeadView.h"  //倒计时标语
#import "HDZYouLikeHeadView.h"    //猜你喜欢等头部标语
/* foot */
#import "HDZTopLineFootView.h"    //热点
#import "HDZOverFootView.h"       //结束
#import "HDZScrollAdFootView.h"   //底滚动广告
@interface HDZMallViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)UIButton *backTopButton;
/* 10个属性 */
@property (strong , nonatomic)NSMutableArray<HDZGridItem *> *gridItem;
/* 推荐商品属性 */
@property (strong , nonatomic)NSMutableArray<HDZRecommendItem *> *youLikeItem;
@end
/* cell */
static NSString *const HDZGoodsCountDownCellID = @"HDZGoodsCountDownCell";
static NSString *const HDZNewWelfareCellID = @"HDZNewWelfareCell";
static NSString *const HDZGoodsHandheldCellID = @"HDZGoodsHandheldCell";
static NSString *const HDZGoodsYouLikeCellID = @"HDZGoodsYouLikeCell";
static NSString *const HDZGoodsGridCellID = @"HDZGoodsGridCell";
static NSString *const HDZExceedApplianceCellID = @"HDZExceedApplianceCell";
/* head */
static NSString *const HDZSlideshowHeadViewID = @"HDZSlideshowHeadView";
static NSString *const HDZCountDownHeadViewID = @"HDZCountDownHeadView";
static NSString *const HDZYouLikeHeadViewID = @"HDZYouLikeHeadView";
/* foot */
static NSString *const HDZTopLineFootViewID = @"HDZTopLineFootView";
static NSString *const HDZOverFootViewID = @"HDZOverFootView";
static NSString *const HDZScrollAdFootViewID = @"HDZScrollAdFootView";
@implementation HDZMallViewController
#pragma mark - LazyLoad
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.frame = CGRectMake(0, 0, ScreenW, ScreenH - HDZBottomTabH);
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerClass:[HDZGoodsCountDownCell class] forCellWithReuseIdentifier:HDZGoodsCountDownCellID];
        [_collectionView registerClass:[HDZGoodsHandheldCell class] forCellWithReuseIdentifier:HDZGoodsHandheldCellID];
        [_collectionView registerClass:[HDZGoodsYouLikeCell class] forCellWithReuseIdentifier:HDZGoodsYouLikeCellID];
        [_collectionView registerClass:[HDZGoodsGridCell class] forCellWithReuseIdentifier:HDZGoodsGridCellID];
        [_collectionView registerClass:[HDZExceedApplianceCell class] forCellWithReuseIdentifier:HDZExceedApplianceCellID];
        [_collectionView registerClass:[HDZNewWelfareCell class] forCellWithReuseIdentifier:HDZNewWelfareCellID];
        [_collectionView registerClass:[HDZTopLineFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:HDZTopLineFootViewID];
        [_collectionView registerClass:[HDZOverFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:HDZOverFootViewID];
        [_collectionView registerClass:[HDZScrollAdFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:HDZScrollAdFootViewID];
        [_collectionView registerClass:[HDZYouLikeHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HDZYouLikeHeadViewID];
        [_collectionView registerClass:[HDZSlideshowHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HDZSlideshowHeadViewID];
        [_collectionView registerClass:[HDZCountDownHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HDZCountDownHeadViewID];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = HDZBGColor;
    [self setUpGoodsData];
    [self setUpScrollToTopView];
}
- (void)setUpGoodsData{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"GoodsGrid" ofType:@"plist"];
    NSMutableArray *goodsGrid = [NSMutableArray arrayWithContentsOfFile:path];
    self.gridItem = [NSMutableArray array];
    for (NSDictionary *dict in goodsGrid) {
        HDZGridItem *item = [[HDZGridItem alloc] initWithDict:dict];
        [self.gridItem addObject:item];
    }
    self.youLikeItem = [NSMutableArray array];
    path = [[NSBundle mainBundle] pathForResource:@"HomeHighGoods" ofType:@"plist"];
    NSMutableArray *youLikeItem = [NSMutableArray arrayWithContentsOfFile:path];
    for (NSDictionary *dict in youLikeItem) {
        HDZRecommendItem *item = [[HDZRecommendItem alloc] initWithDict:dict];
        [self.youLikeItem addObject:item];
    }
    
}
//Status bar could not find cached time string image. Rendering in-process.
//按钮没有实现
- (void)setUpScrollToTopView{
    _backTopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_backTopButton];
    [_backTopButton addTarget:self action:@selector(scrollToTop) forControlEvents:UIControlEventTouchUpInside];
    [_backTopButton setImage:[UIImage imageNamed:@"btn_UpToTop"] forState:UIControlStateNormal];
    _backTopButton.hidden = YES;
    _backTopButton.frame = CGRectMake(ScreenW - 50, ScreenH - 160, 40, 40);
}
- (void)scrollToTop{
    [self.collectionView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
}
#pragma mark - <UICollectionViewDataSource>
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UICollectionViewCell *gridCell = nil;
    switch (indexPath.section) {
        case 0:{
            HDZGoodsGridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HDZGoodsGridCellID forIndexPath:indexPath];
            cell.gridItem = _gridItem[indexPath.row];
            cell.backgroundColor = [UIColor whiteColor];
            gridCell = cell;
        }
            break;
        case 1:{
            HDZNewWelfareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HDZNewWelfareCellID forIndexPath:indexPath];
            cell.backgroundColor = HDZRandomColor;
            gridCell = cell;
        }
            break;
        case 2:{
            HDZGoodsCountDownCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HDZGoodsCountDownCellID forIndexPath:indexPath];
            cell.backgroundColor = HDZRandomColor;
            gridCell = cell;
        }
            break;
        case 3:{
             HDZExceedApplianceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HDZExceedApplianceCellID forIndexPath:indexPath];
            cell.backgroundColor = HDZRandomColor;
            gridCell = cell;
        }
            break;
        case 4:{
            HDZGoodsHandheldCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HDZGoodsHandheldCellID forIndexPath:indexPath];
            cell.backgroundColor = HDZRandomColor;
            gridCell = cell;
        }
            break;
        case 5:{
            HDZGoodsYouLikeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HDZGoodsYouLikeCellID forIndexPath:indexPath];
            cell.backgroundColor = HDZRandomColor;
            gridCell = cell;
        }
    }
    return gridCell;
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader){
        if (indexPath.section == 0) {
            HDZSlideshowHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HDZSlideshowHeadViewID forIndexPath:indexPath];
            headerView.imageGroupArray = GoodsHomeSilderImagesArray;
            reusableview = headerView;
        }else if (indexPath.section == 2){
            HDZCountDownHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HDZCountDownHeadViewID forIndexPath:indexPath];
            headerView.backgroundColor = HDZRandomColor;
            reusableview = headerView;
        }else if (indexPath.section == 4){
            HDZYouLikeHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HDZYouLikeHeadViewID forIndexPath:indexPath];
            headerView.backgroundColor = HDZRandomColor;
            reusableview = headerView;
        }else if (indexPath.section == 5){
            HDZYouLikeHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HDZYouLikeHeadViewID forIndexPath:indexPath];
            headerView.backgroundColor = HDZRandomColor;
            reusableview = headerView;
        }
        
    }
    if (kind == UICollectionElementKindSectionFooter) {
        if (indexPath.section == 0) {
            HDZTopLineFootView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:HDZTopLineFootViewID forIndexPath:indexPath];
            footerView.backgroundColor = HDZRandomColor;
            reusableview = footerView;
        }else if (indexPath.section == 3){
            HDZScrollAdFootView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:HDZScrollAdFootViewID forIndexPath:indexPath];
            footerView.backgroundColor = HDZRandomColor;
            reusableview = footerView;
        }else if (indexPath.section == 5) {
            HDZOverFootView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:HDZOverFootViewID forIndexPath:indexPath];
            footerView.backgroundColor = HDZRandomColor;
            reusableview = footerView;
        }
    }
    return reusableview;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 6;
}
- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return self.gridItem.count;
            break;
        case 1: case 2: case 3:
            return 1;
            break;
        case 4:
            return GoodsHandheldImagesArray.count;
            break;
        case 5:
            return _youLikeItem.count;
            break;
    }
    return 0;
}
#pragma mark - item宽高
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return CGSizeMake(ScreenW/5, ScreenW/5 + HDZMargin);
            break;
        case 1:
            return CGSizeMake(ScreenW, 180);
            break;
        case 2:
            return CGSizeMake(ScreenW, 150);
            break;
        case 3:
            return CGSizeMake(ScreenW,ScreenW * 0.35 + 120);
            break;
        case 4:
            return [self layoutAttributesForItemAtIndexPath:indexPath].size;
            break;
        case 5:
            return CGSizeMake((ScreenW - 4)/2, (ScreenW - 4)/2 + 40);
            break;
    }
    return CGSizeZero;
}
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    if (indexPath.section == 4) {
        switch (indexPath.row) {
            case 0:
                layoutAttributes.size = CGSizeMake(ScreenW, ScreenW * 0.38);
                break;
            case 1: case 2: case 3: case 4:
                layoutAttributes.size = CGSizeMake(ScreenW * 0.5,ScreenW * 0.24);
                break;
            default:
                layoutAttributes.size = CGSizeMake(ScreenW *0.5, ScreenW * 0.35);
                break;
        }
    }
    return layoutAttributes;
}
#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return CGSizeMake(ScreenW, 230); //图片滚动的宽高
    }
    if (section == 2 || section == 4 || section == 5) {//猜你喜欢的宽高
        return CGSizeMake(ScreenW, 40);  //推荐适合的宽高
    }
    return CGSizeZero;
}

#pragma mark - foot宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(ScreenW, 180);  //Top头条的宽高
    }
    if (section == 3) {
        return CGSizeMake(ScreenW, 80); // 滚动广告
    }
    if (section == 5) {
        return CGSizeMake(ScreenW, 40); // 结束
    }
    return CGSizeZero;
}
#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    self.backTopButton.hidden = (scrollView.contentOffset.y > ScreenH) ? NO : YES;//判断回到顶部按钮是否隐藏
    if (scrollView.contentOffset.y > HDZNavigationH) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    }else{
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }
}
#pragma mark - <UICollectionViewDelegateFlowLayout>
#pragma mark - X间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return (section == 5) ? 4 : 0;
}

#pragma mark - Y间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return (section == 5) ? 4 : 0;
}
@end
