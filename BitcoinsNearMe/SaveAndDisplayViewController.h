//
//  SaveAndDisplayViewController.h
//  BitcoinsNearMe
//
//  Created by Elliot Lee on 3/13/13.
//  Copyright (c) 2013 Grenly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class ELPost;

@interface SaveAndDisplayViewController : UIViewController <MKMapViewDelegate>

@property (strong, nonatomic) ELPost *post;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end
