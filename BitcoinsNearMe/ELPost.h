//
//  ELPost.h
//  BitcoinsNearMe
//
//  Created by Elliot Lee on 3/13/13.
//  Copyright (c) 2013 Grenly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@class CLLocation;

@interface ELPost : NSObject

@property (strong, nonatomic) PFObject *object;

- (id)initWithUser:(PFUser *)user location:(CLLocation *)location;
- (PFGeoPoint *)location;

@end
