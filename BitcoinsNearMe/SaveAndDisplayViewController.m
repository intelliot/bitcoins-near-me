//
//  SaveAndDisplayViewController.m
//  BitcoinsNearMe
//
//  Created by Elliot Lee on 3/13/13.
//  Copyright (c) 2013 Grenly. All rights reserved.
//

#import "SaveAndDisplayViewController.h"
#import "ELPost.h"
#import <Parse/Parse.h>
#import "GeoPointAnnotation.h"

@interface SaveAndDisplayViewController ()

@end

@implementation SaveAndDisplayViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    PFGeoPoint *geoPoint = [self.post location];
    
    // center the map around the geopoint
    [self.mapView setRegion:MKCoordinateRegionMake(
       CLLocationCoordinate2DMake(geoPoint.latitude, geoPoint.longitude),
       MKCoordinateSpanMake(0.01, 0.01)
       )];
    
    GeoPointAnnotation *annotation = [[GeoPointAnnotation alloc] initWithObject:self.post.object];
    [self.mapView addAnnotation:annotation];
}

// from Geolocations by Parse
#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    static NSString *GeoPointAnnotationIdentifier = @"RedPin";
    
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:GeoPointAnnotationIdentifier];
    
    if (!annotationView) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:GeoPointAnnotationIdentifier];
        annotationView.pinColor = MKPinAnnotationColorRed;
        annotationView.canShowCallout = YES;
        annotationView.draggable = YES;
        annotationView.animatesDrop = YES;
    }
    
    return annotationView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
