//
//  ViewController.h
//  utrace
//
//  Created by Ilja Rozhko on 07.08.16.
//  Copyright © 2016 IR Works. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#import "BaseViewController.h"
#import "LookupModel.h"
#import "EMKPointAnnotation.h"

@interface ViewController : BaseViewController<MKMapViewDelegate> {
    __weak IBOutlet UITextField *searchField;
    __weak IBOutlet MKMapView *mapView;
}

- (IBAction)searchBtnClicked:(id _Nonnull)sender;
- (void)moveMapToLocation:(CLLocationCoordinate2D)location;
- (void)addMarkerToMapAtLocation:(CLLocationCoordinate2D)location element:(LookupModel * _Nonnull)element;

@end

