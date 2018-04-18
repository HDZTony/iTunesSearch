//
//  HDZImageCollectionCell.h
//  iTunesSearch
//
//  Created by 何东洲 on 2018/4/15.
//  Copyright © 2018年 何东洲. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HDZSearchResult;
@interface HDZImageCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *thumbImageView;
- (void)configureForResult:(HDZSearchResult *)result;
@end
