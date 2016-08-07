//
//  EMKPointAnnotation.h
//  utrace
//
//  Created by Ilja Rozhko on 07.08.16.
//  Copyright © 2016 IR Works. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "ResultElement.h"

@interface EMKPointAnnotation : MKPointAnnotation

@property (nullable) ResultElement *resultElement;

@end
