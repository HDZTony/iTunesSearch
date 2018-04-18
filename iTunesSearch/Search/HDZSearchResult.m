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

+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"imageSmall" : @"artworkUrl60",
             @"imageLarge" : @"artworkUrl100",
             @"itemGenre" : @"primaryGenreName",
             @"bookGenre" : @"genres",
             @"itemPrice" : @"price"
             };
}

-(NSString *)name{
    if (_trackName) {
        return _trackName;
    }else if (_collectionName){
        return _collectionName;
    }else{
        return @"";
    }
}
-(NSString *)genre{
    if (_itemGenre) {
        return _itemGenre;
    }else if (_bookGenre){
        return _bookGenre.firstObject;
    }
    return @"";
}
- (double) price {
    if (_trackPrice) {
        return _trackPrice;
    }else if (_collectionPrice){
        return _collectionPrice;
    }else{
        return 0.0;
    }
}
-(NSString *)storeURL{
    if (_trackViewUrl) {
        return _trackViewUrl;
    }else if (_collectionViewUrl){
        return _collectionViewUrl;
    }
    return @"";
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
-(NSInteger)imageCount{
    return _imageCount = arc4random() % 10;
}

-(CGFloat)collectionViewWidthWithCount:(NSUInteger)count{
    NSInteger screenWidth = [UIScreen mainScreen].bounds.size.width;
    //CGFloat width1 = screenWidth * 0.5;
    CGFloat width2 = (screenWidth - 35) * 0.5;
    CGFloat widith3 = (screenWidth - 40) / 3;
    CGFloat width = 0;
    switch (count) {
        case 1:
        case 2:{
             width = (width2 + 5) * 2;
        }
            break;
        case 3:
        case 5:
        case 6:
        case 7:
        case 8:
        case 9:{
             width = screenWidth - 30;
        }
            break;
        case 4:{
             width = (widith3 + 5) * 2;
        }
            break;
    }
    return width;
}
-(CGFloat)collectionViewHeightWithCount:(NSUInteger)count{
    NSInteger screenWidth = [UIScreen mainScreen].bounds.size.width;
    //CGFloat width1 = screenWidth * 0.5;
    CGFloat width2 = (screenWidth - 35) * 0.5;
    CGFloat width3 = (screenWidth - 40) / 3;
    CGFloat height = 0;
    switch (count) {
        case 1:
        case 2:{
            height = width2;
        }
            break;
        case 3:{
            height = width3 + 5;
        }
            break;
        case 4:
        case 5:
        case 6:{
            height = (width3 + 5) * 2;
        }
            break;
        case 7:
        case 8:
        case 9:{
            height = (width3 + 5) * 3;
        }
            break;
            
    }
    return height;
}
-(CGFloat)attentionCellHeight{
    // 50 + contentH + 5 + middleViewH + 65
    CGFloat _attentionCellHeight = 120;
#warning forget   height += contentH
    _attentionCellHeight += [self collectionViewHeightWithCount:self.imageCount];

    return _attentionCellHeight;
}

@end
    
    
