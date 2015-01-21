//
//  DetailViewController.m
//  GetOnThatBus
//
//  Created by Yi-Chin Sun on 1/20/15.
//  Copyright (c) 2015 Yi-Chin Sun. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (strong, nonatomic) IBOutlet UILabel *stopIDLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UILabel *busRoutesLabel;
@property (strong, nonatomic) IBOutlet UILabel *directionLabel;
@property (strong, nonatomic) IBOutlet UILabel *intermodalLabel;

@property NSString *address;

@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    [self getAddressFromCoordinates];

    self.navigationItem.title = self.annotation.title;
    self.busRoutesLabel.text = [NSString stringWithFormat:@"Routes:\n%@",self.annotation.subtitle];
    self.busRoutesLabel.numberOfLines = 2;
    self.intermodalLabel.text = self.annotation.intermodal;
    self.stopIDLabel.text = [NSString stringWithFormat:@"Stop ID: %@",self.annotation.stopID];
    self.directionLabel.text = [self getBusDirectionString:self.annotation.direction];
}

-(void)getAddressFromCoordinates
{
    //Creates a CLLocation based on the coordinates of the annotation
    CLLocation *busStopLocation = [[CLLocation alloc]initWithLatitude:self.annotation.coordinate.latitude longitude:self.annotation.coordinate.longitude];

    //Initialize geocoder
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];

    //Does a reverse lookup to find placemark based on locatoin
    [geocoder reverseGeocodeLocation:busStopLocation completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if(placemarks && placemarks.count > 0)
         {
             CLPlacemark *placemark= [placemarks objectAtIndex:0];

             //Ensures (null) does not appear in addressLabel
             //[placemark thoroughfare] returns the streeet address
             NSString *streetAddress = @"";
             if ([placemark thoroughfare])
             {
                 streetAddress = [placemark thoroughfare];
             }
             //[placemark locality] returns the city
             //[placemark administrativeArea] returns the state
             self.addressLabel.text = [NSString stringWithFormat:@"%@\n%@, %@", streetAddress, [placemark locality], [placemark administrativeArea]];
             self.addressLabel.numberOfLines = 2;
         }
     }];
}

-(NSString *)getBusDirectionString: (NSString*)abbreviation
{
    if ([abbreviation isEqualToString:@"NB"])
    {
        return @"North-Bound";
    }
    else if ([abbreviation isEqualToString:@"SB"])
    {
        return @"South-Bound";
    }
    else if ([abbreviation isEqualToString:@"EB"])
    {
        return @"East-Bound";
    }
    else
    {
        return @"West-Bound";
    }
}

@end
