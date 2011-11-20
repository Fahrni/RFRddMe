//
//  RFRddMe.m
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
#import "RFRddMe.h"
#import "ASIHTTPRequest.h"
#import "JSONKit.h"
#import "RFRddMeConstants.h"

static NSString* kRddMeUrlBase  = @"https://readability.com/api/shortener/v1/";
static NSString* kRddMeShorten  = @"urls";       // urls?http://someurl.com
static NSString* kRddMeExpand   = @"urls/%@";    // urls/{url_id}
static NSString* kRddMePOST     = @"POST";

@interface RFRddMe (Private)
- (NSDictionary*)_parseResponseString:(NSString*)responseString;
- (BOOL)_isSuccessResponse:(NSDictionary*)response;
@end

@implementation RFRddMe

- (id)initWithDelegate:(id)delegate;
{
    if ((self = [super init])) 
    {
        _delegate = [delegate retain];
    }
    
    return self;
}

- (void)dealloc;
{
    [_delegate release];
    [super dealloc];
}

- (void)shortenUrl:(NSString*)longUrl;
{
    NSString*   shortenUrl  = [NSString stringWithFormat:@"%@%@", kRddMeUrlBase, kRddMeShorten];
    NSURL*      url         = [NSURL URLWithString:shortenUrl];

    __block ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
    request.requestMethod = kRddMePOST;

    NSString* postDataString = [NSString stringWithFormat:@"url=%@", longUrl];
    [request appendPostData:[postDataString dataUsingEncoding:NSUTF8StringEncoding]];

    // Completion Block for a successful call.
    [request setCompletionBlock:
     ^{
         //NSLog(@"shortenUrl ==> %@\n", [request responseString]);
         NSDictionary* response = [self _parseResponseString:[request responseString]];
         if (response &&
             [self _isSuccessResponse:response])
         {
             RFRddMeShortUrl* shortUrl = [[RFRddMeShortUrl alloc] initWithDictionary:response forUrl:longUrl];
             if (shortUrl && 
                 [_delegate conformsToProtocol:@protocol(RFRddMeProtocol)]) 
             {
                 [_delegate performSelector:@selector(shortenSucceeded:) withObject:shortUrl];
             }
             [shortUrl release];
         }
         else
         {
             RFRddMeError* error = [[RFRddMeError alloc] initWithDictionary:response];
             if ([_delegate conformsToProtocol:@protocol(RFRddMeProtocol)]) [_delegate requestFailed:error];
             [error release];
         }
     }];
    
    // Completion Block for a failed call.
    [request setFailedBlock:
     ^{
         RFRddMeError* error = [[RFRddMeError alloc] initWithError:[request error]];
         if ([_delegate conformsToProtocol:@protocol(RFRddMeProtocol)]) [_delegate requestFailed:error];
         [error release];
     }];
    
    [request startAsynchronous];

}

- (void)expandUrl:(NSString*)shortUrl;
{
    NSString*   expandArg   = [NSString stringWithFormat:kRddMeExpand, shortUrl];
    NSString*   expandUrl   = [NSString stringWithFormat:@"%@%@", kRddMeUrlBase, expandArg];
    NSURL*      url         = [NSURL URLWithString:expandUrl];
    
    __block ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
    
    // Completion Block for a successful call.
    [request setCompletionBlock:
     ^{
         //NSLog(@"expandUrl ==> %@\n", [request responseString]);
         NSDictionary* response = [self _parseResponseString:[request responseString]];
         if (response &&
             [self _isSuccessResponse:response])
         {
             RFRddMeExpandedUrl* expandedUrl = [[RFRddMeExpandedUrl alloc] initWithDictionary:response];
             if (expandedUrl && 
                 [_delegate conformsToProtocol:@protocol(RFRddMeProtocol)]) 
             {
                 [_delegate performSelector:@selector(expandSucceeded:) withObject:expandedUrl];
             }
             [expandedUrl release];
         }
         else
         {
             RFRddMeError* error = [[RFRddMeError alloc] initWithDictionary:response];
             if ([_delegate conformsToProtocol:@protocol(RFRddMeProtocol)]) [_delegate requestFailed:error];
             [error release];
         }
     }];
    
    // Completion Block for a failed call.
    [request setFailedBlock:
     ^{
         RFRddMeError* error = [[RFRddMeError alloc] initWithError:[request error]];
         if ([_delegate conformsToProtocol:@protocol(RFRddMeProtocol)]) [_delegate requestFailed:error];
         [error release];
     }];
    
    [request startAsynchronous];
}

- (NSDictionary*)_parseResponseString:(NSString*)responseString;
{
    // The return result
    NSMutableDictionary* dict = [[[NSMutableDictionary alloc] init] autorelease];
    
    // Beginning set of items to add.
    NSDictionary* response = [responseString objectFromJSONString];
    [dict addEntriesFromDictionary:response];
    
    // We have a second set of items to add.
    NSDictionary* subItems = [response valueForKey:kRFRddMeMetaTag];
    if (subItems)
    {
        [dict addEntriesFromDictionary:subItems];
            
        NSDictionary* subSubItems = [subItems valueForKey:kRFRddMeArticleTag];
        if (subSubItems)
        {
            [dict addEntriesFromDictionary:subSubItems];
        }
    }
    
    return dict;
}

- (BOOL)_isSuccessResponse:(NSDictionary*)response;
{
    BOOL isError = NO;
    if (response)
    {
        isError = (BOOL)[response valueForKey:kRFRddMeSuccessTag];
    }
    return isError;
}

@end
