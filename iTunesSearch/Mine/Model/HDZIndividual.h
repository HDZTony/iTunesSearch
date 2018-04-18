//
//  HDZIndividual.h
//  iTunesSearch
//
//  Created by 何东洲 on 2018/4/17.
//  Copyright © 2018年 何东洲. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface HDZIndividual : NSObject
@property (nonatomic, strong)UIImage *thumbImage;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *gender;
@property (nonatomic, strong)NSDate *birthday;
@property (nonatomic, copy)NSString *location;
@property (nonatomic, copy)NSString *autograph;
@end
