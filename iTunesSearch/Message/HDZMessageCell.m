//
//  HDZMessageCell.m
//  iTunesSearch
//
//  Created by 何东洲 on 2018/4/10.
//  Copyright © 2018年 何东洲. All rights reserved.
//

#import "HDZMessageCell.h"
#import "HDZSearchResult.h"
#import "UIImageView+HDZDownloadImage.h"
@interface HDZMessageCell()
@property (nonatomic, strong)NSURLSessionDownloadTask *downloadTask;
@end
@implementation HDZMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Rounded corners for images
    self.thumbnailImageView.layer.cornerRadius = self.thumbnailImageView.bounds.size.width / 2;
    self.thumbnailImageView.clipsToBounds = YES;
    self.separatorInset = UIEdgeInsetsMake(0, 84, 0, 0);
    
}

// MARK:- Public Methods
- (void)configureForResult:(HDZSearchResult *)result{
    self.nameLabel.text = result.name;
    if (!result.artistName) {
        self.messageLabel.text = @"Unknow";
    }else{
        self.messageLabel.text = [NSString stringWithFormat:@"%@ (%@)",result.artistName,result.type];
    }
    self.thumbnailImageView.image = [UIImage imageNamed:@"Placeholder"];
    NSURL *smallURL = [NSURL URLWithString:result.imageSmall];
    if (smallURL) {
        self.downloadTask = [self.thumbnailImageView loadImageWithURL:smallURL];
    }
}

@end
