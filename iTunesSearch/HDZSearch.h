//
//  HDZSearch.h
//  iTunesSearch
//
//  Created by 何东洲 on 2018/4/9.
//  Copyright © 2018年 何东洲. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, HDZCategory) {
    all,//默认从0开始
    music,
    software,
    ebooks,
};

@class HDZSearchResult;
@interface HDZSearch : NSObject
@property (nonatomic,strong) NSMutableArray<HDZSearchResult *>* searchResults;
@property (nonatomic,assign) BOOL hasSearched;
@property (nonatomic,assign) BOOL isLoading;
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;
typedef void(^SearchComplete)(BOOL sucess);
- (void)performSearchFortext:(NSString *)text category:(HDZCategory )category completion:(SearchComplete)completion;
@end
