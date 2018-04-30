//
//  HDZGridItem.h
//  iTunesSearch
//
//  Created by 何东洲 on 2018/4/22.
//  Copyright © 2018年 何东洲. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HDZGridItem : NSObject
/** 图片  */
@property (nonatomic, copy ,readonly) NSString *iconImage;
/** 文字  */
@property (nonatomic, copy ,readonly) NSString *gridTitle;
/** tag  */
@property (nonatomic, copy ,readonly) NSString *gridTag;
/** tag颜色  */
@property (nonatomic, copy ,readonly) NSString *gridColor;

- (instancetype)initWithDict:(NSDictionary *)dict;
@end
