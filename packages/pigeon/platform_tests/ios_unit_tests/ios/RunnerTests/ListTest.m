// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import <Flutter/Flutter.h>
#import <XCTest/XCTest.h>
#import "EchoMessenger.h"
#import "list.gen.h"

///////////////////////////////////////////////////////////////////////////////////////////
@interface ListTest : XCTestCase
@end

///////////////////////////////////////////////////////////////////////////////////////////
@implementation ListTest

- (void)testListInList {
  LSTTestMessage* top = [[LSTTestMessage alloc] init];
  LSTTestMessage* inside = [[LSTTestMessage alloc] init];
  inside.testList = @[ @1, @2, @3 ];
  top.testList = @[ inside ];
  EchoBinaryMessenger* binaryMessenger =
      [[EchoBinaryMessenger alloc] initWithCodec:LSTEchoApiGetCodec()];
  LSTEchoApi* api = [[LSTEchoApi alloc] initWithBinaryMessenger:binaryMessenger];
  XCTestExpectation* expectation = [self expectationWithDescription:@"callback"];
  [api echoMsg:top
      completion:^(LSTTestMessage* _Nonnull result, NSError* _Nullable err) {
        XCTAssertEqual(1u, result.testList.count);
        XCTAssertTrue([result.testList[0] isKindOfClass:[LSTTestMessage class]]);
        XCTAssertEqualObjects(inside.testList, [result.testList[0] testList]);
        [expectation fulfill];
      }];
  [self waitForExpectations:@[ expectation ] timeout:1.0];
}

@end
