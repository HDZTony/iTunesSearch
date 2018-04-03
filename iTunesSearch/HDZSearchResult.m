//
//  HDZSearchResult.m
//  iTunesSearch
//
//  Created by 何东洲 on 2018/3/29.
//  Copyright © 2018年 何东洲. All rights reserved.
//

#import "HDZSearchResult.h"

@implementation HDZResultArray
+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"results" : [HDZSearchResult class]};
}
@end

@implementation HDZSearchResult
-(NSString *)name{
    if (_trackName) {
        return _trackName;
    }else if (_collectionName){
        return _collectionName;
    }else{
        return @"";
    }
}
-(NSString *)type{
    NSString *kind;
    if (_kind) {
        kind = _kind;
    }else{
        kind = @"audiobook";
    }
    if ([kind isEqualToString:@"album"]) {
        return @"Album";
    } else if([kind isEqualToString:@"audiobook"]){
        return @"Audio Book";
    } else if([kind isEqualToString:@"book"]){
    return @"Audio Book";
    }else if([kind isEqualToString:@"ebook"]){
        return @"Audio E-Book";
    }else if([kind isEqualToString:@"feature-movie"]){
        return @"Movie";
    }else if([kind isEqualToString:@"music-video"]){
        return @"Music Video";
    }else if([kind isEqualToString:@"podcast"]){
        return @"Podcast";
    }else if([kind isEqualToString:@"software"]){
        return @"App";
    }else if([kind isEqualToString:@"song"]){
        return @"Song";
    }else if([kind isEqualToString:@"tv-episode"]){
        return @"TV Episode";
    }else{
        return @"Unknown";
    }
}
+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"imageSmall" : @"artworkUrl60",
             @"imageLarge" : @"artworkUrl100",
             @"itemGenre" : @"primaryGenreName",
             @"bookGenre" : @"genres",
             @"itemPrice" : @"price"
             };
}
@end
    
    
