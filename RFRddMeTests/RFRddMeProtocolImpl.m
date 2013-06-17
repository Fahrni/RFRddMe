//
//  RFRddMeProtocolImpl.m
//  RFRddMe
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
#import "RFRddMeProtocolImpl.h"

@implementation RFRddMeProtocolImpl

- (id)init
{
    self = [super init];
    if (self)
    {
        _done       = NO;
        _succeeded  = NO;
    }

    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)shortenSucceeded:(RFRddMeShortUrl*)shortUrl;
{
    NSLog(@"shortenSucceeded received %@\n", shortUrl);

    _succeeded  = YES;
    _done       = YES;
}

- (void)expandSucceeded:(RFRddMeExpandedUrl*)expandedUrl;
{
    NSLog(@"expandSucceeded received %@\n", expandedUrl);

    _succeeded  = YES;
    _done       = YES;
}

- (void)requestFailed:(RFRddMeError*)error;
{
    NSLog(@"requestFailed received %@\n", error);

    _succeeded  = NO;
    _done       = YES;
}

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
