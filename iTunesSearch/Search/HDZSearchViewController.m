//
//  ViewController.m
//  iTunesSearch
//
//  Created by 何东洲 on 2018/3/29.
//  Copyright © 2018年 何东洲. All rights reserved.
//

#import "HDZSearchViewController.h"
#import "HDZSearchResult.h"
#import "HDZSearchResultCell.h"
#import "YYModel.h"
#import "HDZDetailViewController.h"
#import "HDZLandscapeViewController.h"
#import "HDZSearch.h"
@protocol UIViewControllerTransitionCoordinator;
static  NSString *const ksearchResultCell = @"HDZSearchResultCell";
static  NSString *const knothingFoundCell = @"HDZNothingFoundCell";
static  NSString *const kloadingCell = @"LoadingCell";
@interface HDZSearchViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (nonatomic, strong)HDZSearch *search;
@property (nonatomic, strong) HDZLandscapeViewController *landscapeVC;

@end

@implementation HDZSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.search = [[HDZSearch alloc] init];
    self.tableView.contentInset = UIEdgeInsetsMake(108, 0, 0, 0);
    UINib *cell = [UINib nibWithNibName:ksearchResultCell bundle:nil];
    [self.tableView registerNib:cell forCellReuseIdentifier:ksearchResultCell];
    cell = [UINib nibWithNibName:knothingFoundCell bundle:nil];
    [self.tableView registerNib:cell forCellReuseIdentifier:knothingFoundCell];
    cell = [UINib nibWithNibName:kloadingCell bundle:nil];
    [self.tableView registerNib:cell forCellReuseIdentifier:kloadingCell];
    self.tableView.rowHeight = 80;
    //[self.searchBar becomeFirstResponder];
}
-(void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [super willTransitionToTraitCollection:newCollection withTransitionCoordinator:coordinator];
    switch (newCollection.verticalSizeClass) {
        case UIUserInterfaceSizeClassUnspecified:
            [self hideLandscapeWithCoordinator:coordinator];
            break;
        case UIUserInterfaceSizeClassCompact:
            [self showLandscapeWithCoordinator:coordinator];
            break;
        case UIUserInterfaceSizeClassRegular:
            [self hideLandscapeWithCoordinator:coordinator];
            break;
    }
    
}
- (IBAction)segmentChanged:(UISegmentedControl *)sender {
    [self performSearch];
}
// MARK:- Private Methods
-(UIBarPosition)positionForBar:(id<UIBarPositioning>)bar{
    return UIBarPositionTopAttached;
}

- (void)showNetworkError{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Whoops..." message:@"There was an error accessing the iTunes Store. Please try again." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self performSearch];
}
-(void)showLandscapeWithCoordinator:(id<UIViewControllerTransitionCoordinator >)coordinator{
    if (!self.landscapeVC) {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        self.landscapeVC = (HDZLandscapeViewController *)[storyBoard instantiateViewControllerWithIdentifier: @"HDZLandscapeViewController"];
        if (self.landscapeVC) {
            self.landscapeVC.view.frame = self.view.bounds;
            self.landscapeVC.view.alpha = 0;
            [self.view addSubview:self.landscapeVC.view];
            [self addChildViewController:self.landscapeVC];
            [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                self.landscapeVC.view.alpha = 1;
                [self.searchBar resignFirstResponder];
                if (self.presentedViewController) {
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
            } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                [self.landscapeVC didMoveToParentViewController:self];
            }];
            
            
        }
    }
}
-(void)hideLandscapeWithCoordinator:(id<UIViewControllerTransitionCoordinator>) coordinator{
    if (self.landscapeVC) {
        [self.landscapeVC willMoveToParentViewController:nil];
        [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            self.landscapeVC.view.alpha = 0;
        } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            [self.landscapeVC.view removeFromSuperview];
            [self.landscapeVC removeFromParentViewController];
            self.landscapeVC = nil;
        }];
       
    };
}

    

// MARK:- Navigation
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier  isEqual: @"ShowDetail"]) {
        HDZDetailViewController *detailController = segue.destinationViewController;
        NSIndexPath *indexPath = sender;
        detailController.searchResult = self.search.searchResults[indexPath.row];
    }
}
- (void)performSearch{
    [self.search performSearchForText:self.searchBar.text category:self.segmentedControl.selectedSegmentIndex completion:^(BOOL sucess) {
        if (!sucess) {
            [self showNetworkError];
        }
        [self.tableView reloadData];
    }];
    [self.tableView reloadData];
    [self.searchBar resignFirstResponder];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"ShowDetail" sender:indexPath];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
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
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.search.isLoading) {
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kloadingCell forIndexPath:indexPath];
        UIActivityIndicatorView *spinner = [cell viewWithTag:100];
        [spinner startAnimating];
        return cell;
    }
    if (self.search.searchResults.count == 0) {
        return  [self.tableView dequeueReusableCellWithIdentifier:knothingFoundCell forIndexPath:indexPath];
    }else{
        HDZSearchResultCell* cell = [self.tableView dequeueReusableCellWithIdentifier:ksearchResultCell forIndexPath:indexPath];
        HDZSearchResult *searchResult = self.search.searchResults[indexPath.row];
        [cell configureForResult:searchResult];
        return cell;
    }
}
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.search.searchResults.count==0 || self.search.isLoading) {
        return nil;
    }else{
        return indexPath;
    }
}
@end
