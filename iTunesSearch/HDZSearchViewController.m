//
//  ViewController.m
//  iTunesSearch
//
//  Created by 何东洲 on 2018/3/29.
//  Copyright © 2018年 何东洲. All rights reserved.
//

#import "HDZSearchViewController.h"
#import "HDZSearchResult.h"
@interface HDZSearchViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic,strong) NSMutableArray<HDZSearchResult *>* searchResults;
@property (nonatomic,assign)BOOL hasSearched;
@end

@implementation HDZSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchResults = [[NSMutableArray alloc]init];
    self.hasSearched = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
}
-(UIBarPosition)positionForBar:(id<UIBarPositioning>)bar{
    return UIBarPositionTop;
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    [self.searchResults removeAllObjects];
    if (![searchBar.text isEqualToString: @"justin bieber"]) {
        for (int i=0 ; i<2; i++) {
            HDZSearchResult* searchResult = [[HDZSearchResult alloc] init];
            searchResult.name = [NSString stringWithFormat:@"Fake result %d",i];
            searchResult.artistName = searchBar.text;
            [self.searchResults addObject:searchResult];
        }
    }
    self.hasSearched = YES;
    [self.tableView reloadData];
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (!self.hasSearched) {
        return 0;
    }else if (self.searchResults.count == 0){
        return 1;
    }else{
        return self.searchResults.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"SearchResultCell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    if (self.searchResults.count == 0 ) {
        cell.textLabel.text = @"Nothing found";
        cell.detailTextLabel.text = @"";
    }else{
        HDZSearchResult *searchResult = self.searchResults[indexPath.row];
        cell.textLabel.text = searchResult.name;
        cell.detailTextLabel.text = searchResult.artistName;
    }
    return cell;
}
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.searchResults.count==0) {
        return nil;
    }else{
        return indexPath;
    }
}
@end
