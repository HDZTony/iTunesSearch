//
//  HDZAttentionCell.m
//  iTunesSearch
//
//  Created by 何东洲 on 2018/4/14.
//  Copyright © 2018年 何东洲. All rights reserved.
//

#import "HDZAttentionCell.h"
#import "HDZSearchResult.h"
#import "UIImageView+HDZDownloadImage.h"
#import "HDZImageCollectionView.h"
@interface HDZAttentionCell()
@property (nonatomic, strong)NSURLSessionDownloadTask *downloadTask;
@property (nonatomic, strong)HDZImageCollectionView *imageCollectionView;
@end
@implementation HDZAttentionCell
-(HDZImageCollectionView *)imageCollectionView{
    if (!_imageCollectionView) {
        _imageCollectionView = [[[NSBundle mainBundle] loadNibNamed:@"HDZImageCollectionView" owner:nil options:nil] lastObject];
    }
    return _imageCollectionView;
}
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
// MARK:- Public Methods
- (void)configureForResult:(HDZSearchResult *)result indexPath:(NSIndexPath * )indexPath{
    self.nameLabel.text = result.name;
    if (!result.artistName) {
        self.tiemeLabel.text = @"Unknow";
    }else{
        self.tiemeLabel.text = [NSString stringWithFormat:@"%@ (%@)",result.artistName,result.type];
    }
    self.thumbnailIamge.image = [UIImage imageNamed:@"Placeholder"];
    NSURL *smallURL = [NSURL URLWithString:result.imageSmall];
    if (smallURL) {
        self.downloadTask = [self.thumbnailIamge loadImageWithURL:smallURL];
    }
    if (indexPath.row == 1 || indexPath.row == 3 || indexPath.row == 5) {
        self.contentLabel.text = nil;
    }else{
        self.contentLabel.text = result.collectionViewUrl;
    }
    
    self.contentLabel.backgroundColor = HDZRandomColor;
//    CGFloat collectionViewWidth =  [result collectionViewWidthWithCount:result.imageCount];
//    CGFloat collectionViewHeight =  [result collectionViewHeightWithCount:result.imageCount];
    
    //self.middleViewHeight.constant = collectionViewHeight;
   // [self layoutIfNeeded];
//    if ([self.middleView.subviews.firstObject isMemberOfClass:[HDZImageCollectionView class]]) {
//        [self.imageCollectionView removeFromSuperview];
//    }
//    if (result.imageCount != 0) {
//        self.imageCollectionView.frame = CGRectMake(15, 0,collectionViewWidth,collectionViewHeight);
//        NSMutableArray *images = [NSMutableArray array];
//        for (NSInteger i = 0; i<result.imageCount; i++) {
//            [images addObject:result.imageSmall];
//        }
        //self.imageCollectionView.thumbImages = images;
        //self.middleView.backgroundColor = [UIColor blueColor];
        //self.imageCollectionView.backgroundColor = HDZRandomColor;
        //[self.middleView addSubview:self.imageCollectionView];
//    }
    
}
@end
