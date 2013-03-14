//
//  UpdatePostViewController.m
//  BitcoinsNearMe
//
//  Created by Elliot Lee on 3/13/13.
//  Copyright (c) 2013 Grenly. All rights reserved.
//

#import "UpdatePostViewController.h"
#import <Parse/Parse.h>
#import <AddressBookUI/AddressBookUI.h>

@interface UpdatePostViewController ()

@end

@implementation UpdatePostViewController

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
    
    [[self locationManager] startUpdatingLocation];
    
    PFUser *currentUser = [PFUser currentUser];
    self.welcomeLabel.text = [NSString stringWithFormat:@"Welcome, %@!", currentUser.username];
}

- (CLLocationManager *)locationManager {
    if (_locationManager != nil) {
        return _locationManager;
    }
    
    _locationManager = [[CLLocationManager alloc] init];
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    [_locationManager setDelegate:self];
    
    // uncomment this line if targeting iOS < 6.0
    // in iOS 6.0+ this is NSLocationUsageDescription in Info.plist
    //[_locationManager setPurpose:@"Display your location to other Bitcoiners"];
    
    return _locationManager;
}

// Delegate method from the CLLocationManagerDelegate protocol.
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    // If it's a relatively recent event, turn off updates to save power
    CLLocation* location = [locations lastObject];
    NSDate* eventDate = location.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (abs(howRecent) < 15.0) {
        
        double accuracyMeters = location.horizontalAccuracy;
        NSLog(@"accuracy: %lf", accuracyMeters);
        if (accuracyMeters < 20.0) {
            // Turn off location services when you are not using them
            [self.locationManager stopUpdatingLocation];
            NSLog(@"Got location with accuracy < 20");
        }
        
        // If the event is recent, do something with it.
        
        self.location = location;
        
        // requires iOS 5.0+
        CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
        [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
            for (CLPlacemark *placemark in placemarks) {
                NSLog(@"%@", [placemark locality]);
                
                NSString *formattedAddress = ABCreateStringWithAddressDictionary(placemark.addressDictionary, NO);
                
//                static NSDictionary *usStateAbbreviations = nil;
//                if (usStateAbbreviations == nil) {
//                    usStateAbbreviations = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"USStateAbbreviations" ofType:@"plist"]];
//                }
//                NSString *stateAbbreviation = [self.usStateAbbreviations objectForKey:[state uppercaseString]];
                
                NSLog(@"%@", formattedAddress);
                self.locationLabel.text = formattedAddress;
                
                [self.tableView reloadData]; // this resizes the label to satisfy constraints
            }
        }];
        
        //TODO: enable Post/Update button
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logOut:(id)sender {
    [PFUser logOut];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
