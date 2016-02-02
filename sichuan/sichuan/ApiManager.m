//
//  ApiManager.m
//  sichuan
//
//  Created by Lu.L on 16/1/27.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import "ApiManager.h"

static NSTimeInterval RequestTimeoutInterval = 30.0f;
NSString * const kBaseUrl = @"http://125.64.4.216:18080/appService/";

static ApiManager *apiManager = nil;

@implementation ApiManager

+ (ApiManager *)sharedInstance {
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        apiManager = [[ApiManager alloc] init];
    });
    
    return apiManager;
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        [self initSessionManager];
    }
    return self;
}

- (void)initSessionManager {
    
    NSURL *baseUrl = [NSURL URLWithString:kBaseUrl];
    self.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseUrl];
    
    // X-PFA-IDENTIFIER
    // X-PFA-TOKEN
    
    // header
    //    self.sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    // security Policy
    self.sessionManager.securityPolicy = [AFSecurityPolicy defaultPolicy];
    
    // cache policy.
    self.sessionManager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    
    // set request timeout
    self.sessionManager.requestSerializer.timeoutInterval = RequestTimeoutInterval;
}

- (NSURLSessionDataTask *)post:(NSString *)path
                    parameters:(id)parameters
                 completeBlock:(SCSessionTaskDidCompleteBlock)completeBlock {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSString *string = [NSString stringWithFormat:@"%@%@",kBaseUrl, path];
    
    NSURLSessionDataTask *task = [self.sessionManager POST:string parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            completeBlock(task, responseObject, nil);
        }
        
        if ([responseObject isKindOfClass:[NSArray class]]) {
            completeBlock(task, responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSDictionary *info = error.userInfo;
        NSLog(@"error: %@, path: %@", info, path);
    }];

    return task;
}

- (NSURLSessionDataTask *)get:(NSString *)path
                   parameters:(id)parameters
                completeBlock:(SCSessionTaskDidCompleteBlock)completeBlock {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSURLSessionDataTask *task = [self.sessionManager GET:path parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            completeBlock(task, responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSDictionary *info = error.userInfo;
        NSLog(@"error: %@, path: %@", info, path);
    }];
    
    return task;
}


@end
