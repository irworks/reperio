//
//  LookupModel.h
//  utrace
//
//  Created by Ilja Rozhko on 08.08.16.
//  Copyright © 2016 IR Works. All rights reserved.
//

#import "BaseModel.h"
#import <MapKit/MapKit.h>

@interface LookupModel : BaseModel

@property (strong, nonatomic, nullable) NSString <Optional> *ip;
@property (strong, nonatomic, nullable) NSString <Optional> *hostname;
@property (strong, nonatomic, nullable) NSString <Optional> *city;
@property (strong, nonatomic, nullable) NSString <Optional> *region;
@property (strong, nonatomic, nullable) NSString <Optional> *country;
@property (nonatomic) CLLocationCoordinate2D loc;
@property (strong, nonatomic, nullable) NSString <Optional> *org;

@end
