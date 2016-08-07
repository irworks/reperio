//
//  ViewController.h
//  utrace
//
//  Created by Ilja Rozhko on 07.08.16.
//  Copyright © 2016 IR Works. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController<MKMapViewDelegate> {
    __weak IBOutlet UITextField *searchField;
    __weak IBOutlet MKMapView *mapView;
}

- (IBAction)searchBtnClicked:(id)sender;
- (void)moveMapToLocation:(CLLocationCoordinate2D)location;

@end

