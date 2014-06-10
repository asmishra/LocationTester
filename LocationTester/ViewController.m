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

CLLocationManager *locationManager;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    locationManager = [[CLLocationManager alloc] init];
}

- (IBAction)getLocation:(id)sender
{
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
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
        self.latitudeLabel.text = [NSString stringWithFormat:@"Latitude :%3f", currentLocation.coordinate.latitude];
        self.longitudeLabel.text = [NSString stringWithFormat:@"Longitude :%3f", currentLocation.coordinate.longitude];
    }
    
}

@end
