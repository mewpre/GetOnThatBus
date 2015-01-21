//
//  JSONParser.h
//  GetOnThatBus
//
//  Created by Yi-Chin Sun on 1/20/15.
//  Copyright (c) 2015 Yi-Chin Sun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BusStopPointAnnotation.h"
@interface JSONParser : NSObject

//Static method (+ instead of -)
//Requires neither an instance of the class nor can they implicitly access the data of such an instance.
+(NSMutableArray *)parseBusStopJSON;

@end

