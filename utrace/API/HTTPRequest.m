//
//  HTTPRequest.m
//  API-Test
//
//  Created by Ilja Rozhko on 13.05.16.
//  Copyright © 2016 IR Works. All rights reserved.
//

#import "HTTPRequest.h"

@implementation HTTPRequest
@synthesize delegate;

- (id)initWithURL:(NSString *)urlString withMethod:(NSString *)method withParameters:(NSDictionary *)parameters {
    return [self initWithURL:urlString withCachePolicy:NSURLRequestReloadIgnoringLocalCacheData withTimeout:REQUEST_DEFAULT_TIMEOUT withMethod:method withParameters:parameters withHeaders:nil];
}

- (id)initWithURL:(NSString *)urlString withMethod:(NSString *)method withParameters:(NSDictionary *)parameters withHeaders:(NSDictionary *)headers {
    return [self initWithURL:urlString withCachePolicy:NSURLRequestReloadIgnoringLocalCacheData withTimeout:REQUEST_DEFAULT_TIMEOUT withMethod:method withParameters:parameters withHeaders:headers];
}

- (id)initWithURL:(NSString *)urlString withCachePolicy:(NSURLRequestCachePolicy)cachePolicy withTimeout:(NSTimeInterval)timeout withMethod:(NSString *)method withParameters:(NSDictionary *)parameters withHeaders:(NSDictionary *)headers {
    self = [super init];
    
    //init the request
    request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString] cachePolicy:cachePolicy timeoutInterval:timeout];
    
    //check if parameter
    if(parameters == nil) {
        parameters = [[NSDictionary alloc] init];
    }
    
    //default header value
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    //check if headers
    if(headers == nil) {
        headers = [[NSDictionary alloc] init];
    }
    
    //set header
    for(NSString *headerKey in headers) {
        [request setValue:[headers valueForKey:headerKey] forHTTPHeaderField:headerKey];
    }
    
    //set method, header and parameter
    [request setHTTPMethod:method];
    [request setHTTPBody:[[self buildParameterStringFromDictionary:parameters] dataUsingEncoding:NSUTF8StringEncoding]];
    
    //prepare NSMutableData
    requestData = [[NSMutableData alloc] init];
    
    [delegate onRequestPrepared];
    
    return self;
}

/* start, pause, cancel methods */

- (void)startRequest {
    //start the connection
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    dataSession = [session dataTaskWithRequest:request];
    [dataSession resume];
    [delegate onRequestStarted];
}

- (void)pauseRequest {
    [dataSession suspend];
    [delegate onRequestPaused];
}

- (void)resumeRequest {
    [dataSession resume];
    [delegate onRequestResumed];
}

- (void)cancelRequest {
    [dataSession cancel];
    [delegate onRequestCanceled];
}


/* DELEGATE METHODS */

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    
    if(error != nil) {
        if(_debug) {
            NSLog(@"Request #%lu failed: (%@)", (unsigned long)[task taskIdentifier], [error localizedDescription]);
        }
        
        [delegate onRequestFail:error];
    }else{
        NSError *error;
        
        NSString *responseString   = [[NSString alloc] initWithData:requestData encoding:NSUTF8StringEncoding];
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:requestData options:NSJSONReadingAllowFragments error:&error];
        
        if(error) {
            [delegate onRequestFail:error];
        }else{
            [delegate onRequestSuccess:responseString withJSON:responseDict];
        }
    }
    
    if(_debug) {
        NSLog(@"HEADER: %@", [task response]);
        NSLog(@"BODY: %@", [[NSString alloc] initWithData:requestData encoding:NSUTF8StringEncoding]);
    }
    
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    [requestData appendData:data];
}

/* Util method to build request string */
- (NSString *)buildParameterStringFromDictionary:(NSDictionary *)dict {
    NSString *parameterString = @"";
    
    for(NSString *key in dict) {
        parameterString = [NSString stringWithFormat:@"%@%@%@%@%@", parameterString, REQUEST_NORMAL_SPERATOR, key, REQUEST_VALUE_SPERATOR, [dict valueForKey:key]];
    }
    
    return parameterString;
}

@end
