//
//  JSONParser.m
//  GetOnThatBus
//
//  Created by Yi-Chin Sun on 1/20/15.
//  Copyright (c) 2015 Yi-Chin Sun. All rights reserved.
//

#import "JSONParser.h"

@implementation JSONParser

+(NSMutableArray *)parseBusStopJSON
{
    NSMutableArray *annotationArray = [NSMutableArray new];
    NSString *urlString = @"https://s3.amazonaws.com/mobile-makers-lib/bus.json";
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSArray *jsonArray = [json objectForKey:@"row"];

    for (NSDictionary *busStop in jsonArray)
    {
        BusStopPointAnnotation *annotation = [[BusStopPointAnnotation alloc]initWithDictionary:busStop];
        [annotationArray addObject: annotation];
    }
    return annotationArray;
}

@end
