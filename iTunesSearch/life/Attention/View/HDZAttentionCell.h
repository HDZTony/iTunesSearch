//
//  HDZAttentionCell.h
//  iTunesSearch
//
//  Created by 何东洲 on 2018/4/14.
//  Copyright © 2018年 何东洲. All rights reserved.
//https://m.maila88.com/mailaIndex?mailaAppKey=GDW5NMaKQNz81jtW2Yuw2P
//https://is.snssdk.com/api/news/feed/v75/?
#import <UIKit/UIKit.h>
@class HDZSearchResult;
@interface HDZAttentionCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailIamge;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tiemeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentLabelHeight;
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *middleViewHeight;
- (void)configureForResult:(HDZSearchResult *)result indexPath:(NSIndexPath *)indexPath;
@end
