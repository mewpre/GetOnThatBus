//
//  JSONParser.h
//  GetOnThatBus
//
//  Created by Yi-Chin Sun on 1/20/15.
//  Copyright (c) 2015 Yi-Chin Sun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomPointAnnotation.h"
@interface JSONParser : NSObject

+(NSMutableArray *)parseBusStopJSON;

@end

