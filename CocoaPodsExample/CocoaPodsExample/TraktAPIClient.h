//
//  TraktAPIClient.h
//  CocoaPodsExample
//
//  Created by Dong Yiming on 7/16/13.
//  Copyright (c) 2013 Dong Yiming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFHTTPClient.h>

extern NSString * const kTraktAPIKey;
extern NSString * const kTraktBaseURLString;

@interface TraktAPIClient : AFHTTPClient

+(TraktAPIClient *)sharedClient;

@end
