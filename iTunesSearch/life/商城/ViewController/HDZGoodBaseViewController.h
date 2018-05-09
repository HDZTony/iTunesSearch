//
//  HDZGoodBaseViewController.h
//  iTunesSearch
//
//  Created by 何东洲 on 2018/5/7.
//  Copyright © 2018年 何东洲. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HDZGoodBaseViewController : UIViewController
/* 商品标题 */
@property (copy , nonatomic)NSString *goodTitle;
/* 商品价格 */
@property (copy , nonatomic)NSString *goodPrice;
/* 商品小标题 */
@property (copy , nonatomic)NSString *goodSubtitle;
/* 商品图片 */
@property (copy , nonatomic)NSString *goodImageView;

/* 商品轮播图 */
@property (copy , nonatomic)NSArray *shufflingArray;

@end
