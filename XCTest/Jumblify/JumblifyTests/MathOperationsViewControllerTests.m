//
//  MathOperationsViewControllerTests.m
//  Jumblify
//
//  Created by Fabio Suenaga on 16/12/16.
//  Copyright © 2016 Tuts+. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "MathOperationsViewController.h"

@interface MathOperationsViewControllerTests : XCTestCase

@property (nonatomic) MathOperationsViewController *vcToTest;

@end

@interface MathOperationsViewController (Test)

- (Boolean)isOddValue:(int)number1;
- (NSString *)castIntValue:(int)number;

@end

@implementation MathOperationsViewControllerTests

- (void)setUp {
    [super setUp];
    self.vcToTest = [[MathOperationsViewController alloc] init];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testIsOddValue:(int)number {
    number = 2;
    Boolean resultBooleanValue = [self.vcToTest isOddValue:number];
    XCTAssertTrue(resultBooleanValue, @"The return of mod value did not match the expected.");
}

- (void)testCastIntValue:(int)number {
    int numberCast = 1;
    NSString *expectedString = @"Número: 1";
    NSString *value  = [self.vcToTest castIntValue:numberCast];
    XCTAssertEqualObjects(expectedString, value, @"The return of mod value did not match the expected.");
}


@end
