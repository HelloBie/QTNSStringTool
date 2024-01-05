//
//  QTNSStringToolTests.m
//  QTNSStringToolTests
//
//  Created by MasterBie on 2023/9/15.
//

#import <XCTest/XCTest.h>
#import "NSString+QTNSStringTool.h"


@interface QTNSStringToolTests : XCTestCase

@end

@implementation QTNSStringToolTests

- (void)setUp {
    
  BOOL b1 =  [@"12" isNumberStringWithAllowPoint:NO];
    BOOL b2 =  [@"12.34" isNumberStringWithAllowPoint:YES];
    BOOL b22 =  [@"12.34" isNumberStringWithAllowPoint:NO];
    BOOL b3 =  [@"12" iSNumberStringWithLength:2];
      BOOL b4 =  [@"12" iSNumberStringWithLength:3];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
