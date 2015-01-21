//
//  DetailViewController.m
//  GetOnThatBus
//
//  Created by Yi-Chin Sun on 1/20/15.
//  Copyright (c) 2015 Yi-Chin Sun. All rights reserved.
//

#import "DetailViewController.h"
#import "CustomPointAnnotation.h"

@interface DetailViewController ()
@property (strong, nonatomic) IBOutlet UILabel *busRoutesLabel;
@property (strong, nonatomic) IBOutlet UILabel *intermodalLabel;
@property (strong, nonatomic) IBOutlet UILabel *stopIDLabel;
@property (strong, nonatomic) IBOutlet UILabel *directionLabel;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.title = self.annotation.title;
    self.busRoutesLabel.text = [NSString stringWithFormat:@"Routes:\n%@",self.annotation.subtitle];
    self.busRoutesLabel.numberOfLines = 2;
    self.intermodalLabel.text = self.annotation.intermodal;
    self.stopIDLabel.text = [NSString stringWithFormat:@"Stop ID: %@",self.annotation.stopID];
    if ([self.annotation.direction isEqualToString:@"NB"])
    {
        self.directionLabel.text = @"North-Bound";
    }
    else if ([self.annotation.direction isEqualToString:@"SB"])
    {
        self.directionLabel.text = @"South-Bound";
    }
    else if ([self.annotation.direction isEqualToString:@"EB"])
    {
        self.directionLabel.text = @"East-Bound";
    }
    else
    {
        self.directionLabel.text = @"West-Bound";
    }

}

@end
