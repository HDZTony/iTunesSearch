//
//  HDZGridItem.m
//  iTunesSearch
//
//  Created by 何东洲 on 2018/4/22.
//  Copyright © 2018年 何东洲. All rights reserved.
//

#import "HDZGridItem.h"

@implementation HDZGridItem
- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
@end
