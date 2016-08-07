//
//  ViewController.h
//  utrace
//
//  Created by Ilja Rozhko on 07.08.16.
//  Copyright © 2016 IR Works. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "ResultElement.h"
#import "EMKPointAnnotation.h"

#import "const.h"
#import "HTTPRequest.h"

@interface ViewController : UIViewController<MKMapViewDelegate> {
    __weak IBOutlet UITextField *searchField;
    __weak IBOutlet MKMapView *mapView;
}

- (IBAction)searchBtnClicked:(id _Nonnull)sender;
- (void)moveMapToLocation:(CLLocationCoordinate2D)location;
- (void)addMarkerToMapAtLocation:(CLLocationCoordinate2D)location title:(NSString * _Nonnull)title subtitle:(NSString * _Nonnull)subtitle element:(ResultElement * _Nullable)element;

@end

