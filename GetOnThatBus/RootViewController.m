//
//  ViewController.m
//  GetOnThatBus
//
//  Created by Yi-Chin Sun on 1/20/15.
//  Copyright (c) 2015 Yi-Chin Sun. All rights reserved.
//

#import "RootViewController.h"
#import "DetailViewController.h"
#import <MapKit/MapKit.h>

#import "JSONParser.h"
#import "CustomPointAnnotation.h"

@interface RootViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property JSONParser *parser;
@property (strong, nonatomic) IBOutlet UITableView *busStopTableView;
@property (strong, nonatomic) IBOutlet UIView *subView;
@property CLLocationManager *locationManager;
@property NSMutableArray *annotationsArray;

@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.busStopTableView.hidden = YES;
    self.annotationsArray = [JSONParser parseBusStopJSON];
    self.locationManager = [CLLocationManager new];
    [self.locationManager requestWhenInUseAuthorization];
    self.mapView.showsUserLocation = YES;
    [self loadBusPins];

    [self.mapView showAnnotations:self.mapView.annotations animated:YES];
}

//Gets called for every annotation on map
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKPinAnnotationView *pin = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:nil];
    pin.canShowCallout = YES;
    CustomPointAnnotation *customAnnotation = annotation;
    if ([customAnnotation.intermodal isEqualToString:@"Metra"])
    {
        pin.pinColor = MKPinAnnotationColorPurple;
    }
    else if ([customAnnotation.intermodal isEqualToString:@"Pace"])
    {
        pin.pinColor = MKPinAnnotationColorGreen;
    }
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [rightButton setTitle:annotation.title forState:UIControlStateNormal];
    [pin setRightCalloutAccessoryView:rightButton];

    return pin;

}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    [self performSegueWithIdentifier:@"detailSegue" sender:view];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    CustomPointAnnotation *annotation = [self.annotationsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = annotation.title;
    cell.detailTextLabel.text = annotation.subtitle;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"detailSegue" sender:tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.annotationsArray.count;
}
- (IBAction)segmentSwitch:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex == 0)
    {
        self.navigationController.navigationBar.hidden = YES;
        self.mapView.hidden = NO;
        self.busStopTableView.hidden = YES;
    }
    else
    {
        self.navigationController.navigationBar.hidden = NO;
        self.busStopTableView.hidden = NO;
        self.mapView.hidden = YES;
    }
}

//Helper Method to load pins
- (void)loadBusPins
{
    for (CustomPointAnnotation *annotation in self.annotationsArray)
    {
        [self.mapView addAnnotation:annotation];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DetailViewController *dvc = segue.destinationViewController;
    if ([sender isKindOfClass:[MKAnnotationView class]])
    {
        MKAnnotationView *annotationView = sender;
        dvc.annotation = annotationView.annotation;
    }
    else if ([sender isKindOfClass:[UITableView class]])
    {
        UITableView *tableView = sender;
        NSIndexPath *index = tableView.indexPathForSelectedRow;
        dvc.annotation = [self.annotationsArray objectAtIndex:index.row];
    }

}

@end
