//
//  GeoPointAnnotation.m
//  Geolocations
//
//  Created by Héctor Ramos on 8/2/12.
//  Copyright (c) 2013 Parse, Inc. All rights reserved.
//

#import "GeoPointAnnotation.h"

@interface GeoPointAnnotation()
@property (nonatomic, strong) PFObject *object;
- (void)updateAnnotation;
@end

@implementation GeoPointAnnotation

#pragma mark - NSObject

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"geoPointAnnotiationUpdated" object:nil];
}

#pragma mark - Initialization

- (id)initWithObject:(PFObject *)aObject {
    self = [super init];
    if (self) {
        _object = aObject;
        
        PFGeoPoint *geoPoint = self.object[@"location"];
        [self setGeoPoint:geoPoint];
        
        // Listen for annotation updates. Triggers a refresh whenever an annotation is dragged and dropped.
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateAnnotation) name:@"geoPointAnnotiationUpdated" object:nil];
    }
    return self;
}


#pragma mark - MKAnnotation

// Called when the annotation is dragged and dropped. We update the geoPoint with the new coordinates.
- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate {
    PFGeoPoint *geoPoint = [PFGeoPoint geoPointWithLatitude:newCoordinate.latitude longitude:newCoordinate.longitude];
    [self setGeoPoint:geoPoint];
    [self.object setObject:geoPoint forKey:@"location"];
    [self.object saveEventually:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // Send a notification when this geopoint has been updated. MasterViewController will be listening for this notification, and will reload its data when this notification is received.
            [[NSNotificationCenter defaultCenter] postNotificationName:@"geoPointAnnotiationUpdated" object:self.object];
        }
    }];
}


#pragma mark - ()

- (void)setGeoPoint:(PFGeoPoint *)geoPoint {
    _coordinate = CLLocationCoordinate2DMake(geoPoint.latitude, geoPoint.longitude);
    
    [self updateAnnotation];
}

- (void)updateAnnotation
{
    static NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.timeStyle = NSDateFormatterMediumStyle;
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    }
    
    static NSNumberFormatter *numberFormatter = nil;
    if (numberFormatter == nil) {
        numberFormatter = [[NSNumberFormatter alloc] init];
        numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
        numberFormatter.maximumFractionDigits = 3;
    }
    
    // callout won't work if title is nil
    _title = [dateFormatter stringFromDate:self.object.updatedAt];
    if (![_title length]) {
        _title = @"Not yet saved";
    }
    _subtitle = [NSString stringWithFormat:@"%@, %@", [numberFormatter stringFromNumber:[NSNumber numberWithDouble:_coordinate.latitude]],
                 [numberFormatter stringFromNumber:[NSNumber numberWithDouble:_coordinate.longitude]]];
}

@end
