//
//  RFRddMeExpandedUrl.h
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
#import <Foundation/Foundation.h>

@interface RFRddMeExpandedUrl :
    NSObject
{
    NSString*   expandedUrl;    // "url": "http://iam.fahrni.ws/",
    NSString*   author;         // "author": null,
    NSString*   excerpt;        // "excerpt": "Movie line of the week answer Good morning! Not many takers for this line, we had one, just one. Oh, but that one was dead on! Congratulations to Mr. Tommy Williams who correctly guessed&#8230;Real&hellip;",
    NSInteger   wordCount;      // "word_count": 570,
    NSString*   title;          // "title": "I AM FAHRNI"
    NSString*   shortUrl;       // "rdd_url": "http://rdd.me/0jfk8m0b",
    NSString*   rddUrlId;       // "id": "0jfk8m0b",
    NSString*   rddFullUrl;     // "full_url": "http://readability.com/articles/0jfk8m0b"

}

@property (copy) NSString*   expandedUrl;
@property (copy) NSString*   author;
@property (copy) NSString*   excerpt;
@property (assign) NSInteger wordCount;
@property (copy) NSString*   title;
@property (copy) NSString*   shortenUrl;
@property (copy) NSString*   rddUrlId;
@property (copy) NSString*   rddFullUrl;

- (id)initWithDictionary:(NSDictionary*)dictionary;
- (void)dealloc;

@end
