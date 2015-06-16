//
//  SASearchViewController.m
//  spotify-artist-viewer
//
//  Created by Aditi Ashok on 6/9/15.
//  Copyright (c) 2015 Intrepid. All rights reserved.
//

#import "SASearchViewController.h"
#import "SAArtist.h"
#import "SARequestManager.h"
#import "SAArtistViewController.h"

@interface SASearchViewController () <UISearchBarDelegate, UISearchResultsUpdating, UISearchControllerDelegate, UISearchDisplayDelegate>

@property (strong, nonatomic) NSMutableArray *artists;
@property (strong, nonatomic) NSMutableArray *filteredArtists;
@property (strong, nonatomic) UISearchController *searchController;
@property (nonatomic) BOOL isSearching;





@end

@implementation SASearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.artists = [[NSMutableArray alloc] init];
    self.filteredArtists = [[NSMutableArray alloc] init];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor blackColor];
    
    [self.tableView reloadData];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



#pragma mark - UITableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_isSearching) {
        NSLog(@"%d", (int)self.filteredArtists.count);
        return [_filteredArtists count];
    }
    
    else {
        return [_artists count];
    }
}


-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"myArtist"];

    if (_isSearching) {
        SAArtist *artist = [_filteredArtists objectAtIndex:indexPath.row];
        cell.textLabel.text = artist.name;
    }
    else {
        SAArtist *artist = [_artists objectAtIndex:indexPath.row];
        cell.textLabel.text = artist.name;
        
    }
    cell.contentView.backgroundColor = [UIColor blackColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    return cell;

}

- (void)searchTableList {
    NSString *searchString = self.searchController.searchBar.text;
    
    for (NSString *tempStr in _artists) {
        NSComparisonResult result = [tempStr compare:searchString options:
                                     (NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch)
                                               range:NSMakeRange(0, [searchString length])];
        if (result == NSOrderedSame) {
            [_filteredArtists addObject:tempStr];
        }
    }
}


#pragma mark - UISearchView
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    _isSearching = YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"Text change - %d",_isSearching);
    [_filteredArtists removeAllObjects];
    
    if([searchText length] != 0) {
        _isSearching = YES;
        
        [[SARequestManager sharedManager] getArtistsWithQuery:
                                          searchText success:^(NSMutableArray *artists) {
            for (SAArtist *artist in artists) {
                [self.filteredArtists addObject:artist];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
            
        } failure:^(NSError *error) {
            if (error == nil) {
                NSLog(@"Nothing was downloaded");
                
            }
            else {
                NSLog(@"Error: %@", error);
            }
        }
         ];}
    
    else {
        _isSearching = NO;
    };
   
    
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"artistSegue"]){
        SAArtistViewController *artistViewController = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        artistViewController.artist = [_filteredArtists objectAtIndex:indexPath.row];
    }

    
}

@end
