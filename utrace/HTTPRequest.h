//
//  HTTPRequest.h
//  API-Test
//
//  Created by Ilja Rozhko on 13.05.16.
//  Copyright © 2016 IR Works. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTTPRequestDelegate.h"

@interface HTTPRequest : NSObject <NSURLSessionDelegate, NSURLSessionDataDelegate> {
    
    id <HTTPRequestDelegate> delegate;
    
    NSMutableURLRequest *request;
    NSURLSessionDataTask *dataSession;
    
    #define REQUEST_DEFAULT_TIMEOUT 60.0
    
    #define REQUEST_NORMAL_SPERATOR @"&"
    #define REQUEST_VALUE_SPERATOR @"="
}

//init methods
- (id)initWithURL:(NSString *)urlString withMethod:(NSString *)method withParameters:(NSDictionary *)parameters;
- (id)initWithURL:(NSString *)urlString withMethod:(NSString *)method withParameters:(NSDictionary *)parameters withHeaders:(NSDictionary *)headers;
- (id)initWithURL:(NSString *)urlString withCachePolicy:(NSURLRequestCachePolicy)cachePolicy withTimeout:(NSTimeInterval)timeout withMethod:(NSString *)method withParameters:(NSDictionary *)parameters withHeaders:(NSDictionary *)headers;

//start request
- (void)startRequest;
- (void)pauseRequest;
- (void)resumeRequest;
- (void)cancelRequest;

//parameters
@property BOOL debug;
@property (nonatomic, retain) id <HTTPRequestDelegate> delegate;

@end
