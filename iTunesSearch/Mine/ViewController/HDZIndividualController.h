//
//  HDZIndividualController.h
//  iTunesSearch
//
//  Created by 何东洲 on 2018/4/17.
//  Copyright © 2018年 何东洲. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HDZIndividual;
@interface HDZIndividualController : UITableViewController
@property (weak, nonatomic) IBOutlet UIImageView *thumbImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *genderLabel;
@property (weak, nonatomic) IBOutlet UILabel *birthdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *autographLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *birthdayPicker;
@property (strong, nonatomic) IBOutlet UITableViewCell *birthdayPickerCell;

@property (nonatomic, strong)HDZIndividual *individual;
@end
