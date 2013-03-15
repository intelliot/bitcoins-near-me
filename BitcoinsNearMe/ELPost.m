//
//  ELPost.m
//  BitcoinsNearMe
//
//  Created by Elliot Lee on 3/13/13.
//  Copyright (c) 2013 Grenly. All rights reserved.
//

#import "ELPost.h"

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
                NSLog(@"succeeded. updatedAt = %@", self.object.updatedAt);
                
                // update GeoPoint
                [[NSNotificationCenter defaultCenter] postNotificationName:@"geoPointAnnotiationUpdated" object:self.object];
            } else {
                NSLog(@"failed");
            }
        }];
    }
    return self;
}

- (PFGeoPoint *)location
{
    return [self.object objectForKey:@"location"];
}

- (id)objectForKey:(NSString *)key
{
    return [self.object objectForKey:key];
}

@end
