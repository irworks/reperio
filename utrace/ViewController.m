//
//  ViewController.m
//  utrace
//
//  Created by Ilja Rozhko on 07.08.16.
//  Copyright © 2016 IR Works. All rights reserved.
//

#import "ViewController.h"
#import "MoreInfoView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self addListenerToTextfield:searchField];
    
    [mapView setDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)searchBtnClicked:(id)sender {
    HTTPRequest *request = [[HTTPRequest alloc] initWithURL:REST_BASE_URL withMethod:@"POST" withParameters:@{@"query" : [searchField text]}];
    [request setDelegate:self];
    [request setDebug:YES];
    [request startRequest];
}

- (void)moveMapToLocation:(CLLocationCoordinate2D)location {
    @try {
        [mapView setRegion:MKCoordinateRegionMake(CLLocationCoordinate2DMake(location.latitude + MAP_OFFSET_ON_PIN, location.longitude), MKCoordinateSpanMake(0.2, 0.2)) animated:YES];
    } @catch (NSException *exception) {
        NSLog(@"Invalid region: lat: %f; long: %f", location.latitude, location.longitude);
    }
}

- (void)addMarkerToMapAtLocation:(CLLocationCoordinate2D)location element:(LookupModel *)element {
    EMKPointAnnotation *point = [[EMKPointAnnotation alloc] init];
    
    [point setLookupModel:element];
    [point setCoordinate:location];
    [point setTitle:[element hostname]];
    
    [mapView addAnnotation:point];
    [mapView selectAnnotation:point animated:YES];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapViewL viewForAnnotation:(id<MKAnnotation>)annotation {
    MKAnnotationView *pinView = [mapViewL dequeueReusableAnnotationViewWithIdentifier:PIN_IDENTIFIER];
    
    if(!pinView) {
        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:PIN_IDENTIFIER];
        [pinView setCanShowCallout:YES];
        [pinView setRightCalloutAccessoryView:[UIButton buttonWithType:UIButtonTypeInfoDark]];
        
        EMKPointAnnotation *extendedAnnotation = nil;
        
        if([pinView.annotation isKindOfClass:[EMKPointAnnotation class]]) {
            extendedAnnotation = (EMKPointAnnotation *)pinView.annotation;
            [extendedAnnotation setTitle:[[extendedAnnotation lookupModel] hostname]];
        }
        
        [pinView setDetailCalloutAccessoryView:[[MoreInfoView alloc] initWithLookupModel:[extendedAnnotation lookupModel]]];
    }
    
    return pinView;
}

- (void)onRequestSuccess:(NSString *)responseSting withJSON:(NSDictionary *)responseJSON {
    LookupModel *lookupModel = [[LookupModel alloc] initWithString:responseSting error:nil];
    
    [self addMarkerToMapAtLocation:[lookupModel loc] element:lookupModel];
    [self moveMapToLocation:[lookupModel loc]];
}

- (void)onRequestFail:(NSError *)error {
    [self showAlertMessageWithTitle:APP_NAME message:[error localizedDescription]];
}

@end
