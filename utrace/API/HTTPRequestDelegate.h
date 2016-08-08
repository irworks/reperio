//
//  HTTPRequestDelegate.h
//  API-Test
//
//  Created by Ilja Rozhko on 13.05.16.
//  Copyright © 2016 IR Works. All rights reserved.
//

@class HTTPRequest;

@protocol HTTPRequestDelegate <NSObject>

- (void)onRequestPrepared;
- (void)onRequestStarted;
- (void)onRequestPaused;
- (void)onRequestResumed;
- (void)onRequestCanceled;

@required
- (void)onRequestSuccess:(NSString *)responseSting withJSON:(NSDictionary *)responseJSON;
- (void)onRequestFail:(NSError *)error;

@end