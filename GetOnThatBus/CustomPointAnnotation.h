//
//  CustomPointAnnotation.h
//  GetOnThatBus
//
//  Created by Yi-Chin Sun on 1/20/15.
//  Copyright (c) 2015 Yi-Chin Sun. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface CustomPointAnnotation : MKPointAnnotation

@property NSString *id;
@property NSString *uuid;
@property NSString *position;
@property NSURL *address;
@property NSString *stopID;
@property NSString *direction;
@property NSString *ward;
@property NSString *intermodal;

-(instancetype)initWithDictionary: (NSDictionary *) dictionary;

@end
