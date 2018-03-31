//
//  HDZSearchResultCell.m
//  iTunesSearch
//
//  Created by 何东洲 on 2018/3/30.
//  Copyright © 2018年 何东洲. All rights reserved.
//

#import "HDZSearchResultCell.h"
@interface HDZSearchResultCell()

@end
@implementation HDZSearchResultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UIView *selectedView = [[UIView alloc] initWithFrame:CGRectZero];
    selectedView.backgroundColor = [[UIColor alloc] initWithRed:20/255 green:160/255 blue:160/255 alpha:0.5];
    self.selectedBackgroundView = selectedView;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end
