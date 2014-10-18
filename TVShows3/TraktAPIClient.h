//
//  TraktAPIClient.h
//  TVShows3
//
//  Created by ME-Tech Mac User 1 on 10/18/14.
//  Copyright (c) 2014 ME-Tech. All rights reserved.
//

#import "AFHTTPSessionManager.h"

extern NSString *const kTraktAPIkey;
extern NSString *const kTraktBaseURLString;

@interface TraktAPIClient : AFHTTPSessionManager

//class method
+(TraktAPIClient*)sharedClient;

//instance method
-(void)getShowsForUsername:(NSString*)username date:(NSDate*)date Days:(int)days success:( void(^)(NSURLSessionDataTask*, id)) success failure:( void(^)(NSURLSessionDataTask *, NSError*)) failed;

@end