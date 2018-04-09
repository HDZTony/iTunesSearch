//
//  HDZSearch.m
//  iTunesSearch
//
//  Created by 何东洲 on 2018/4/9.
//  Copyright © 2018年 何东洲. All rights reserved.
//

#import "HDZSearch.h"
#import "HDZSearchResult.h"
#import <UIKit/UIKit.h>
@interface HDZSearch()
@end
@implementation HDZSearch

- (void)performSearchFortext:(NSString *)text category:(HDZCategory )category completion:(SearchComplete)completion{
    NSLog(@"searching...");
    if (text != nil) {
        [self.dataTask cancel];
        UIApplication *application = [UIApplication sharedApplication];
        application.networkActivityIndicatorVisible = YES;
        self.isLoading = YES;
        self.hasSearched = YES;
        [self.searchResults removeAllObjects];
        NSURL *url = [self iTunesURLWithSearchText:text category:category];
        NSURLSession *session = [NSURLSession sharedSession];
        self.dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            BOOL success = NO;
            NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
            if (error.code == -999) {
                return ;
            }else if (res.statusCode == 200){
                if (data) {
                    self.searchResults = [self parse:data];
                    self.isLoading = NO;
                    success = YES;
                }
            }
            NSLog(@"performSearch Failure!%@",response);
            if (!success) {
                self.hasSearched = NO;
                self.isLoading = NO;
            }
            dispatch_queue_t mainQueue = dispatch_get_main_queue();
            dispatch_async(mainQueue, ^{
                application.networkActivityIndicatorVisible = NO;
                completion(success);
            });
            
        }];
        [self.dataTask resume];
    };
}

-(NSURL *)iTunesURLWithSearchText:(NSString *)searchText category:(HDZCategory)category{
    NSString *kind;
    switch (category) {
        case all:
            kind = @"";
            break;
        case music:
            kind = @"musicTrack";
            break;
        case software:
            kind = @"software";
            break;
        case ebooks:
            kind = @"ebook";
            break;

    }
    NSString *urlString = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@&limit=20&entity=%@",searchText,kind];
    NSString *encodedURL = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:encodedURL];
    return url;
}
- (NSMutableArray<HDZSearchResult *> *)parse:(NSData *)data{
    HDZResultArray * resultArray = [HDZResultArray yy_modelWithJSON:data];
    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:resultArray.results];
    return mutableArray;
}
@end
