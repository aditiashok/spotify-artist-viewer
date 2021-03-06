//
//  SAArtistViewController.m
//  spotify-artist-viewer
//
//  Created by Aditi Ashok on 6/9/15.
//  Copyright (c) 2015 Intrepid. All rights reserved.
//

#import "SAArtistViewController.h"
#import "SARequestManager.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SAFavoritesViewController.h"

@interface SAArtistViewController ()
@property (weak) IBOutlet UITextView *bioTextView;
@property (weak, nonatomic) IBOutlet UIImageView *artistImage;
@property (weak, nonatomic) IBOutlet UILabel *nameTextView;

@end

@implementation SAArtistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.bioTextView scrollRangeToVisible:NSMakeRange(0, 1)];
    self.view.backgroundColor = [UIColor blackColor];
    
    
    
    NSURL *imageLink = self.artist.imageURL;
    [self.artistImage sd_setImageWithURL:imageLink];
    [self getURLFromArtist];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
   
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) getURLFromArtist {
    [[SARequestManager sharedManager] getBioFromArtist:self.artist.identification success:^(NSString *bio) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.bioTextView.text = bio;
            
            self.bioTextView.backgroundColor = [UIColor blackColor];
            self.bioTextView.textColor= [UIColor whiteColor];

            self.nameTextView.text = self.artist.name;
            self.nameTextView.textColor = [UIColor whiteColor];
        });

        
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


@end
