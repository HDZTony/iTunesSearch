//
//  HDZMessageCell.h
//  iTunesSearch
//
//  Created by 何东洲 on 2018/4/10.
//  Copyright © 2018年 何东洲. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HDZSearchResult;
@interface HDZMessageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
- (void)configureForResult:(HDZSearchResult *)result;


@end
