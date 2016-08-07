//
//  ViewController.m
//  utrace
//
//  Created by Ilja Rozhko on 07.08.16.
//  Copyright © 2016 IR Works. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [mapView setDelegate:self];
    
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake(100, 100);
    [self addMarkerToMapAtLocation:location title:@"Test" subtitle:@"subtitle"];
    [self moveMapToLocation:location];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)searchBtnClicked:(id)sender {
}

- (void)moveMapToLocation:(CLLocationCoordinate2D)location {
    [mapView setRegion:MKCoordinateRegionMake(location, MKCoordinateSpanMake(0.2, 0.2)) animated:YES];
}

- (void)addMarkerToMapAtLocation:(CLLocationCoordinate2D)location title:(NSString *)title subtitle:(NSString *)subtitle {
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate         = location;
    point.title              = title;
    point.subtitle           = title;
    
    [mapView addAnnotation:point];
}

@end
