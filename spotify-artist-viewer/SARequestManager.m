//
//  SARequestManager.m
//  spotify-artist-viewer
//
//  Created by Aditi Ashok on 6/10/15.
//  Copyright (c) 2015 Intrepid. All rights reserved.
//

#import "SARequestManager.h"
#import "SAArtist.h"


@import Foundation;
@interface SARequestManager ()

@end

@implementation SARequestManager

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static SARequestManager *sharedManager = nil;
    dispatch_once(&onceToken, ^{
        sharedManager = [SARequestManager new];
    });
    return sharedManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)getArtistsWithQuery:(NSString *)query
                            success:(void (^)(NSMutableArray *artists))success
                            failure: (void (^) (NSError *error))failure{
    
    NSURL *url = [NSURL URLWithString:query];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    

    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
        if ([data length] > 0 && error == nil) {
            // call success block
            NSMutableArray *artists = [[NSMutableArray alloc]init];
            NSDictionary *jsonObject = [NSJSONSerialization
                             JSONObjectWithData:data
                             options:NSJSONReadingAllowFragments
                             error:&error];
            
            NSDictionary *ar= [jsonObject objectForKey:@"artists"];
            NSArray *items = [ar objectForKey:@"items"];
           // NSArray *images = [items objectForKey:@"images"];
            for (int i = 0; i < [items count]; i++) {
                    SAArtist *a = [[SAArtist alloc]init];
                    a.name =[[items objectAtIndex:i]objectForKey:@"name"];
                    a.identification = [[items objectAtIndex:i]objectForKey:@"id"];
                    /* must access image URL */
                    //NSLog(@"URL: %@", a.imageURL);
                    [artists addObject:a];
            }
            
                success(artists);
            
        }
        else if ([data length] == 0 && error == nil) {
            failure(error);
        }
        else if (error != nil) {
            failure(error);
        }
    
    }];

  
     
     /* ASYNCHRONOUS */
}


- (void)getBioFromArtist:(NSString *)query
                    success:(void (^)(NSString *bio))success
                    failure: (void (^) (NSError *error))failure {
    
    NSURL *url = [NSURL URLWithString:query];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
        if ([data length] > 0 && error == nil) {
            /*success block */
            NSDictionary *jsonObject = [NSJSONSerialization
                                        JSONObjectWithData:data
                                        options:NSJSONReadingAllowFragments
                                        error:&error];

            //NSLog(@"jsonobject: %@",jsonObject);
            NSDictionary *ar= [jsonObject objectForKey:@"response"];
            NSArray *biographies = [ar objectForKey:@"biographies"];
            
            /* switch and look for truncated eventually */
            NSString *text =[[biographies objectAtIndex:0]objectForKey:@"text"];
            //NSLog(@"text: %@",text);
            
            success(text);
            
        }
        else if ([data length] == 0 && error == nil) {
            failure(error);
        }
        else if (error != nil) {
            failure(error);
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
