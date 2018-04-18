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
- (void)performSearchForText:(NSString *)text category:(HDZCategory )category completion:(SearchComplete)completion;
@end
/*
 "results": [
 {
 "wrapperType": "track",
 "kind": "song",
 "artistId": 102834,
 "collectionId": 1227088902,
 "trackId": 1227088906,
 "artistName": "Luis Fonsi & Daddy Yankee",
 "collectionName": "Despacito (feat. Justin Bieber) [Remix] - Single",
 "trackName": "Despacito (feat. Justin Bieber)",
 "collectionCensoredName": "Despacito (feat. Justin Bieber) [Remix] - Single",
 "trackCensoredName": "Despacito (feat. Justin Bieber) [Remix]",
 "artistViewUrl": "https://itunes.apple.com/us/artist/luis-fonsi/102834?uo=4",
 "collectionViewUrl": "https://itunes.apple.com/us/album/despacito-feat-justin-bieber-remix/1227088902?i=1227088906&uo=4",
 "trackViewUrl": "https://itunes.apple.com/us/album/despacito-feat-justin-bieber-remix/1227088902?i=1227088906&uo=4",
 "previewUrl": "https://audio-ssl.itunes.apple.com/apple-assets-us-std-000001/AudioPreview122/v4/3a/7f/79/3a7f79ab-f8bc-d780-fcd4-c73044080f98/mzaf_234976719765767653.plus.aac.p.m4a",
 "artworkUrl30": "https://is5-ssl.mzstatic.com/image/thumb/Music122/v4/a3/f0/47/a3f047a3-0632-27b4-a58f-30db9f42eb36/source/30x30bb.jpg",
 "artworkUrl60": "https://is5-ssl.mzstatic.com/image/thumb/Music122/v4/a3/f0/47/a3f047a3-0632-27b4-a58f-30db9f42eb36/source/60x60bb.jpg",
 "artworkUrl100": "https://is5-ssl.mzstatic.com/image/thumb/Music122/v4/a3/f0/47/a3f047a3-0632-27b4-a58f-30db9f42eb36/source/100x100bb.jpg",
 "collectionPrice": 1.29,
 "trackPrice": 1.29,
 "releaseDate": "2017-04-17T07:00:00Z",
 "collectionExplicitness": "notExplicit",
 "trackExplicitness": "notExplicit",
 "discCount": 1,
 "discNumber": 1,
 "trackCount": 1,
 "trackNumber": 1,
 "trackTimeMillis": 228827,
 "country": "USA",
 "currency": "USD",
 "primaryGenreName": "Pop",
 "isStreamable": true
 },
 */
