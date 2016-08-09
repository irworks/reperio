//
//  CustomLabel.m
//  utrace
//
//  Created by Ilja Rozhko on 09.08.16.
//  Copyright © 2016 IR Works. All rights reserved.
//

#import "CustomLabel.h"

@implementation CustomLabel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setDefaultValues];
    }
    return self;
}

- (instancetype)initWithBoldFont:(BOOL)boldFont
{
    self = [self init];
    if(boldFont) {
        [self setBoldDefaultValues];
    }
    return self;
}

- (void)setDefaultValues {
    [self setFont:[UIFont systemFontOfSize:REGULAR_FONT_SIZE]];
}

- (void)setBoldDefaultValues {
    [self setFont:[UIFont boldSystemFontOfSize:REGULAR_FONT_SIZE]];
}

@end
