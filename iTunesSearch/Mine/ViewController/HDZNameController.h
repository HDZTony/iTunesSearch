//
//  HDZNameController.h
//  iTunesSearch
//
//  Created by 何东洲 on 2018/4/17.
//  Copyright © 2018年 何东洲. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HDZNameController;
@class HDZIndividual;
@protocol HDZNameControllerDelegate<NSObject>
- (void)nameControllerDidCancel:(HDZNameController *)nameController;
- (void)nameController:(HDZNameController *)nameController DidFinishEditingItem:(HDZIndividual *) item;
//- (void)nameControllerDidCancel:(HDZNameController *)nameController;
@end
@interface HDZNameController : UITableViewController
@property (nonatomic, strong) HDZIndividual *individual;
@property (nonatomic, weak)id<HDZNameControllerDelegate>delegate;
@end
