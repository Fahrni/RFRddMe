//
//  RFRddMeError.m
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
#import "RFRddMeError.h"
#import "RFRddMeConstants.h"

@implementation RFRddMeError

@synthesize errorCode;
@synthesize errorMessage;

- (id)initWithDictionary:(NSDictionary*)dictionary;
{
    if ((self = [super init]))
    {
        self.errorCode      = [[dictionary valueForKey:kRFRddMeErrorCodeTag] integerValue];
        self.errorMessage   = [dictionary valueForKey:kRFRddMeErrorMessageTag];
    }

    return self;
}

- (id)initWithError:(NSError*)error;
{
    if ((self = [super init]))
    {
        errorCode               = [error code];
        NSString* description   = [error description];
        if (description)
        {
            errorMessage = [description copy];
        }
    }

    return self;
}

- (void)dealloc;
{
    [errorMessage release];
    [super dealloc];
}

@end
