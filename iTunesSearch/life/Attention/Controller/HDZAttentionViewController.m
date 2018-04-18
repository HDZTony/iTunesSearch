//
//  HDZAttentionViewController.m
//  iTunesSearch
//
//  Created by 何东洲 on 2018/4/13.
//  Copyright © 2018年 何东洲. All rights reserved.
//

#import "HDZAttentionViewController.h"
#import "HDZSearch.h"
#import "HDZSearchResult.h"
#import "HDZAttentionCell.h"
static NSString *const kHDZAttentionCell = @"HDZAttentionCell";
static NSString *const knothingFoundCell = @"HDZNothingFoundCell";
static NSString *const kloadingCell = @"LoadingCell";
@interface HDZAttentionViewController ()
@property (nonatomic, strong)HDZSearch *search;
@end

@implementation HDZAttentionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.search = [[HDZSearch alloc] init];
    UINib *cell = [UINib nibWithNibName:kHDZAttentionCell bundle:nil];
    [self.tableView registerNib:cell forCellReuseIdentifier:kHDZAttentionCell];
    cell = [UINib nibWithNibName:knothingFoundCell bundle:nil];
    [self.tableView registerNib:cell forCellReuseIdentifier:knothingFoundCell];
    cell = [UINib nibWithNibName:kloadingCell bundle:nil];
    [self.tableView registerNib:cell forCellReuseIdentifier:kloadingCell];
    [self performSearch];

}

- (void)performSearch{
    [self.search performSearchForText:@"Justin" category:0 completion:^(BOOL sucess) {
        if (!sucess) {
            [self showNetworkError];
        }
        [self.tableView reloadData];
    }];
    [self.tableView reloadData];
}
- (void)showNetworkError{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Whoops..." message:@"There was an error accessing the iTunes Store. Please try again." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.search.isLoading) {
        return 1;
    }else if (!self.search.hasSearched) {
        return 0;
    }else if (self.search.searchResults.count == 0){
        return 1;
    }else {
        return self.search.searchResults.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.search.isLoading) {
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kloadingCell forIndexPath:indexPath];
        UIActivityIndicatorView *spinner = [cell viewWithTag:100];
        [spinner startAnimating];
        return cell;
    }
    if (self.search.searchResults.count == 0) {
        return  [self.tableView dequeueReusableCellWithIdentifier:knothingFoundCell forIndexPath:indexPath];
    }else{
        HDZAttentionCell * cell = [self.tableView dequeueReusableCellWithIdentifier:kHDZAttentionCell forIndexPath:indexPath];
        HDZSearchResult *searchResult = self.search.searchResults[indexPath.row];
        [cell configureForResult:searchResult];
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    HDZSearchResult *searchResult = self.search.searchResults[indexPath.row];
    NSLog(@"searchResult.attentionCellHeight --%f",searchResult.attentionCellHeight);
    return searchResult.attentionCellHeight;
}


@end
