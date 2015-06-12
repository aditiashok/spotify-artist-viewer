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

@interface SAArtistViewController ()
@property (weak) IBOutlet UITextView *bioTextView;
@property (weak, nonatomic) IBOutlet UIImageView *artistImage;
@property (weak, nonatomic) IBOutlet UILabel *nameTextView;

@end

@implementation SAArtistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.bioTextView scrollRangeToVisible:NSMakeRange(0, 1)];
    
    
    NSURL *imageLink = self.artist.imageURL;
    [self.artistImage sd_setImageWithURL:imageLink];
    [self getURLFromArtist];
    
    

    
    
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
   
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) getURLFromArtist {
    [[SARequestManager sharedManager] getBioFromArtist:self.artist.identification success:^(NSString *bio) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.bioTextView.text = bio;
            self.nameTextView.text = self.artist.name;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
