//
//  HDZAutographController.h
//  iTunesSearch
//
//  Created by 何东洲 on 2018/4/17.
//  Copyright © 2018年 何东洲. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HDZIndividual;
@class HDZAutographController;
@protocol HDZAutographControllerDelegate<NSObject>
- (void)autographControllerDidCancel:(HDZAutographController *)nameController;
- (void)autographController:(HDZAutographController *)nameController DidFinishEditingItem:(HDZIndividual *) item;
@end
@interface HDZAutographController : UITableViewController
@property (nonatomic, strong) HDZIndividual *individual;
@property (nonatomic, weak)id<HDZAutographControllerDelegate>delegate;
@end
