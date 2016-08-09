//
//  LookupModel.m
//  utrace
//
//  Created by Ilja Rozhko on 08.08.16.
//  Copyright © 2016 IR Works. All rights reserved.
//

#import "LookupModel.h"

@implementation LookupModel

- (void)setLocWithNSString:(NSString *)loc {
    NSArray *itemArray = [loc componentsSeparatedByString:@","];
    
    if([itemArray count] == 2) {
        _loc = CLLocationCoordinate2DMake([[itemArray firstObject] doubleValue], [[itemArray lastObject] doubleValue]);
    }
}

- (NSString *)getLocationString {
    NSString *locationString = @"";
    
    if(![[self city] isEqualToString:@""]) {
        locationString = [[self city] stringByAppendingString:@", "];
    }
    
    if(![[self region] isEqualToString:@""]) {
        locationString = [locationString stringByAppendingString:[[self region] stringByAppendingString:@", "]];
    }
    
    if(![[self country] isEqualToString:@""]) {
        locationString = [locationString stringByAppendingString:[self country]];
    }

    return locationString;
}

@end
