//
//  ELPost.h
//  BitcoinsNearMe
//
//  Created by Elliot Lee on 3/13/13.
//  Copyright (c) 2013 Grenly. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PFObject;
@class PFUser;
@class CLLocation;

@interface ELPost : NSObject

@property (strong, nonatomic) PFObject *object;

- (id)initWithUser:(PFUser *)user location:(CLLocation *)location;

@end
