//
//  RFRddMeTests.m
//  RFRddMeTests
//
//  Created by Rob Fahrni on 11/19/11.
//  Copyright (c) 2011 Robert R. Fahrni. All rights reserved.
//
//	Redistribution and use in source and binary forms, with or without modification,
//	are permitted provided that the following conditions are met:
//
//	1.	Redistributions of source code must retain the above copyright notice,
//		this list of conditions and the following disclaimer.
//	2.	Redistributions in binary form must reproduce the above copyright notice,
//		this list of conditions and the following disclaimer in the documentation and/or
//		other materials provided with the distribution.
//	3.	Neither the name of the author nor the names of its contributors may be
//		used to endorse or promote products derived from this software without specific
//		prior written permission.
//
//	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS
//	OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
//	AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
//	CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
//	DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
//	DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
//	IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT
//	OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
#import "RFRddMeTests.h"
#import "RFRddMeProtocolImpl.h"
#import "RFRddMe.h"
#import "RFRddMeShortUrl.h"
#import "RFRddMeExpandedUrl.h"

@implementation RFRddMeTests

- (void)setUp;
{
    [super setUp];
}

- (void)tearDown;
{
    [super tearDown];
}

- (void)testShorten;
{
    RFRddMe* p = [[RFRddMe alloc] initWithDelegate:self];
    [p shortenUrl:@"http://iam.fahrni.ws/2011/11/15/for-posterity/"];

    STAssertTrue([self hackyRunLoopWait], @"testShorten");
    [p release];
}

- (void)testShortenNegative;
{
    RFRddMe* p = [[RFRddMe alloc] initWithDelegate:self];
    [p shortenUrl:@""];

    STAssertFalse([self hackyRunLoopWait], @"testShortenNegative");
    [p release];
}

- (void)testExpand;
{
    // test url http://rdd.me/0jfk8m0b
    RFRddMe* p = [[RFRddMe alloc] initWithDelegate:self];
    [p expandUrl:@"0jfk8m0b"];

    STAssertTrue([self hackyRunLoopWait], @"testExpand");
    [p release];
}

- (void)testExpandNegative;
{
    // test url http://rdd.me/0jfk8m0b
    RFRddMe* p = [[RFRddMe alloc] initWithDelegate:self];
    [p expandUrl:@""];

    STAssertFalse([self hackyRunLoopWait], @"testExpandFalse");
    [p release];
}


// RFRddMeProtocol Implementation
- (void)shortenSucceeded:(RFRddMeShortUrl*)shortUrl;
{
//    NSLog(@"===> shortenSucceeded");

//    NSLog(@"Short URL: %@\n", shortUrl.url);
//    NSLog(@"Rdd.me shorten URL: %@\n", shortUrl.shortenUrl);
//    NSLog(@"Source URL: %@\n", shortUrl.sourceUrl);

    _succeeded  = YES;
    _done       = YES;
}

- (void)expandSucceeded:(RFRddMeExpandedUrl*)expandedUrl;
{
//    NSLog(@"===> expandSucceeded");

//    NSLog(@"Expanded URL: %@\n", expandedUrl.expandedUrl);
//    NSLog(@"Author: %@\n", expandedUrl.author);
//    NSLog(@"Excerpt: %@\n", expandedUrl.excerpt);
//    NSLog(@"Word Count: %ld\n", expandedUrl.wordCount);
//    NSLog(@"Title: %@\n", expandedUrl.title);
//    NSLog(@"Shorten URL: %@\n", expandedUrl.shortenUrl);
//    NSLog(@"Rdd.Me URL Id: %@\n", expandedUrl.rddUrlId);
//    NSLog(@"Full URL: %@\n", expandedUrl.rddFullUrl);

    _succeeded  = YES;
    _done       = YES;
}

- (void)requestFailed:(RFRddMeError*)error;
{
//    NSLog(@"===> requestFailed");
//    NSLog(@"Message: %@\n", error.errorMessage);
//    NSLog(@"Error Code: %ld\n", error.errorCode);

    _succeeded  = NO;
    _done       = YES;
}

// Introduced methods.
- (BOOL)hackyRunLoopWait;
{
    // Reset our _done flag.
    _done = NO;

    // Reset the _succeeded flag to NO.
    _succeeded = NO;

    // Get the current run loop.
    NSRunLoop* runLoop = [NSRunLoop currentRunLoop];

    // Spin until the _done is YES or we've waited for 90 seconds.
    // Yep, it's a complete hack, just to get this working.
    while ((NO == _done) && [runLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:90]]);

    // Need to deal with exiting the loop above because we timed out.
    return _succeeded;
}

@end
