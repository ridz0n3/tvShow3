//
//  TraktAPIClient.m
//  TVShows3
//
//  Created by ME-Tech Mac User 1 on 10/18/14.
//  Copyright (c) 2014 ME-Tech. All rights reserved.
//

#import "TraktAPIClient.h"

NSString *const kTraktAPIkey = @"0703160741a6c9a6be8023e66c2a5b78";
NSString *const kTraktBaseURLString = @"http://api.trakt.tv";

@implementation TraktAPIClient
//+(TraktAPIClient*)sharedClient;

+ (TraktAPIClient*)sharedClient {
    static TraktAPIClient *_sharedMYClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedMYClient = [[self alloc] initWithBaseURL: [NSURL URLWithString:kTraktBaseURLString]];
    });
    return _sharedMYClient;
}

- (instancetype)initWithBaseUrl:(NSURL*) url {
    self = [super initWithBaseURL:url];
    if (!self) {
        //someProperty = [[NSString alloc] initWithString:@"Default Property Value"];
        return nil;
    }
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    self.responseSerializer = [AFImageResponseSerializer serializer];
    return self;
}

-(void)getShowsForUsername:(NSString*)username date:(NSDate*)date Days:(int)days success:( void(^)(NSURLSessionDataTask*, id)) success failure:( void(^)(NSURLSessionDataTask *, NSError*)) failed {
    //user/calendar/shows.format/apikey/date/days
    NSDateFormatter *formater = [[NSDateFormatter alloc]init];
    formater.dateFormat = @"yyyyMMdd";
    NSString *theDate = [formater stringFromDate:date];
    
    NSString *path = [NSString stringWithFormat:@"user/calendar/shows.json/%@/%@/%@/%i",kTraktAPIkey,username ,theDate,days];
    
    [self GET:path parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if(success){
            success(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if(failed){
            failed(task, error);
        }
    }];
    NSLog(path);
}
@end
