//
//  HDZGoodsYouLikeCell.h
//  iTunesSearch
//
//  Created by 何东洲 on 2018/4/23.
//  Copyright © 2018年 何东洲. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HDZRecommendItem.h"
@interface HDZGoodsYouLikeCell : UICollectionViewCell
/* 推荐数据 */
@property (strong , nonatomic)HDZRecommendItem *youLikeItem;
/* 相同 */
@property (strong , nonatomic)UIButton *sameButton;
/** 找相似点击回调 */
@property (nonatomic, copy) dispatch_block_t lookSameBlock;
@end
