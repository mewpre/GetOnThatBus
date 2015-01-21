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
#import "BusStopPointAnnotation.h"

@interface RootViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UITableView *busStopTableView;;
@property JSONParser *parser;
@property NSMutableArray *annotationsArray;

@end

@implementation RootViewController

#pragma mark - View-related Methods
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationController.navigationBar.hidden = YES;
    self.busStopTableView.hidden = YES;

    self.annotationsArray = [JSONParser parseBusStopJSON];

    [self loadBusPins];

    [self.mapView showAnnotations:self.mapView.annotations animated:YES];
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

#pragma mark - MapView Methods
//Gets called for every annotation on map
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    BusStopPointAnnotation *busAnnotation = annotation;
    MKPinAnnotationView *pin = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:nil];
    pin.canShowCallout = YES;
    if ([busAnnotation.intermodal isEqualToString:@"Metra"])
    {
        pin.pinColor = MKPinAnnotationColorGreen;
    }
    else if ([busAnnotation.intermodal isEqualToString:@"Pace"])
    {
        pin.pinColor = MKPinAnnotationColorPurple;
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

#pragma mark - TableView Delegate Methods

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    BusStopPointAnnotation *annotation = [self.annotationsArray objectAtIndex:indexPath.row];
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

#pragma mark - Misc. Methods
- (void)loadBusPins
{
    for (BusStopPointAnnotation *annotation in self.annotationsArray)
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
