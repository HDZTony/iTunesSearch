//
//  HDZSearchResultCell.h
//  iTunesSearch
//
//  Created by 何东洲 on 2018/3/30.
//  Copyright © 2018年 何东洲. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HDZSearchResult;
@interface HDZSearchResultCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *artworkImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *artworkNameLabel;
- (void)configureForResult:(HDZSearchResult *)result;
@end
