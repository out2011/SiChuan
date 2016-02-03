//
//  ApiManager+Profile.m
//  sichuan
//
//  Created by Lu.L on 16/1/29.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import "ApiManager+Profile.h"

@implementation ApiManager (Profile)

- (NSURLSessionDataTask *)requestSituationWithCompleteBlock:(SCSituationDidCompleteBlock)completeBlock {
    
    NSDictionary *parameters;
    
    NSURLSessionDataTask *task = [self post:API_Situation
                                 parameters:parameters
                              completeBlock:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
                                  
                                  if (!error) {

                                      completeBlock(responseObject, nil);
                                  }
                              } ];
    
    return task;
}

- (NSURLSessionDataTask *)requestPositionWithPname:(NSString *)pname
                                     completeBlock:(SCPositionDidCompleteBlock)completeBlock {
    
    NSDictionary *parameters = @{@"pname": pname};
    
    NSURLSessionDataTask *task = [self post:API_Position
                                 parameters:parameters
                              completeBlock:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
                                  
                                  if (!error) {
                                      
                                      completeBlock(responseObject, nil);
                                  }
                              } ];
    
    return task;
}

- (NSURLSessionDataTask *)requestNewsWithPages:(NSNumber *)pages
                                          size:(NSNumber *)size
                                 completeBlock:(SCNewsDidCompleteBlock)completeBlock {
    
    NSDictionary *parameters = @{@"pno": pages, @"psize": size};
    
    NSURLSessionDataTask *task = [self post:API_News
                                 parameters:parameters
                              completeBlock:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
                                  
                                  completeBlock(responseObject, nil);
                              }];
    
    return task;
}

- (NSURLSessionDataTask *)requestSatNoticeWithPages:(NSNumber *)pages
                                               size:(NSNumber *)size
                                      completeBlock:(SCStaNoticeDidCompleteBlock)completeBlock {
    
    NSDictionary *parameters = @{@"pno": pages, @"psize": size};
    
    NSURLSessionDataTask *task = [self post:API_StaNotice
                                 parameters:parameters
                              completeBlock:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
                                  
                                  completeBlock(responseObject, nil);
                              }];
    
    return task;
    
}
@end
