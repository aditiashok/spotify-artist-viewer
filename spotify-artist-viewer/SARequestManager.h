//
//  SARequestManager.h
//  spotify-artist-viewer
//
//  Created by Aditi Ashok on 6/10/15.
//  Copyright (c) 2015 Intrepid. All rights reserved.
//

//asdfasdfasdf

#import <UIKit/UIKit.h>
#import "SAArtist.h"

@interface SARequestManager : UIViewController

+ (instancetype)sharedManager;
- (void)getArtistsWithQuery:(NSString *)query
                    success:(void (^)(NSMutableArray *artists))success
                    failure: (void (^) (NSError *error))failure;

- (void)getBioFromArtist:(NSString *)query
                 success:(void (^)(NSString *bio))success
                 failure: (void (^) (NSError *error))failure;
@end
