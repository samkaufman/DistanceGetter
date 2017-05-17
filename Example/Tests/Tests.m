//
//  DistanceGetterTests.m
//  DistanceGetterTests
//
//  Created by Sam Kaufman on 09/11/2015.
//  Copyright (c) 2015 Sam Kaufman. All rights reserved.
//

@import XCTest;
#import <DistanceGetter/DGDistanceRequest.h>


@interface Tests : XCTestCase

@end


@implementation Tests

- (void)testGetsEmptyResultsGivenNoLocations
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"DGDistanceRequest calls back"];
    __block NSArray *returnedDistances;
    
    // Kick off request
    NSString *src = @"San Francisco, CA";
    NSArray *locs = @[];
    DGDistanceRequest *req = [[DGDistanceRequest alloc] initWithLocationDescriptions:locs sourceDescription:src];
    req.callback = ^(NSArray *distances) {
        returnedDistances = distances;
        [expectation fulfill];
    };
    [req start];
    
    // Wait for return and do assertions
    [self waitForExpectationsWithTimeout:60.0 handler:^(NSError *error) {
        XCTAssertNil(error);
        XCTAssertEqual([returnedDistances count], 0);
    }];
}

- (void)testGetsSaneReturnsFromSanFrancisco
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"DGDistanceRequest calls back"];
    __block NSArray *returnedDistances;
    
    // Kick off request
    NSString *src = @"San Francisco, CA";
    NSArray *locs = @[@"Tucson, AZ", @"London"];
    DGDistanceRequest *req = [[DGDistanceRequest alloc] initWithLocationDescriptions:locs sourceDescription:src];
    req.callback = ^(NSArray *distances) {
        returnedDistances = distances;
        [expectation fulfill];
    };
    [req start];
    
    // Wait for return and do assertions
    [self waitForExpectationsWithTimeout:60.0 handler:^(NSError *error) {
        XCTAssertNil(error);
        XCTAssertEqual([returnedDistances count], 2);
        XCTAssertNotEqual(returnedDistances[0], @(-1));
        XCTAssertNotEqual(returnedDistances[1], @(-1));
        XCTAssertNotEqual(returnedDistances[0], [NSNull null]);
        XCTAssertNotEqual(returnedDistances[1], [NSNull null]);
        XCTAssertEqualWithAccuracy([returnedDistances[0] doubleValue], 1224000.0, 50000.0);
        XCTAssertEqualWithAccuracy([returnedDistances[1] doubleValue], 8629000.0, 10000.0);
    }];
}

@end

