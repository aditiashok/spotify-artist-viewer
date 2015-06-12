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
//@property (weak) IBOutlet UITableView *tableView;


@end

@implementation SASearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.artists = [[NSMutableArray alloc] init];
    self.filteredArtists = [[NSMutableArray alloc] init];
    
    
    [self.tableView reloadData]; //refreshes
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

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
    
    NSLog(@"cell.label %@", cell.textLabel);
    
    return cell;

}

- (void)searchTableList {
    NSString *searchString = self.searchController.searchBar.text;
    
    for (NSString *tempStr in _artists) {
        NSComparisonResult result = [tempStr compare:searchString options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchString length])];
        if (result == NSOrderedSame) {
            [_filteredArtists addObject:tempStr];
        }
    }
}





- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    _isSearching = YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"Text change - %d",_isSearching);
    [_filteredArtists removeAllObjects];
    
    if([searchText length] != 0) {
        _isSearching = YES;
        
        [[SARequestManager sharedManager] getArtistsWithQuery:searchText success:^(NSMutableArray *artists) {
            for (SAArtist *a in artists) {
                [self.filteredArtists addObject:a];
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"artistSegue" sender:self.tableView];
    
}








//use spotify search API to retrieve artist from table results
// how does this interact with the table control view?

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"artistSegue"]){
        SAArtistViewController *artistViewController = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        artistViewController.artist = [_filteredArtists objectAtIndex:indexPath.row];
    }

    
    
}

@end
