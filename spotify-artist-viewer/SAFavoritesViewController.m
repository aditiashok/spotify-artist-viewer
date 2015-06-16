//
//  SAFavoritesViewController.m
//  spotify-artist-viewer
//
//  Created by Aditi Ashok on 6/15/15.
//  Copyright (c) 2015 Intrepid. All rights reserved.
//

#import "SAFavoritesViewController.h"

@interface SAFavoritesViewController ()

@end

@implementation SAFavoritesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"reaching favorites");
    //self.favoriteArtists = [[NSMutableArray alloc] init];
    self.favoriteArtists =[[NSMutableArray alloc]initWithObjects:@"Kesha", @"Pitbull", @"Drake", nil];

    // [self.tableView reloadData];
    
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return [self.favoriteArtists count];
    return 4;
}


-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"favoriteArtist" forIndexPath:indexPath];
    /* if (self.favoriteArtists != nil) {
        cell.textLabel.text = [self.favoriteArtists objectAtIndex: indexPath.row];
    }
    else {
        NSLog(@"cell is nil!");
    } */
    // cell.textLabel.text = [self.favoriteArtists objectAtIndex: indexPath.row];
    cell.textLabel.text = @"hello!";
    return cell;
    
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
