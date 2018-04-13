//
//  HDZMessageViewController.m
//  iTunesSearch
//
//  Created by 何东洲 on 2018/4/10.
//  Copyright © 2018年 何东洲. All rights reserved.
//

#import "HDZMessageViewController.h"
#import "HDZSearch.h"
@interface HDZMessageViewController ()
@property (nonatomic, strong) HDZSearch *search;
@end

@implementation HDZMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.search.searchResults.count;
}






@end
