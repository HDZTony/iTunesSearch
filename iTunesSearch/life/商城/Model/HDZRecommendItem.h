//
//  HDZRecommendItem.h
//  iTunesSearch
//
//  Created by 何东洲 on 2018/4/22.
//  Copyright © 2018年 何东洲. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HDZRecommendItem : NSObject
/** 图片URL */
@property (nonatomic, copy ,readonly) NSString *image_url;
/** 商品标题 */
@property (nonatomic, copy ,readonly) NSString *main_title;
/** 商品小标题 */
@property (nonatomic, copy ,readonly) NSString *goods_title;
/** 商品价格 */
@property (nonatomic, copy ,readonly) NSString *price;
/** 剩余 */
@property (nonatomic, copy ,readonly) NSString *stock;
/** 属性 */
@property (nonatomic, copy ,readonly) NSString *nature;
/* 头部轮播 */
@property (copy , nonatomic , readonly)NSArray *images;

- (instancetype) initWithDict:(NSDictionary *)dict;
@end
