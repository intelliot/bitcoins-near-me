//
//  ELPost.m
//  BitcoinsNearMe
//
//  Created by Elliot Lee on 3/13/13.
//  Copyright (c) 2013 Grenly. All rights reserved.
//

#import "ELPost.h"
#import <Parse/Parse.h>

@implementation ELPost

- (id)initWithUser:(PFUser *)user location:(CLLocation *)location
{
    if ((self = [super init])) {
        CLLocationCoordinate2D coordinate = [location coordinate];
        PFGeoPoint *geoPoint = [PFGeoPoint geoPointWithLatitude:coordinate.latitude longitude:coordinate.longitude];
        
        self.object = [PFObject objectWithClassName:@"Post"];
        [self.object setObject:user forKey:@"user"];
        [self.object setObject:geoPoint forKey:@"location"];
        [self.object saveEventually:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"succeeded");
            } else {
                NSLog(@"failed");
            }
        }];
    }
    return self;
}

@end
