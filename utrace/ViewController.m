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

- (IBAction)textFieldFinished:(id)sender {
    [super textFieldFinished:sender];
    [self searchBtnClicked:searchBtn];
}

- (IBAction)searchBtnClicked:(id)sender {
    for(MKPointAnnotation *annotation in [mapView annotations]) {
        [mapView deselectAnnotation:annotation animated:YES];
    }
    
    [searchField resignFirstResponder];
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
}

- (MKAnnotationView *)mapView:(MKMapView *)mapViewL viewForAnnotation:(id<MKAnnotation>)annotation {
    MKAnnotationView *pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:PIN_IDENTIFIER];
    
    [pinView setCanShowCallout:YES];
    [pinView setRightCalloutAccessoryView:[UIButton buttonWithType:UIButtonTypeInfoDark]];
    
    EMKPointAnnotation *extendedAnnotation = nil;
    
    if([pinView.annotation isKindOfClass:[EMKPointAnnotation class]]) {
        extendedAnnotation = (EMKPointAnnotation *)pinView.annotation;
        [extendedAnnotation setTitle:[[extendedAnnotation lookupModel] hostname]];
    }
    
    [pinView setDetailCalloutAccessoryView:[[MoreInfoView alloc] initWithLookupModel:[extendedAnnotation lookupModel]]];
    
    return pinView;
}

- (void)mapView:(MKMapView *)mapViewL annotationView:(MKAnnotationView *)pinView calloutAccessoryControlTapped:(UIControl *)control {
    if([pinView.annotation isKindOfClass:[EMKPointAnnotation class]]) {
        EMKPointAnnotation *extendedAnnotation = (EMKPointAnnotation *)pinView.annotation;
        
        [self showAlertMessageWithTitle:[pinView.annotation title] message:NSLocalizedString(@"SELECT_OPTION_TO_COPY", nil)
                             completion:nil
                                actions:[NSArray arrayWithObjects:
                                         
                                         [UIAlertAction actionWithTitle:NSLocalizedString(@"HOSTNAME", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                                [[UIPasteboard generalPasteboard] setString:[[extendedAnnotation lookupModel] hostname]];
                                             }
                                           ],
                                         
                                         [UIAlertAction actionWithTitle:NSLocalizedString(@"IP_ADDRESS", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                                [[UIPasteboard generalPasteboard] setString:[[extendedAnnotation lookupModel] ip]];
                                             }
                                           ],
                                         
                                         [UIAlertAction actionWithTitle:NSLocalizedString(@"LOCATION", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                                [[UIPasteboard generalPasteboard] setString:[[extendedAnnotation lookupModel] getLocationString]];
                                             }
                                           ],
                                         
                                         [UIAlertAction actionWithTitle:NSLocalizedString(@"ORGANIZATION", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                                [[UIPasteboard generalPasteboard] setString:[[extendedAnnotation lookupModel] org]];
                                             }
                                           ],
                                         
                                         [UIAlertAction actionWithTitle:NSLocalizedString(@"CANCEL", nil) style:UIAlertActionStyleCancel handler:nil],
                                         
                                         nil]
         ];
    }
}

- (void)mapView:(MKMapView *)mapViewL didAddAnnotationViews:(NSArray<MKAnnotationView *> *)views {
    [mapViewL selectAnnotation:[[views lastObject] annotation] animated:YES];
}

- (void)onRequestSuccess:(NSString *)responseSting withJSON:(NSDictionary *)responseJSON {
    [super onRequestSuccess:responseSting withJSON:responseJSON];
    
    LookupModel *lookupModel = [[LookupModel alloc] initWithString:responseSting error:nil];
    
    [self moveMapToLocation:[lookupModel loc]];
    [self addMarkerToMapAtLocation:[lookupModel loc] element:lookupModel];
}

- (void)onRequestFail:(NSError *)error {
    [super onRequestFail:error];
    
    [self showAlertMessageWithTitle:APP_NAME message:[error localizedDescription]];
}

@end
