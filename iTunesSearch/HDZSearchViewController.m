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
@protocol UIViewControllerTransitionCoordinator;
static  NSString *const ksearchResultCell = @"HDZSearchResultCell";
static  NSString *const knothingFoundCell = @"HDZNothingFoundCell";
static  NSString *const kloadingCell = @"LoadingCell";
@interface HDZSearchViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (nonatomic,strong) NSMutableArray<HDZSearchResult *>* searchResults;
@property (nonatomic,assign) BOOL hasSearched;
@property (nonatomic,assign) BOOL isLoading;
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;
@property (nonatomic, strong) HDZLandscapeViewController *landscapeVC;

@end

@implementation HDZSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchResults = [[NSMutableArray alloc]init];
    self.hasSearched = NO;
    self.isLoading = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(108, 0, 0, 0);
    UINib *cell = [UINib nibWithNibName:ksearchResultCell bundle:nil];
    [self.tableView registerNib:cell forCellReuseIdentifier:ksearchResultCell];
    cell = [UINib nibWithNibName:knothingFoundCell bundle:nil];
    [self.tableView registerNib:cell forCellReuseIdentifier:knothingFoundCell];
    cell = [UINib nibWithNibName:kloadingCell bundle:nil];
    [self.tableView registerNib:cell forCellReuseIdentifier:kloadingCell];
    self.tableView.rowHeight = 80;
    [self.searchBar becomeFirstResponder];
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
-(NSURL *)iTunesURLWithSearchText:(NSString *)searchText category:(NSInteger)category{
    NSString *kind;
    switch (category) {
        case 1:
            kind = @"musicTrack";
            break;
        case 2:
            kind = @"software";
            break;
        case 3:
            kind = @"ebook";
            break;
        default:
            kind = @"";
            break;
    }
    NSString *urlString = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@&limit=4&entity=%@",searchText,kind];
    NSString *encodedURL = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:encodedURL];
    //NSLog(@"iTunesURLWithSearchText----%@",url);
    //https://itunes.apple.com/search?term=Justin bieber&limit=4&entity=musicTrack
    return url;
}
- (NSMutableArray<HDZSearchResult *> *)parse:(NSData *)data{
    HDZResultArray * resultArray = [HDZResultArray yy_modelWithJSON:data];
    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:resultArray.results];
    return mutableArray;
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
        detailController.searchResult = self.searchResults[indexPath.row];
    }
}
- (void)performSearch{
    if (self.searchBar.text != nil) {
        [self.searchBar resignFirstResponder];
        [self.dataTask cancel];
        self.isLoading = YES;
        [self.tableView reloadData];
        self.hasSearched = YES;
        [self.searchResults removeAllObjects];
        NSURL *url = [self iTunesURLWithSearchText:self.searchBar.text category:self.segmentedControl.selectedSegmentIndex];
        NSURLSession *session = [NSURLSession sharedSession];
        self.dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
            if (error.code == -999) {
                return ;
            }else if (res.statusCode == 200){
                if (data) {
                    self.searchResults = [self parse:data];
                    dispatch_queue_t mainQueue = dispatch_get_main_queue();
                    dispatch_async(mainQueue, ^{
                        self.isLoading = NO;
                        [self.tableView reloadData];
                    });
                    return;
                }
            }else{
                NSLog(@"performSearch Failure!%@",response);
            }
            dispatch_queue_t mainQueue = dispatch_get_main_queue();
            dispatch_async(mainQueue, ^{
                self.hasSearched = NO;
                self.isLoading = NO;
                [self.tableView reloadData];
                [self showNetworkError];
            });
        }];
        [self.dataTask resume];
    };
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"ShowDetail" sender:indexPath];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.isLoading) {
        return 1;
    }else if (!self.hasSearched) {
        return 0;
    }else if (self.searchResults.count == 0){
        return 1;
    }else {
        return self.searchResults.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isLoading) {
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kloadingCell forIndexPath:indexPath];
        UIActivityIndicatorView *spinner = [cell viewWithTag:100];
        [spinner startAnimating];
        return cell;
    }
    if (self.searchResults.count == 0) {
        return  [self.tableView dequeueReusableCellWithIdentifier:knothingFoundCell forIndexPath:indexPath];
    }else{
        HDZSearchResultCell* cell = [self.tableView dequeueReusableCellWithIdentifier:ksearchResultCell forIndexPath:indexPath];
        HDZSearchResult *searchResult = self.searchResults[indexPath.row];
        [cell configureForResult:searchResult];
        return cell;
    }
}
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.searchResults.count==0 || self.isLoading) {
        return nil;
    }else{
        return indexPath;
    }
}
@end
