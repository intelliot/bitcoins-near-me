//
//  UpdatePostViewController.h
//  BitcoinsNearMe
//
//  Created by Elliot Lee on 3/13/13.
//  Copyright (c) 2013 Grenly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface UpdatePostViewController : UITableViewController <CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *location;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

- (IBAction)logOut:(id)sender;

@end
