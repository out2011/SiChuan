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
    
    NSURLSessionDataTask *task = [self post:API_Situation parameters:parameters completeBlock:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
        
        if (!error) {
            
            //            NSLog(@"result: %@", responseObject);
            completeBlock(responseObject, nil);
            
        }
    } ];
    
    return task;
}

- (NSURLSessionDataTask *)requestPositionWithPname:(NSString *)pname
                                     completeBlock:(SCPositionDidCompleteBlock)completeBlock {
    
    NSDictionary *parameters = @{@"pname": pname};
    
    NSURLSessionDataTask *task = [self post:API_Position parameters:parameters completeBlock:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
        
        if (!error) {
            
            //            NSLog(@"result: %@", responseObject);
            completeBlock(responseObject, nil);
            
        }
    } ];
    
    return task;
}
@end
