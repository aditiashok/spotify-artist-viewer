//
//  SAArtist.h
//  spotify-artist-viewer
//
//  Copyright (c) 2015 Intrepid. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SAArtist : NSObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *identification;
@property (strong, nonatomic) NSString *bio;
@property (strong, nonatomic) NSURL *imageURL;

@end
