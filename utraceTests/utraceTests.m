//
//  utraceTests.m
//  utraceTests
//
//  Created by Ilja Rozhko on 07.08.16.
//  Copyright © 2016 IR Works. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"

@interface utraceTests : XCTestCase {
    ViewController *viewController;
}

@end

@implementation utraceTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    viewController = [[ViewController alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testMapPostition {
    [viewController moveMapToLocation:CLLocationCoordinate2DMake(53, 10)];
    [viewController moveMapToLocation:CLLocationCoordinate2DMake(1337, 42)];
}

- (void)testMapAnnotation {
    [viewController addMarkerToMapAtLocation:CLLocationCoordinate2DMake(53, 10) title:@"Test" subtitle:@"subtitle"];
}

@end
