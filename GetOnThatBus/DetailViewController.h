//
//  DetailViewController.h
//  GetOnThatBus
//
//  Created by Yi-Chin Sun on 1/20/15.
//  Copyright (c) 2015 Yi-Chin Sun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BusStopPointAnnotation.h"

@interface DetailViewController : UIViewController

@property BusStopPointAnnotation *annotation;
@property NSString *busStopName;

@end
