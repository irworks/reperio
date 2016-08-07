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
    
    [searchField addTarget:self
                    action:@selector(textFieldFinished:)
        forControlEvents:UIControlEventEditingDidEndOnExit];
    
    [mapView setDelegate:self];
    
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake(53, 10);
    
    ResultElement *resultElement = [[ResultElement alloc] init];
    [resultElement setHostname:@"test.com"];
    [resultElement setIpAddress:@"1.2.3.4"];
    
    [self addMarkerToMapAtLocation:location title:@"Title" subtitle:@"subtitle" element:resultElement];
    [self moveMapToLocation:location];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)searchBtnClicked:(id)sender {
    HTTPRequest *request = [[HTTPRequest alloc] initWithURL:REST_BASE_URL withMethod:@"POST" withParameters:@{@"query" : [searchField text]}];
    [request startRequest];
}

- (void)moveMapToLocation:(CLLocationCoordinate2D)location {
    @try {
        [mapView setRegion:MKCoordinateRegionMake(location, MKCoordinateSpanMake(0.2, 0.2)) animated:YES];
    } @catch (NSException *exception) {
        NSLog(@"Invalid region: lat: %f; long: %f", location.latitude, location.longitude);
    }
}

- (void)addMarkerToMapAtLocation:(CLLocationCoordinate2D)location title:(NSString *)title subtitle:(NSString *)subtitle element:(ResultElement *)element {
    EMKPointAnnotation *point = [[EMKPointAnnotation alloc] init];
    
    [point setResultElement:element];
    [point setCoordinate:location];
    [point setTitle:title];
    [point setSubtitle:subtitle];
    
    [mapView addAnnotation:point];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapViewL viewForAnnotation:(id<MKAnnotation>)annotation {
    MKAnnotationView *pinView = [mapViewL dequeueReusableAnnotationViewWithIdentifier:@"pin"];
    
    if(!pinView) {
        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"pin"];
        [pinView setCanShowCallout:YES];
        [pinView setRightCalloutAccessoryView:[UIButton buttonWithType:UIButtonTypeInfoDark]];
        
        EMKPointAnnotation *extendedAnnotation = nil;
        
        if([pinView.annotation isKindOfClass:[EMKPointAnnotation class]]) {
            extendedAnnotation = (EMKPointAnnotation *)pinView.annotation;
            [extendedAnnotation setTitle:[[extendedAnnotation resultElement] hostname]];
        }
        
        [pinView setDetailCalloutAccessoryView:[[MoreInfoView alloc] initWithResultElement:[extendedAnnotation resultElement]]];
    }
    
    return pinView;
}

- (IBAction)textFieldFinished:(id)sender {
    [sender resignFirstResponder];
}

@end
