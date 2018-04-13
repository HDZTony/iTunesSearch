//
//  HDZSearchResultCell.m
//  iTunesSearch
//
//  Created by 何东洲 on 2018/3/30.
//  Copyright © 2018年 何东洲. All rights reserved.
//

#import "HDZSearchResultCell.h"
#import "HDZSearchResult.h"
#import "UIImageView+HDZDownloadImage.h"
@interface HDZSearchResultCell()
@property (nonatomic, strong)NSURLSessionDownloadTask *downloadTask;
@end
@implementation HDZSearchResultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UIView *selectedView = [[UIView alloc] initWithFrame:CGRectZero];
    selectedView.backgroundColor = [[UIColor alloc] initWithRed:20/255 green:160/255 blue:160/255 alpha:0.5];
    self.selectedBackgroundView = selectedView;
    
}
-(void)prepareForReuse{
    [super prepareForReuse];
    [self.downloadTask cancel];
    self.downloadTask = nil;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}
  // MARK:- Public Methods
- (void)configureForResult:(HDZSearchResult *)result{
    self.nameLabel.text = result.name;
    if (!result.artistName) {
        self.artworkNameLabel.text = @"Unknow";
    }else{
        self.artworkNameLabel.text = [NSString stringWithFormat:@"%@ (%@)",result.artistName,result.type];
    }
    self.artworkImageView.image = [UIImage imageNamed:@"Placeholder"];
    NSURL *smallURL = [NSURL URLWithString:result.imageSmall];
    if (smallURL) {
        self.downloadTask = [self.artworkImageView loadImageWithURL:smallURL];
    }
}
@end
