//
//  ViewController.m
//  LocationTester
//
//  Created by Anurag Mishra on 4/7/14.
//  Copyright (c) 2014 garuna. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *latitudeLabel;
@property (strong, nonatomic) IBOutlet UILabel *longitudeLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
- (IBAction)getLocation:(id)sender;

@end

@implementation ViewController
{
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    locationManager = [[CLLocationManager alloc] init];
    geocoder = [[CLGeocoder alloc] init];

}

- (IBAction)getLocation:(id)sender
{
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
//    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation]; //allows access to GPS
}

#pragma mark CLLocationManager delegates

- (void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@", error);
    NSLog(@"Error! Failed to get current Location!");
    
}

- (void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"Location is: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if(currentLocation != nil)
    {
        self.latitudeLabel.text = [NSString stringWithFormat:@"Latitude :%3.3f", currentLocation.coordinate.latitude];
        self.longitudeLabel.text = [NSString stringWithFormat:@"Longitude :%3.3f", currentLocation.coordinate.longitude];
    }
    
    // Reverse Geocoding
    NSLog(@"Resolving the Address");
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
        if (error == nil && [placemarks count] > 0) {
            placemark = [placemarks lastObject];

            self.addressLabel.text = [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@",
                                 placemark.subThoroughfare, placemark.thoroughfare,
                                 placemark.postalCode, placemark.locality,
                                 placemark.administrativeArea,
                                 placemark.country];
 
            //self.addressLabel.text = [NSString stringWithFormat:@"%@", placemark.description];
        } else {
            NSLog(@"%@", error.debugDescription);
        }
    } ];
    
}

@end
