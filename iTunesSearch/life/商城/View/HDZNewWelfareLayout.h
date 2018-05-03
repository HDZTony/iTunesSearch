//
//  HDZNewWelfareLayout.h
//  iTunesSearch
//
//  Created by 何东洲 on 2018/4/30.
//  Copyright © 2018年 何东洲. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HDZNewWelfareLayoutDelegate <NSObject>

@optional;

/* 头部高度 */
-(CGFloat)hdz_HeightOfSectionHeaderForIndexPath:(NSIndexPath *)indexPath;
/* 尾部高度 */
-(CGFloat)hdz_HeightOfSectionFooterForIndexPath:(NSIndexPath *)indexPath;

@end
@interface HDZNewWelfareLayout : UICollectionViewFlowLayout
@property (nonatomic, weak) id<HDZNewWelfareLayoutDelegate>delegate;


@end
