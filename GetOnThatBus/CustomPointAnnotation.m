//
//  CustomPointAnnotation.m
//  GetOnThatBus
//
//  Created by Yi-Chin Sun on 1/20/15.
//  Copyright (c) 2015 Yi-Chin Sun. All rights reserved.
//

#import "CustomPointAnnotation.h"

@implementation CustomPointAnnotation

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self)
    {
        self.id = dictionary[@"_id"];
        self.uuid = dictionary[@"_uuid"];
        self.position = dictionary[@"_position"];
        self.address = [NSURL URLWithString:dictionary[@"_address"]];
        self.stopID = dictionary[@"stop_id"];
        self.title = dictionary[@"cta_stop_name"];
        self.direction = dictionary[@"direction"];
        self.subtitle = dictionary[@"routes"];
        self.intermodal = dictionary[@"inter_modal"];
        self.ward = dictionary[@"ward"];
        double latitude = [dictionary[@"latitude"] doubleValue];
        double longitude;
        //Makes sure bus stops are in Chicago and not in the middle of China
        if ([dictionary[@"longitude"] doubleValue] > 0)
        {
             longitude = -[dictionary[@"longitude"] doubleValue];
        }
        else
        {
            longitude = [dictionary[@"longitude"]doubleValue];
        }
        self.coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    }
    return self;
}

@end
