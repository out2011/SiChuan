//
//  ApiManager+Push.m
//  sichuan
//
//  Created by Lu.L on 16/2/24.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import "ApiManager+Push.h"

@implementation ApiManager (Push)

- (NSURLSessionDataTask *)requestPushMsgWithNid:(NSNumber *)nid type:(NSString *)type completeBlock:(SCPushMsgDidCompleteBlock)completeBlock {
    
    
    NSDictionary *parameters = @{@"nid": nid, @"type": type};
    
    NSURLSessionDataTask *task = [self post:API_pushMsg parameters:parameters completeBlock:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
        
        if (!error) {
            
            completeBlock(responseObject, nil);
            
        }
    } ];
    
    return task;
}

@end
