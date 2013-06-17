//
//  RFRddMeConstants.m
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
#import "RFRddMeConstants.h"

NSString* const kRFRddMeUrlTag          = @"url";       // "url": "/api/shortener/v1/urls/8tkig0pb" (shorten)
NSString* const kRFRddMeShortenUrlTag   = @"url";       // "url": "http://iam.fahrni.ws/"           (expand)
NSString* const kRFRddMeRddUrlTag       = @"rdd_url";   // "rdd_url": "http://rdd.me/8tkig0pb"      (shorten/expand)
NSString* const kRFRddMeIdTag           = @"id";        // "id": "8tkig0pb"                         (shorten/expand)
NSString* const kRFRddMeAuthorTag       = @"author";    // "author": null                           (expand)
NSString* const kRFRddMeExcerptTag      = @"excerpt";   // "excerpt": "A long time ago..."          (expand)
NSString* const kRFRddMeWordCountTag    = @"word_count";// "word_count": 570                        (expand)
NSString* const kRFRddMeTitleTag        = @"title";     // "title": "This is my website"            (expand)
NSString* const kRFRddMeFullUrlTag      = @"full_url";  // "full_url": "http://readability.com/articles/0jfk8m0b" (expand)
NSString* const kRFRddMeSuccessTag      = @"success";   // "success": true/false                    (shorten/expand)
NSString* const kRFRddMeTrue            = @"true";
NSString* const kRFRddMeFalse           = @"false";
NSString* const kRFRddMeMetaTag         = @"meta";
NSString* const kRFRddMeArticleTag      = @"article";
NSString* const kRFRddMeErrorMessageTag = @"message";
NSString* const kRFRddMeErrorCodeTag    = @"errorCode";