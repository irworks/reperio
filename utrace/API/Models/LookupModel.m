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

@end
