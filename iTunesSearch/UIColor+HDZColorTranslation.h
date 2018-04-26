//
//  UIColor+HDZColorTranslation.h
//  iTunesSearch
//
//  Created by 何东洲 on 2018/4/24.
//  Copyright © 2018年 何东洲. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HDZColorTranslation)
#pragma mark - 十六进制颜色
+ (UIColor *)hdz_colorWithHexString:(NSString *)color;
@end
