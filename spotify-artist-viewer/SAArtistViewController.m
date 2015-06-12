//
//  SAArtistViewController.m
//  spotify-artist-viewer
//
//  Created by Aditi Ashok on 6/9/15.
//  Copyright (c) 2015 Intrepid. All rights reserved.
//

#import "SAArtistViewController.h"
#import "SARequestManager.h"

@interface SAArtistViewController ()

@end

@implementation SAArtistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) getURLFromArtist: (SAArtist*) artist{
    NSLog(@"i'm in getURL");
    /*call get artist bio from here */
    //NSLog(@"name:%@", artist.name);
    NSLog(@"id:%@", artist.identification);
    
    NSString *url = [NSString stringWithFormat:@"http://developer.echonest.com/api/v4/artist/biographies?api_key=DUWJH8RQD34BNV6XO&id=spotify:artist:%@", artist.identification];
    
    NSLog(@"url:%@", url);
    
    
    [[SARequestManager sharedManager] getBioFromArtist:url success:^(NSString *bio) {
        /* display text and artist name */
        
        
    } failure:^(NSError *error) {
        /* display nothing or error message */
        if (error == nil) {
            NSLog(@"Nothing was downloaded");
            
        }
        else {
            NSLog(@"Error: %@", error);
        }
    }];

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
