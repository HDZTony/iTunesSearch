//
//  HDZImageCollectionCell.m
//  iTunesSearch
//
//  Created by 何东洲 on 2018/4/15.
//  Copyright © 2018年 何东洲. All rights reserved.
//

#import "HDZImageCollectionCell.h"
#import "HDZSearchResult.h"
#import "UIImageView+HDZDownloadImage.h"
@interface HDZImageCollectionCell()
@property (nonatomic, strong)NSURLSessionDownloadTask *downloadTask;
@end
@implementation HDZImageCollectionCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.thumbImageView.layer.borderWidth = 1;
}
-(void)prepareForReuse{
    [super prepareForReuse];
    [self.downloadTask cancel];
    self.downloadTask = nil;
}
- (void)configureForResult:(HDZSearchResult *)result{
    self.thumbImageView.image = [UIImage imageNamed:@"Placeholder"];
    NSURL *smallURL = [NSURL URLWithString:result.imageSmall];
    if (smallURL) {
        self.downloadTask = [self.thumbImageView loadImageWithURL:smallURL];
    }
}
@end
