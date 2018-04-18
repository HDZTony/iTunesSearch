//
//  HDZSearchResult.h
//  iTunesSearch
//
//  Created by 何东洲 on 2018/3/29.
//  Copyright © 2018年 何东洲. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YYModel.h"
@protocol YYModel;
@class HDZSearchResult;

@interface HDZResultArray : NSObject<YYModel>
@property (nonatomic,assign) NSInteger resultCount;
@property (nonatomic, strong) NSArray<HDZSearchResult *>* results;
@end

@interface HDZSearchResult : NSObject<YYModel>
@property (nonatomic, copy) NSString* kind;
@property (nonatomic, copy) NSString* artistName;
@property (nonatomic, copy) NSString* trackName;
@property (nonatomic, assign) double trackPrice;
@property (nonatomic, copy) NSString* trackViewUrl;
@property (nonatomic, copy) NSString* collectionName;
@property (nonatomic, copy) NSString* collectionViewUrl;
@property (nonatomic, assign) double collectionPrice;
@property (nonatomic, assign) double itemPrice;
@property (nonatomic, copy) NSString* itemGenre;
@property (nonatomic, copy) NSArray<NSString *> *bookGenre;
@property (nonatomic, copy) NSString* currency;
@property (nonatomic, copy) NSString* imageSmall;
@property (nonatomic, copy) NSString* imageLarge;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *genre;
@property (nonatomic, assign) double price;
@property (nonatomic, copy) NSString* storeURL;
@property (nonatomic, assign) CGFloat contentViewHeight;
@property (nonatomic, assign) CGFloat attentionCellHeight;
@property (nonatomic, assign) NSInteger imageCount;
-(CGFloat)collectionViewWidthWithCount:(NSUInteger)count;
-(CGFloat)collectionViewHeightWithCount:(NSUInteger)count;
@end
