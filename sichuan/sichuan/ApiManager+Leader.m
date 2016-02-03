//
//  ApiManager+Leader.m
//  sichuan
//
//  Created by Lu.L on 16/1/29.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import "ApiManager+Leader.h"

@implementation ApiManager (Leader)

- (NSURLSessionDataTask *)requestLeaderWithCompleteBlock:(SCLeaderDidCompleteBlock)completeBlock {
    
    NSDictionary *parameters;
    
    NSURLSessionDataTask *task = [self post:API_Leader parameters:parameters completeBlock:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
        
        if (!error) {
            
            completeBlock(responseObject, nil);
            
        }
    } ];
    
    return task;
}

- (NSURLSessionDataTask *)requestActivityWithNId:(NSNumber *)nId
                                           Pages:(NSNumber *)pages
                                            size:(NSNumber *)size
                                   completeBlock:(SCActivityDidCompleteBlock)completeBlock {
    
    NSDictionary *parameters = @{@"nID": nId, @"pno": pages, @"psize": size};
    
    NSURLSessionDataTask *task = [self post:API_Activity parameters:parameters completeBlock:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
        
        if (!error) {
            
            completeBlock(responseObject, nil);
            
        }
    } ];
    
    return task;
}

- (NSURLSessionDataTask *)requestSpeechWithNId:(NSNumber *)nId
                                         Pages:(NSNumber *)pages
                                          size:(NSNumber *)size
                                 completeBlock:(SCSpeechDidCompleteBlock)completeBlock {
    
    NSDictionary *parameters = @{@"nId": nId, @"pno": pages, @"psize": size};
    
    NSURLSessionDataTask *task = [self post:API_Speech parameters:parameters completeBlock:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
        
        if (!error) {
            
            completeBlock(responseObject, nil);
            
        }
    } ];
    
    return task;
    
}


@end

